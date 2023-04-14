package com.mapspeople.mapsindoors

import android.app.Application
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.mapsindoors.core.*
import com.mapspeople.mapsindoors.models.*

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.reflect.Type

/** MapsindoorsPlugin */
class MapsindoorsPlugin : FlutterPlugin {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var mapsIndoorsChannel: MethodChannel
    private lateinit var utilChannel: MethodChannel
    private lateinit var listenerChannel: MethodChannel
    private lateinit var context: Application
    private lateinit var mMapController: MapController
    private lateinit var mDisplayRuleHandler: DisplayRuleHandler
    private var positionProvider: PositionProvider? = null
    private lateinit var mDirectionsService: DirectionsService
    private val gson = Gson()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        mapsIndoorsChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "MapsIndoorsMethodChannel")
        mapsIndoorsChannel.setMethodCallHandler(this::handleMapsIndoorsChannel)
        utilChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "UtilMethodChannel")
        utilChannel.setMethodCallHandler(this::handleUtilChannel)
        listenerChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "MapsIndoorsListenerChannel")
        listenerChannel.setMethodCallHandler(this::handleListenerChannel)
        mMapController = MapController(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
        mDisplayRuleHandler = DisplayRuleHandler(flutterPluginBinding.binaryMessenger)
        mDirectionsService = DirectionsService(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)

        MapViewFactory.setOnViewCreated(object : OnViewCreatedListener {
            override fun onViewCreated(view: MapView) {
                mMapController.setMap(view)
            }
        })

        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "<map-view>",
            MapViewFactory()
        )
        context = flutterPluginBinding.applicationContext as Application
    }

    private inline fun <reified T> type(): Type = object: TypeToken<T>() {}.type

    private fun handleMapsIndoorsChannel(call: MethodCall, result: Result) {

        fun error(code: String = "-1", message: String? = "Argument was null", details: Any? = null) = result.error(code, message, details)

        fun success(ret : Any? = "success") = result.success(ret)

        fun <T> arg(name: String) : T? = call.argument<T>(name)

        val method = call.method.drop(4)
        when (method) {
            "initialize" -> {
                val key = arg<String>("key")
                if (key == null) {
                    error()
                    return
                }
                MapsIndoors.load(context, key) { error ->
                    success(if (error == null) null else gson.toJson(MPError.fromMIError(error)))
                }
            }
            "locationDisplayRuleExists" -> {
                val loc = MapsIndoors.getLocationById(arg<String?>("id"))
                if (loc != null) {
                    success(true)
                } else {
                    error()
                }
            }
            "displayRuleNameExists" -> {
                success(MapsIndoors.getDisplayRule(arg<String?>("name")!!)?.id != null)
            }
            "checkOfflineDataAvailability" -> {
                success(MapsIndoors.checkOfflineDataAvailability())
            }
            "destroy" -> {
                MapsIndoors.destroy()
                success()
            }
            "disableEventLogging" -> {
                MapsIndoors.disableEventLogging(arg<Boolean>("disable") as Boolean)
                success()
            }
            "getAPIKey" -> {
                success(MapsIndoors.getAPIKey())
            }
            "getAvailableLanguages" -> {
                success(MapsIndoors.getAvailableLanguages())
            }
            "getBuildings" -> {
                val buildings = MapsIndoors.getBuildings()?.buildings
                success(if (buildings != null) gson.toJson(buildings) else null)
            }
            "getCategories" -> {
                val categories = MapsIndoors.getCategories()?.categories
                success(if (categories != null) gson.toJson(categories) else null)
            }
            "getDataSet" -> {
                val dataset = MapsIndoors.getDataSet()
                success(if (dataset != null) gson.toJson(dataset) else null)
            }
            "getDefaultLanguage" -> {
                success(MapsIndoors.getDefaultLanguage())
            }
            "getLanguage" -> {
                success(MapsIndoors.getLanguage())
            }
            "getLocationById" -> {
                val location = MapsIndoors.getLocationById(arg<String>("id"))
                success(if (location != null) gson.toJson(location) else null)
            }
            "getLocations" -> {
                success(gson.toJson(MapsIndoors.getLocations()))
            }
            "getLocationsByExternalIds" -> {
                val ids = arg<List<String>>("ids")!!
                success(gson.toJson(MapsIndoors.getLocationsByExternalIds(ids)))
            }
            "getLocationsByQuery" -> {
                val filter = gson.fromJson(arg<String?>("filter"), Filter::class.java)?.toMPFilter()
                val query = gson.fromJson(arg<String?>("query"), Query::class.java)?.toMPQuery()
                MapsIndoors.getLocationsAsync(query, filter) { mpLocations, miError ->
                    if (miError == null) {
                        success(gson.toJson(mpLocations))
                    } else {
                        error(miError.message)
                    }
                }
            }
            "getMapStyles" -> {
                success(gson.toJson(MapsIndoors.getMapStyles()))
            }
            "getSolution" -> {
                val solution = MapsIndoors.getSolution()
                success(if (solution != null) gson.toJson(solution) else null)
            }
            "getVenues" -> {
                val venues = MapsIndoors.getVenues()?.venues
                success(if (venues != null) gson.toJson(venues) else null)
            }
            "isAPIKeyValid" -> {
                success(MapsIndoors.isAPIKeyValid())
            }
            "isInitialized" -> {
                success(MapsIndoors.isInitialized())
            }
            "isReady" -> {
                success(MapsIndoors.isReady())
            }
            "setLanguage" -> {
                success(MapsIndoors.setLanguage(arg<String>("language") as String))
            }
            "synchronizeContent" -> {
                MapsIndoors.synchronizeContent {
                    success(if (it == null) null else MPError.fromMIError(it))
                }
            }
            "applyUserRoles" -> {
                val userRoles = gson.fromJson<List<MPUserRole>>(arg<String>("userRoles"), type<List<MPUserRole>>())
                MapsIndoors.applyUserRoles(userRoles)
                success()
            }
            "getAppliedUserRoles" -> {
                val userRoles = MapsIndoors.getAppliedUserRoles()
                success(if(userRoles != null) gson.toJson(userRoles) else null)
            }
            "getUserRoles" -> {
                val userRoles = MapsIndoors.getUserRoles()?.userRoles
                success(if(userRoles != null) gson.toJson(userRoles) else null)
            }
            "reverseGeoCode" -> {
                val point = gson.fromJson(arg<String>("point"), MPPoint::class.java)
                if (point != null) {
                    MapsIndoors.reverseGeoCode(point) {
                        success(if (it != null) gson.toJson(it) else null)
                    }
                }
            }
            "setPositionProvider" -> {
                val remove = arg<Boolean>("remove")
                val name = arg<String?>("name")
                if (remove != null && !remove) {
                    if (name != null) {
                        if (positionProvider == null || positionProvider?.name != name) {
                            positionProvider = PositionProvider(name)
                        }
                        MapsIndoors.setPositionProvider(positionProvider)
                    } else {
                        error()
                        return
                    }
                } else {
                    MapsIndoors.setPositionProvider(null)
                }
                success()
            }
            "getDefaultVenue" -> {
                success(gson.toJson(MapsIndoors.getVenues()?.getDefaultVenue()))
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun handleUtilChannel(call: MethodCall, result: Result) {

        fun error(code: String = "-1", message: String? = "Argument was null", details: Any? = null) = result.error(code, message, details)

        fun success(ret : Any? = "success") = result.success(ret)

        fun getSolutionConfig() : MPSolutionConfig? = MapsIndoors.getSolution()?.config

        fun <T> arg(name: String) : T? = call.argument<T>(name)

        val method = call.method.drop(4)

        when (method) {
            "getPlatformVersion" -> {
                success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "venueHasGraph" -> {
                val hasGraph = MapsIndoors.getVenues()?.getVenueById(arg<String>("id"))?.hasGraph()
                success(hasGraph ?: false)
            }
            "pointAngleBetween" -> {
                try {
                    val it = gson.fromJson(arg<String>("it"), MPPoint::class.java)
                    val other = gson.fromJson(arg<String>("other"), MPPoint::class.java)
                    val angle = it.angleBetween(other)
                    success(angle)
                } catch (e: java.lang.Exception) {
                    error("20", e.message, "Could not complete \"pointAngleBetween\" method")
                }
            }
            "pointDistanceTo" -> {
                try {
                    val it = gson.fromJson(arg<String>("it"), MPPoint::class.java)
                    val other = gson.fromJson(arg<String>("other"), MPPoint::class.java)
                    val distance = it.distanceTo(other)
                    success(distance)
                } catch (e: java.lang.Exception) {
                    error("404", e.message, "Could not complete \"pointDistanceTo\" method")
                }
            }
            "geometryIsInside" -> {
                try {
                    val point = gson.fromJson(arg<String>("point"), MPPoint::class.java)
                    val geo = gson.fromJson(arg<String>("it"), MPGeometry::class.java)
                    when (geo.type) {
                        "MPPoint" -> {
                            val it = gson.fromJson(arg<String>("it"), MPPoint::class.java)
                            success(it.isInside(point.latLng))
                        }
                        "MPPolygon" -> {
                            val it = gson.fromJson(arg<String>("it"), MPPolygonGeometry::class.java)
                            success(it.isInside(point.latLng))
                        }
                        "MPMultiPolygon" -> {
                            val it = gson.fromJson(arg<String>("it"), MPMultiPolygonGeometry::class.java)
                            success(it.isInside(point.latLng))
                        }
                    }
                } catch (e: java.lang.Exception) {
                    error("404", e.message, "Could not complete \"geometryIsInside\" method")
                }
            }
            "geometryArea" -> {
                try {
                    val geometry = arg<String>("geometry")
                    val gson = Gson()
                    val geo = gson.fromJson(geometry, MPGeometry::class.java)
                    when (geo.type) {
                        "MPPoint" -> {
                            val it = gson.fromJson(geometry, MPPoint::class.java)
                            success(it.area)
                        }
                        "MPPolygon" -> {
                            val it = gson.fromJson(geometry, MPPolygonGeometry::class.java)
                            success(it.area)
                        }
                        "MPMultiPolygon" -> {
                            val it = gson.fromJson(geometry, MPMultiPolygonGeometry::class.java)
                            success(it.area)
                        }
                    }
                } catch (e: java.lang.Exception) {
                    error("404", e.message, "Could not complete \"geometryArea\" method")
                }
            }
            "polygonDistToClosestEdge" -> {
                try {
                    val point = gson.fromJson(arg<String>("point"), MPPoint::class.java)
                    val geo = gson.fromJson(arg<String>("it"), MPGeometry::class.java)
                    when (geo.type) {
                        "MPPolygon" -> {
                            val it = gson.fromJson(arg<String>("it"), MPPolygonGeometry::class.java)
                            success(it.getSquaredDistanceToClosestEdge(point))
                        }
                        "MPMultiPolygon" -> {
                            val it = gson.fromJson(arg<String>("it"), MPMultiPolygonGeometry::class.java)
                            success(it.getSquaredDistanceToClosestEdge(point))
                        }
                    }
                } catch (e: java.lang.Exception) {
                    error("404", e.message, "Could not complete \"polygonDistToClosestEdge\" method")
                }
            }
            "parseMapClientUrl" -> {
                val venueId = arg<String>("venueId")
                val locationId = arg<String>("locationId")
                val solution = MapsIndoors.getSolution()
                if (venueId != null && locationId != null && solution != null) {
                    success(solution.parseMapClientUrl(venueId, locationId))
                } else {
                    error()
                }
            }
            "setCollisionHandling" -> {
                val collisionHandling = MPCollisionHandling.fromStringValue(arg<String>("handling")!!)
                getSolutionConfig()?.setCollisionHandling(collisionHandling)
                success()
            }
            "setEnableClustering" -> {
                val enable = arg<String>("enable")!!.toBoolean()
                getSolutionConfig()?.setEnableClustering(enable)
                success()
            }
            "setExtrusionOpacity" -> {
                val opacity = arg<String>("opacity")!!.toDouble()
                getSolutionConfig()?.settings3D?.setExtrusionOpacity(opacity.toFloat())
                success()
            }
            "setWallOpacity" -> {
                val opacity = arg<String>("opacity")!!.toDouble()
                getSolutionConfig()?.settings3D?.setWallOpacity(opacity.toFloat())
                success()
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private var onMapsIndoorsReadyListener: OnMapsIndoorsReadyListener? = null

    private fun handleListenerChannel(call: MethodCall, result: Result) {
        val method = call.method.drop(4)
        when (method) {
            "onMapsIndoorsReadyListener" -> {
                val setup = call.argument<Boolean>("addListener")
                if (setup == true) {
                    onMapsIndoorsReadyListener = OnMapsIndoorsReadyListener {
                        listenerChannel.invokeMethod("onMapsIndoorsReady", gson.toJson(gson.toJson(MPError.fromMIError(it))))
                    }
                    MapsIndoors.addOnMapsIndoorsReadyListener(onMapsIndoorsReadyListener!!)
                } else {
                    MapsIndoors.removeOnMapsIndoorsReadyListener(onMapsIndoorsReadyListener!!)
                }
            }
            "onPositionUpdate" -> {
                val update = gson.fromJson(call.argument<String>("position"), PositionResult::class.java)
                positionProvider?.updatePosition(update)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        mapsIndoorsChannel.setMethodCallHandler(null)
    }
}
