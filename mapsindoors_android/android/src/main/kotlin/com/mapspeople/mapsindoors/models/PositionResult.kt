package com.mapspeople.mapsindoors.models

import android.location.Location
import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPPoint
import com.mapsindoors.core.MPPositionProvider
import com.mapsindoors.core.MPPositionResultInterface
import com.mapsindoors.core.OnPositionUpdateListener

class PositionResult : MPPositionResultInterface {
    @SerializedName("point")
    private var mPoint: MPPoint? = null
    @SerializedName("floorIndex")
    private var mFloorIndex: Int? = null
    @SerializedName("bearing")
    private var mBearing: Double? = null
    @SerializedName("accuracy")
    private var mAccuracy: Double? = null
    @SerializedName("providerName")
    private var mProviderName: String? = null

    override fun getPoint(): MPPoint? {
        return mPoint
    }

    override fun hasFloor(): Boolean {
        return mFloorIndex != null
    }

    override fun getFloorIndex(): Int {
        return mFloorIndex ?: 0
    }

    override fun setFloorIndex(p0: Int) {
        throw NotImplementedError()
    }

    override fun hasBearing(): Boolean {
        return mBearing != null
    }

    override fun getBearing(): Float {
        return mBearing?.toFloat() ?: 0.0f
    }

    override fun setBearing(p0: Float) {
        throw NotImplementedError()
    }

    override fun hasAccuracy(): Boolean {
        return mAccuracy != null
    }

    override fun getAccuracy(): Float {
        return mAccuracy?.toFloat() ?: 0.0f
    }

    override fun setAccuracy(p0: Float) {
        throw NotImplementedError()
    }

    override fun getProvider(): MPPositionProvider {
        return object : MPPositionProvider {
            override fun addOnPositionUpdateListener(p0: OnPositionUpdateListener) {
                throw NotImplementedError()
            }

            override fun removeOnPositionUpdateListener(p0: OnPositionUpdateListener) {
                throw NotImplementedError()
            }

            override fun getLatestPosition(): MPPositionResultInterface? {
                throw NotImplementedError()
            }

            override fun toString(): String {
                return "$mProviderName"
            }

        }
    }

    override fun setProvider(p0: MPPositionProvider?) {
        throw NotImplementedError()
    }

    override fun getAndroidLocation(): Location? {
        return point?.let { position ->
            val location = Location(mProviderName)
            location.bearing = bearing
            location.accuracy = accuracy
            location.latitude = position.lat
            location.longitude = position.lng
            return location
        }
    }

    override fun setAndroidLocation(p0: Location?) {
        throw NotImplementedError()
    }

    override fun toString(): String {
        return "{pos:[${point?.coordinatesAsString}], bearing:$bearing, accuracy:$accuracy, floorIndex:$floorIndex, provider:$provider}"
    }
}