package com.mapspeople.mapsindoors.models

import com.mapsindoors.core.models.MPCameraPosition
import com.google.android.gms.maps.model.CameraPosition as GMCameraPosition
import com.mapsindoors.googlemaps.converters.toLatLng
import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPPoint

data class CameraPosition(
    @SerializedName("zoom") val zoom: Float?,
    @SerializedName("tilt") val tilt: Float?,
    @SerializedName("bearing") val bearing: Float?,
    @SerializedName("target") val target: MPPoint?
) {
    fun toGMCameraPosition() : GMCameraPosition {
        return GMCameraPosition.builder().bearing(bearing!!).target(target!!.latLng.toLatLng()).tilt(tilt!!).zoom(zoom!!).build()
    }

    companion object {
        internal fun fromGMCameraPosition(position: GMCameraPosition) : CameraPosition {
            return CameraPosition(
                zoom = position.zoom, 
                tilt = position.tilt, 
                bearing = position.bearing, 
                target = MPPoint(position.target.latitude, position.target.longitude)
                )
        }
    }
}

fun GMCameraPosition.toCameraPosition() : CameraPosition = CameraPosition.fromGMCameraPosition(this)