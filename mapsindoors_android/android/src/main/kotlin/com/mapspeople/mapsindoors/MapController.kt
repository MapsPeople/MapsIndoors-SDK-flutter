package com.mapspeople.mapsindoors

import android.content.Context
import android.graphics.Typeface
import android.view.View
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.CameraUpdate as GMCameraUpdate
import com.google.android.gms.maps.GoogleMap.CancelableCallback
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.mapsindoors.core.*
import com.mapsindoors.core.models.MPCameraEventListener
import com.mapsindoors.core.models.MPMapStyle
import com.mapsindoors.googlemaps.MPMapConfig
import com.mapspeople.mapsindoors.models.Filter
import com.mapspeople.mapsindoors.models.MPError
import com.mapspeople.mapsindoors.models.MapBehavior
import com.mapspeople.mapsindoors.models.Location
import com.mapspeople.mapsindoors.models.CameraPosition
import com.mapspeople.mapsindoors.models.toCameraPosition
import com.mapspeople.mapsindoors.models.CameraUpdate
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.lang.reflect.Type
import com.google.android.gms.maps.MapView as GMView


class MapController(private val context: Context, binaryMessenger: BinaryMessenger) : MethodCallHandler {
    private var mGoogleMap: GoogleMap? = null
    private val channel : MethodChannel = MethodChannel(binaryMessenger, "MapControlMethodChannel")
    private val listenerChannel : MethodChannel = MethodChannel(binaryMessenger, "MapControlListenerMethodChannel")
    private val floorSelectorChannel : MethodChannel = MethodChannel(binaryMessenger, "MapControlFloorSelectorChannel")
    private var mMap : MapView? = null
    private var mMapControl : MapControl? = null
    private val gson = Gson()
    private val mDirectionsRenderer: DirectionsRenderer = DirectionsRenderer(context, binaryMessenger)

    private inline fun <reified T> type(): Type = object: TypeToken<T>() {}.type

    private val floorSelectorInterface = object : MPFloorSelectorInterface {
        var autoFloorChange = true
        var listener : OnFloorSelectionChangedListener? = null
        override fun getView(): View? {
            return null
        }

        override fun setOnFloorSelectionChangedListener(p0: OnFloorSelectionChangedListener?) {
            listener = p0
        }

        override fun setList(p0: MutableList<MPFloor>?) {
            val ret = if (p0 == null) null else gson.toJson(p0)
            floorSelectorChannel.invokeMethod("setList", ret)
        }

        override fun show(p0: Boolean, p1: Boolean) {
            floorSelectorChannel.invokeMethod("show", mapOf("show" to p0, "animate" to p1))
        }

        override fun setSelectedFloor(p0: MPFloor) {
            floorSelectorChannel.invokeMethod("setSelectedFloor", gson.toJson(p0))
        }

        override fun setSelectedFloorByZIndex(p0: Int) {
            floorSelectorChannel.invokeMethod("setSelectedFloorByZIndex", p0)
        }

        override fun zoomLevelChanged(p0: Float) {
            floorSelectorChannel.invokeMethod("zoomLevelChanged", p0.toDouble())
        }

        override fun isAutoFloorChangeEnabled(): Boolean {
            return autoFloorChange
        }

        override fun setUserPositionFloor(p0: Int) {
            floorSelectorChannel.invokeMethod("setUserPositionFloor", p0)
        }
    }

