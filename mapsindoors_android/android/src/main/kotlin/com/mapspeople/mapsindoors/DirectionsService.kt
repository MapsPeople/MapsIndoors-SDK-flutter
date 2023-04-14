package com.mapspeople.mapsindoors

import android.content.Context
import com.google.gson.Gson
import com.mapsindoors.core.MPDirectionsService
import com.mapsindoors.core.MPPoint
import com.mapspeople.mapsindoors.models.MPError
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.*
import kotlin.collections.HashMap

class DirectionsService(private val context: Context, binaryMessenger: BinaryMessenger) : MethodCallHandler {
    private var directionsServiceChannel = MethodChannel(binaryMessenger, "DirectionsServiceMethodChannel")
    private var mpDirectionsService = MPDirectionsService(context)
    private val gson = Gson()

    init {
        directionsServiceChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        fun <T> arg(name: String) : T? = call.argument<T>(name)
        val method = call.method.drop(4)
        when (method) {
            "create" -> {
                mpDirectionsService = MPDirectionsService(context)
                result.success("success")
            }
            "addAvoidWayType" -> {
                mpDirectionsService.addAvoidWayType(arg<String>("wayType") as String)
                result.success("success")
            }
            "clearWayType" -> {
                mpDirectionsService.clearWayType()
                result.success("success")
            }
            "setIsDeparture" -> {
                mpDirectionsService.setIsDeparture(arg<Boolean>("isDeparture") as Boolean)
                result.success("success")
            }
            "getRoute" -> {
                mpDirectionsService.setRouteResultListener { route, error ->
                    result.success(mapOf("route" to gson.toJson(route), "error" to gson.toJson(MPError.fromMIError(error))))
                }
                val origin = gson.fromJson(arg<String>("origin"), MPPoint::class.java)
                val destination = gson.fromJson(arg<String>("destination"), MPPoint::class.java)
                if (origin != null && destination != null) {
                    mpDirectionsService.query(origin, destination)
                }
            }
            "setTravelMode" -> {
                mpDirectionsService.setTravelMode(arg<String>("travelMode") as String)
                result.success("success")
            }
            "setTime" -> {
                val date = Date()
                date.time = (arg<Int>("time") as Int).toLong()
                mpDirectionsService.setTime(date)
                result.success("success")
            }
        }
    }
}