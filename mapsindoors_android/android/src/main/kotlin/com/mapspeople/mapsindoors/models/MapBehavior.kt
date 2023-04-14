package com.mapspeople.mapsindoors.models

import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPFilterBehavior
import com.mapsindoors.core.MPSelectionBehavior

/**
 * Used to deserialize MPSelectionBehavior and MPFilterBehavior from dart
 * and converting it into the corresponding behavior in the MapsIndoors SDK
 */
data class MapBehavior(
    @SerializedName("allowFloorChange") private val mAllowFloorChange: Boolean?,
    @SerializedName("moveCamera") private val mMoveCamera: Boolean?,
    @SerializedName("animationDuration") private val mAnimationDuration : Int?,
    @SerializedName("showInfoWindow") private val mShowInfoWindow : Boolean?,
    @SerializedName("zoomToFit") private val mZoomToFit : Boolean?
) {
    fun toMPFilterBehavior() : MPFilterBehavior {
        val builder = MPFilterBehavior.Builder()
        mAllowFloorChange?.let(builder::setAllowFloorChange)
        mMoveCamera?.let(builder::setMoveCamera)
        mAnimationDuration?.let(builder::setAnimationDuration)
        mShowInfoWindow?.let(builder::setShowInfoWindow)
        mZoomToFit?.let(builder::setZoomToFit)
        return builder.build()
    }

    fun toMPSelectionBehavior() : MPSelectionBehavior {
        val builder = MPSelectionBehavior.Builder()
        mAllowFloorChange?.let(builder::setAllowFloorChange)
        mMoveCamera?.let(builder::setMoveCamera)
        mAnimationDuration?.let(builder::setAnimationDuration)
        mShowInfoWindow?.let(builder::setShowInfoWindow)
        mZoomToFit?.let(builder::setZoomToFit)
        return builder.build()
    }
}