    init {
        channel.setMethodCallHandler(this::onMethodCall)
        listenerChannel.setMethodCallHandler(this::onListenerCall)
        floorSelectorChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "FSE_onFloorChanged" -> {
                    floorSelectorInterface.listener?.onFloorSelectionChanged(gson.fromJson(call.argument<String>("floor"), MPFloor::class.java))
                }
                else -> result.notImplemented()
            }
        }
    }

    fun setMap(map: MapView) {
        mMap = map
        mMap?.setOnDisposeListener(object : OnDisposeListener {
            override fun onDisposed() {
                mMapControl?.onDestroy()
                mMapControl = null
            }
        })
    }

    private fun initMapControl(call: MethodCall, result: MethodChannel.Result) {
        if (mMapControl != null) {
            result.success(null)
            return;
        }
        if (mMap != null) {
            (mMap?.view as GMView).getMapAsync {
                mGoogleMap = it
                val map : HashMap<String?, Any?> = gson.fromJson(call.argument<String>("config"), type<HashMap<String?, Any?>>())

                val useDefaultMapsIndoorsStyle = (map["useDefaultMapsIndoorsStyle"] as Boolean?) ?: true
                val builder : MPMapConfig.Builder = MPMapConfig.Builder(context, it,
                    context.getString(R.string.google_maps_key), mMap?.view as GMView, useDefaultMapsIndoorsStyle)

                if (map.containsKey("typeface")) {
                    builder.setMapLabelFont(
                        Typeface.create(map["typeface"] as String, Typeface.NORMAL),
                        map["color"] as String, map["showHalo"] as Boolean)
                }
                if (map.containsKey("textSize")) {
                    builder.setMapLabelTextSize((map["textSize"] as Double).toInt())
                }
                if (map.containsKey("showFloorSelector")) {
                    builder.setShowFloorSelector(map["showFloorSelector"] as Boolean)
                }
                if (map.containsKey("showInfoWindowOnLocationClicked")) {
                    builder.setShowInfoWindowOnLocationClicked(
                        map["showInfoWindowOnLocationClicked"] as Boolean)
                }
                if (map.containsKey("showUserPosition")) {
                    builder.setShowUserPosition(map["showUserPosition"] as Boolean)
                }
                if (map.containsKey("tileFadeInEnabled")) {
                    builder.setTileFadeInEnabled(map["tileFadeInEnabled"] as Boolean)
                }

                MapControl.create(builder.build()) { mc, e ->
                    if (e == null && mc != null) {
                        mDirectionsRenderer.setMapControl(mc)
                        mMapControl = mc
                        mMapControl?.hideFloorSelector(true)
                        result.success(null)
                    } else if (e != null) {
                        result.success(MPError.fromMIError(e))
                    }
                }
            }
        } else {
            result.error(
                "40",
                "Could not create MapControl, map has not been initialized",
                "build MapsIndoorsWidget before calling MapControl.create"
            )
        }
    }

    private fun setupFloorSelector(autoFloorChangeEnabled: Boolean) {
        floorSelectorInterface.autoFloorChange = autoFloorChangeEnabled
        mMapControl?.floorSelector = floorSelectorInterface
        mMapControl?.hideFloorSelector(false)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        fun error(code: String = "-1", message: String? = "Argument was null", details: Any? = null) = result.error(code, message, details)

        fun success(ret : Any? = "success") = result.success(ret)

        fun <T> arg(name: String) : T? = call.argument<T>(name)

        val method = call.method.drop(4)

        when (method) {
            "create" -> initMapControl(call, result)
            "selectFloor" -> {
                val floor : Int = arg<Int>("floorIndex") as Int
                try {
                    mMapControl?.selectFloor(floor)
                    success()
                } catch (e: Exception) {
                    error("-1", e.message, call.method)
                }
            }
            "clearFilter" -> {
                mMapControl?.clearFilter()
                success()
            }
            "deSelectLocation" -> {
                mMapControl?.deSelectLocation()
                success()
            }
            "getCurrentBuilding" -> {
                success(gson.toJson(mMapControl?.currentBuilding))
            }
            "getCurrentBuildingFloor" -> {
                success(gson.toJson(mMapControl?.currentBuildingFloor))
            }
            "getCurrentFloorIndex" -> {
                success(mMapControl?.currentFloorIndex)
            }
            "setFloorSelector" -> {
                setupFloorSelector(arg<Boolean>("isAutoFloorChangeEnabled") ?: true)
                success()
            }
            "getCurrentMapsIndoorsZoom" -> {
                success(mMapControl?.currentMapsIndoorsZoom)
            }
            "getCurrentVenue" -> {
                success(gson.toJson(mMapControl?.currentVenue))
            }
            "getMapStyle" -> {
                success(gson.toJson(mMapControl?.mapStyle))
            }
            "getMapViewPaddingBottom" -> {
                success(mMapControl?.mapViewPaddingBottom)
            }
            "getMapViewPaddingEnd" -> {
                success(mMapControl?.mapViewPaddingEnd)
            }
            "getMapViewPaddingStart" -> {
                success(mMapControl?.mapViewPaddingStart)
            }
            "getMapViewPaddingTop" -> {
                success(mMapControl?.mapViewPaddingTop)
            }
            "goTo" -> {
                val json: String? = arg<String>("entity")
                if (json == null) {
                    success()
                    return
                }
                val entity : MPEntity?
                try {
                    when (arg<String>("type")) {
                        "MPLocation" -> {
                            entity = gson.fromJson(json, Location::class.java).toMPLocation()
                        }
                        "MPFloor" -> {
                            entity = gson.fromJson(json, MPFloor::class.java)
                        }
                        "MPBuilding" -> {
                            entity = gson.fromJson(json, MPBuilding::class.java)
                        }
                        "MPVenue" -> {
                            entity = gson.fromJson(json, MPVenue::class.java)
                        }
                        else -> {
                            result.error("-1", "Not a mapsIndoors entity", call.method)
                            return
                        }
                    }
                } catch (e: Exception) {
                    error("-1", e.message)
                    return
                }
                mMapControl?.goTo(entity)
                success()
            }
            "hideFloorSelector" -> {
                mMapControl?.hideFloorSelector(arg<Boolean>("hide") as Boolean)
                success()
            }
            "isFloorSelectorHidden" -> {
                success(mMapControl?.isFloorSelectorHidden)
            }
            "isUserPositionShown" -> {
                success(mMapControl?.isUserPositionShown)
            }
            "selectBuilding" -> {
                val building = gson.fromJson(arg("building") as String?, MPBuilding::class.java)
                val moveCamera = arg<Boolean>("moveCamera")
                if (building != null && moveCamera != null) {
                    mMapControl?.selectBuilding(building, moveCamera)
                    success()
                } else {
                    error("-1", "parameters are null", call.method)
                }
            }
            "selectLocation" -> {
                val location = MapsIndoors.getLocationById(arg<String>("location"))
                val behavior = gson.fromJson(arg("behavior") as String?, MapBehavior::class.java)
                if (behavior != null) {
                    mMapControl?.selectLocation(location, behavior.toMPSelectionBehavior())
                    success()
                } else {
                    error("-1", "behavior is null", call.method)
                }
            }
            "selectLocationById" -> {
                val id = arg<String>("id")
                val behavior = gson.fromJson(arg<String>("behavior"), MapBehavior::class.java)
                if (id != null && behavior != null) {
                    mMapControl?.selectLocation(id, behavior.toMPSelectionBehavior())
                    success("success")
                } else {
                    error("-1", "parameters are null", call.method)
                }
            }
            "selectVenue" -> {
                val venue = gson.fromJson(arg("venue") as String?, MPVenue::class.java)
                val moveCamera = arg<Boolean>("moveCamera")
                if (venue != null && moveCamera != null) {
                    mMapControl?.selectVenue(venue, moveCamera)
                    success("success")
                } else {
                    error("-1", "parameters are null", call.method)
                }
            }
            "setFilter" -> {
                val filter = gson.fromJson(arg<String>("filter"), Filter::class.java)
                val behavior = gson.fromJson(arg<String>("behavior"), MapBehavior::class.java)
                if (filter != null && behavior != null) {
                    mMapControl?.setFilter(filter.toMPFilter(), behavior.toMPFilterBehavior(), object : MPSuccessListener {
                        override fun onSuccess() {
                            success()
                        }
                        override fun onFailure() {
                            error("-1", "could not set filter", null)
                        }
                    })
                } else {
                    error("-1", "parameters are null", call.method)
                }
            }
            "setFilterWithLocations" -> {
                val locationIds = arg<List<String>>("locations") as List<String>?
                val locations : MutableList<MPLocation> = mutableListOf()
                for (id in locationIds!!){
                    locations.add(MapsIndoors.getLocationById(id)!!)
                }
                val behavior = gson.fromJson(arg<String>("behavior"), MapBehavior::class.java)
                if (locations != null && behavior != null) {
                    mMapControl?.setFilter(locations, behavior.toMPFilterBehavior())
                    success()
                } else {
                    error("-1", "parameters are null", call.method)
                }
            }
            "setMapPadding" -> {
                val start = arg<Int>("start")
                val top = arg<Int>("top")
                val end = arg<Int>("end")
                val bottom = arg<Int>("bottom")
                if (start != null && top != null && end != null && bottom != null) {
                    mMapControl?.setMapPadding(start, top, end, bottom)
                    success()
                } else {
                    error("-1", "Some arguements were null", call.method)
                }
            }
            "setMapStyle" -> {
                val mapStyle = gson.fromJson(arg<String>("mapStyle"), MPMapStyle::class.java)
                if (mapStyle != null) {
                    mMapControl?.mapStyle = mapStyle
                    success()
                } else {
                    error("-1", "some arguments were null", call.method)
                }
            }
            "showInfoWindowOnClickedLocation" -> {
                val should = arg<Boolean>("show")
                if (should != null) {
                    mMapControl?.showInfoWindowOnClickedLocation(should)
                    success()
                } else {
                    error("-1", "some arguments were null", call.method)
                }
            }
            "showUserPosition" -> {
                val should = arg<Boolean>("show")
                if (should != null) {
                    mMapControl?.showUserPosition(should)
                    success()
                } else {
                    error("-1", "some arguments were null", call.method)
                }
            }
            "enableLiveData" -> {
                val hasListener = arg<Boolean>("listener")
                val domainType = arg<String>("domainType")
                if (hasListener == true) {
                    val listener = OnLiveLocationUpdateListener { 
                        listenerChannel.invokeMethod("onLiveLocationUpdate", mapOf("location" to it, "domainType" to domainType))
                    }
                    mMapControl?.enableLiveData(domainType, listener)
                } else {
                    mMapControl?.enableLiveData(domainType)
                }
                success()
            }
            "disableLiveData" -> {
                val domainType = arg<String>("domainType")
                if (domainType != null) {
                    mMapControl?.disableLiveData(domainType)
                }
                success()
            }
            "moveCamera", "animateCamera" -> {
                val update : GMCameraUpdate = gson.fromJson<CameraUpdate>(arg<String>("update"), CameraUpdate::class.java)!!.toGMCameraUpdate()
                val duration : Int? = arg<Int>("duration")

                if (call.method == "moveCamera") {
                    mGoogleMap?.moveCamera(update)
                    success()
                } else if (duration != null) {
                    mGoogleMap?.animateCamera(update, duration, object : CancelableCallback {
                    override fun onCancel() = success()
                    override fun onFinish() = success()
                })
                } else {
                    mGoogleMap?.animateCamera(update)
                    success()
                }
            }
            "getCurrentCameraPosition" -> {
                success(gson.toJson(mGoogleMap?.cameraPosition?.toCameraPosition()))
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private var cameraListener : MPCameraEventListener? = null
    private var floorUpdateListener : OnFloorUpdateListener? = null

    private fun onListenerCall(call: MethodCall, result: MethodChannel.Result) {
        val setup = call.argument<Boolean?>("setupListener")
        if (setup == null) {
            result.error("-1", "Cannot modify listener when setup is $setup", null)
            return
        }
        val consumeEvent = call.argument<Boolean?>("consumeEvent")

        val method = call.method.drop(4)

        when (method) {
            "cameraEventListener" -> {
                if (setup) {
                    cameraListener = MPCameraEventListener {
                        listenerChannel.invokeMethod("onCameraEvent", it.ordinal)
                    }.also {
                        mMapControl?.addOnCameraEventListener(it)
                    }
                } else {
                    cameraListener?.let {
                        mMapControl?.removeOnCameraEventListener(it)
                    }
                }
            }
            "floorUpdateListener" -> {
                if (setup) {
                    floorUpdateListener = OnFloorUpdateListener { building, floor ->
                        listenerChannel.invokeMethod("onFloorUpdate", mapOf("building" to gson.toJson(building), "floor" to floor))
                    }.also {
                        mMapControl?.addOnFloorUpdateListener(it)
                    }
                } else {
                    floorUpdateListener?.let {
                        mMapControl?.removeOnFloorUpdateListener(it)
                    }
                }
            }
            "buildingFoundAtCameraTargetListener" -> {
                if (setup) {
                    mMapControl?.setOnCurrentBuildingChangedListener {
                        listenerChannel.invokeMethod("onBuildingFoundAtCameraTarget", gson.toJson(it))
                    }
                } else {
                    mMapControl?.setOnCurrentBuildingChangedListener(null)
                }
            }
            "venueFoundAtCameraTargetListener" -> {
                if (setup) {
                    mMapControl?.setOnCurrentVenueChangedListener {
                        listenerChannel.invokeMethod("onVenueFoundAtCameraTarget", gson.toJson(it))
                    }
                } else {
                    mMapControl?.setOnCurrentVenueChangedListener(null)
                }
            }
            "locationClusterClickListener" -> {
                if (setup) {
                    mMapControl?.setOnLocationClusterClickListener { latLng, locations ->
                        val point = gson.toJson(MPPoint(latLng))
                        val locs = gson.toJson(locations)
                        listenerChannel.invokeMethod("onLocationClusterClick", mapOf("locations" to locs, "point" to point))
                        return@setOnLocationClusterClickListener consumeEvent != null
                    }
                } else {
                    mMapControl?.setOnLocationClusterClickListener(null)
                }
            }
            "locationSelectedListener" -> {
                if (setup) {
                    mMapControl?.setOnLocationSelectedListener {
                        listenerChannel.invokeMethod("onLocationSelected", gson.toJson(it))
                        return@setOnLocationSelectedListener consumeEvent != null
                    }
                } else {
                    mMapControl?.setOnLocationSelectedListener(null)
                }
            }
            "mapClickListener" -> {
                if (setup) {
                    mMapControl?.setOnMapClickListener { latLng, locations ->
                        val point = gson.toJson(MPPoint(latLng))
                        val locs = gson.toJson(locations)
                        CoroutineScope(Dispatchers.Main).launch {
                            listenerChannel.invokeMethod("onMapClick", mapOf("locations" to locs, "point" to point))
                        }
                        return@setOnMapClickListener consumeEvent != null
                    }
                } else {
                    mMapControl?.setOnMapClickListener(null)
                }
            }
            "markerClickListener" -> {
                if (setup) {
                    mMapControl?.setOnMarkerClickListener {
                        listenerChannel.invokeMethod("onMarkerClick", it?.id)
                        return@setOnMarkerClickListener consumeEvent != null
                    }
                } else {
                    mMapControl?.setOnMarkerClickListener(null)
                }
            }
            "markerInfoWindowClickListener" -> {
                if (setup) {
                    mMapControl?.setOnMarkerInfoWindowClickListener {
                        listenerChannel.invokeMethod("onInfoWindowClick", it?.id)
                    }
                } else {
                    mMapControl?.setOnMarkerInfoWindowClickListener(null)
                }
            }
            "markerInfoWindowCloseListener" -> {
                if (setup) {
                    mMapControl?.setOnMarkerInfoWindowCloseListener {
                        listenerChannel.invokeMethod("onInfoWindowClose", it?.id)
                    }
                } else {
                    mMapControl?.setOnMarkerInfoWindowCloseListener(null)
                }
            }
            "willUpdateLocationsOnMap" -> {
                if (setup) {
                    mMapControl?.setOnWillUpdateLocationsOnMap {
                        listenerChannel.invokeMethod("willUpdateLocationsOnMap", gson.toJson(it))
                    }
                } else {
                    mMapControl?.setOnWillUpdateLocationsOnMap(null)
                }
            }
        }
    }
}