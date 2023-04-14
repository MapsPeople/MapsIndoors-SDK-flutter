package com.mapspeople.mapsindoors.models

import com.google.android.gms.maps.CameraUpdate as GMCameraUpdate
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.model.LatLngBounds
import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPPoint
import com.mapsindoors.googlemaps.converters.toLatLng
import com.mapspeople.mapsindoors.models.CameraUpdateMode.*


data class CameraUpdate(
    @SerializedName("mode") private val modeString : String,
    @SerializedName("point") val point : MPPoint?,
    @SerializedName("bounds") val bounds : Bounds?,
    @SerializedName("padding") val padding : Int?,
    @SerializedName("width") val width : Int?,
    @SerializedName("height") val height : Int?,
    @SerializedName("zoom") val zoom : Float?,
    @SerializedName("position") val position : CameraPosition?,
) {
    val mode : CameraUpdateMode
        get() {
            return CameraUpdateMode.fromString(modeString)
        }
    
    fun toGMCameraUpdate() : GMCameraUpdate = when (mode) {
        FROMPOINT -> CameraUpdateFactory.newLatLng(point!!.latLng.toLatLng())
        
        FROMBOUNDS -> if (width != null && height != null) {
                CameraUpdateFactory.newLatLngBounds(LatLngBounds(bounds!!.southWest.latLng.toLatLng(), bounds!!.northEast.latLng.toLatLng()), width, height, padding!!)
            } else {
                CameraUpdateFactory.newLatLngBounds(LatLngBounds(bounds!!.southWest.latLng.toLatLng(), bounds!!.northEast.latLng.toLatLng()), padding!!)
            }
        
        ZOOMBY -> CameraUpdateFactory.zoomBy(zoom!!)
        
        ZOOMTO -> CameraUpdateFactory.zoomTo(zoom!!)
        
        FROMCAMERAPOSITION -> CameraUpdateFactory.newCameraPosition(position!!.toGMCameraPosition())
             
    }


}


enum class CameraUpdateMode(val mode: String) {
    FROMPOINT("fromPoint"), FROMBOUNDS("fromBounds"), ZOOMBY("zoomBy"), ZOOMTO("zoomTo"), FROMCAMERAPOSITION("fromCameraPosition");

    companion object {
        fun fromString(value : String) : CameraUpdateMode {
            return when (value) {
                "fromPoint" -> FROMPOINT
                "fromBounds" -> FROMBOUNDS
                "zoomBy" -> ZOOMBY
                "zoomTo" -> ZOOMTO
                "fromCameraPosition" -> FROMCAMERAPOSITION
                else -> throw IllegalArgumentException()
            }
        }
    }
}