package com.mapspeople.mapsindoors.models

import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPPoint

/**
 * Used to deserialize MPBounds from dart
 */
data class Bounds(
    @SerializedName("northeast") val northEast: MPPoint,
    @SerializedName("southwest") val southWest: MPPoint
)

