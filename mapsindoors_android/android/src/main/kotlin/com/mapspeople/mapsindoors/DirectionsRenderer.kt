package com.mapspeople.mapsindoors

import android.content.Context
import android.graphics.Color
import com.google.gson.Gson
import com.mapsindoors.core.MPCameraViewFitMode
import com.mapsindoors.core.MPDirectionsRenderer
import com.mapsindoors.core.MPRoute
import com.mapsindoors.core.MapControl
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class DirectionsRenderer(private val context: Context, binaryMessenger: BinaryMessenger) : MethodCallHandler {
    private val directionsRendererChannel = MethodChannel(binaryMessenger, "DirectionsRendererMethodChannel")
    private var mpDirectionsRenderer: MPDirectionsRenderer? = null
    private var mMapControl: MapControl? = null

    init {
        directionsRendererChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method = call.method.drop(4)
        when (method) {
            "clear" -> {
                mpDirectionsRenderer?.clear()
                result.success("success")
            }
            "getSelectedLegFloorIndex" -> {
                var selectedLegFloorIndex = mpDirectionsRenderer?.selectedLegFloorIndex
                result.success(selectedLegFloorIndex)
            }
            "nextLeg" -> {
                mpDirectionsRenderer?.nextLeg()
                result.success("success")
            }
            "previousLeg" -> {
                mpDirectionsRenderer?.previousLeg()
                result.success("success")
            }
            "selectLegIndex" -> {
                val int = call.argument<Int?>("legIndex")
                if (int != null) {
                    try {
                        mpDirectionsRenderer?.selectLegIndex(int)
                    } catch (e: java.lang.IllegalStateException) {
                        result.error("-1", e.message, call.method)
                    }
                }
                result.success("success")
            }
            "setAnimatedPolyline" -> {
                val animated = call.argument<Boolean?>("animated")
                val repeated = call.argument<Boolean?>("repeating")
                val durationMs = call.argument<Int?>("durationMs")
                if (animated != null && repeated != null && durationMs != null) {
                    mpDirectionsRenderer?.setAnimatedPolyline(animated, repeated, durationMs)
                }
                result.success("success")
            }
            "setCameraAnimationDuration" -> {
                val durationMs = call.argument<Int?>("durationMs")
                if (durationMs != null) {
                    mpDirectionsRenderer?.setCameraAnimationDuration(durationMs)
                }
                result.success("success")
            }
            "setCameraViewFitMode" -> {
                val cameraFitMode = call.argument<Int?>("cameraFitMode")
                var cameraFitModeEnum: MPCameraViewFitMode? = null
                when (cameraFitMode) {
                    0 -> cameraFitModeEnum = MPCameraViewFitMode.NORTH_ALIGNED
                    1 -> cameraFitModeEnum = MPCameraViewFitMode.FIRST_STEP_ALIGNED
                    2 -> cameraFitModeEnum = MPCameraViewFitMode.START_TO_END_ALIGNED
                    else -> {
                        result.error("-1", "$cameraFitMode is not supported", call.method)
                        return
                    }
                }
                mpDirectionsRenderer?.setCameraViewFitMode(cameraFitModeEnum)
                result.success("success")
            }
            "setOnLegSelectedListener" -> {
                mpDirectionsRenderer?.setOnLegSelectedListener {
                    directionsRendererChannel.invokeMethod("onLegSelected", it)
                }
                result.success("success")
            }
            "setPolyLineColors" -> {
                val foreground: Int
                val background: Int
                try {
                    foreground = Color.parseColor(call.argument<String>("foreground"))
                    background = Color.parseColor(call.argument<String>("background"))
                } catch(e: java.lang.IllegalArgumentException) {
                    result.error("-1", "${e.message}: ${call.argument<String>("foreground")}, ${call.argument<String>("background")}", call.method)
                    return
                }
                mpDirectionsRenderer?.setPolylineColors(foreground, background)
                result.success("success")
            }
            "setRoute" -> {
                val gson = Gson()
                val route = gson.fromJson(call.argument<String>("route"), MPRoute::class.java)
                mpDirectionsRenderer?.setRoute(route)
                result.success("success")
            }
            "useContentOfNearbyLocations" -> {
                result.success("success")
            }
        }
    }

    fun setMapControl(mapControl: MapControl) {
        mMapControl = mapControl
        mpDirectionsRenderer = MPDirectionsRenderer(mapControl)
    }
}