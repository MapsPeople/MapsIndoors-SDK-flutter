package com.mapspeople.mapsindoors.models

import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPFilter
import com.mapsindoors.core.MPMapExtend
import com.mapsindoors.core.models.MPLatLngBounds

/**
 * Used to deserialize MPFilter from dart, and converting it into MPFilter in the MapsIndoors SDK
 */
data class Filter(
@SerializedName("take") private val mTake : Int?,
@SerializedName("skip") private val mSkip : Int?,
@SerializedName("categories") private val mCategories : List<String>?,
@SerializedName("locations") private val mLocations : List<String>?,
@SerializedName("types") private val mTypes : List<String>?,
@SerializedName("parents") private val mParents : List<String>?,
@SerializedName("mapExtend") private val mMapExtend : Bounds?,
@SerializedName("geometry") private val mGeometry : Bounds?,
@SerializedName("floorIndex") private val mFloorIndex : Int?,
@SerializedName("depth") private val mDepth : Int?,
@SerializedName("ignoreLocationSearchableStatus") private val mIgnoreLocationSearchableStatus : Boolean?,
@SerializedName("ignoreLocationActiveStatus") private val mIgnoreLocationActiveStatus : Boolean?,
) {
    fun toMPFilter() : MPFilter {
        val builder = MPFilter.Builder()
        mTake?.let(builder::setTake)
        mSkip?.let(builder::setSkip)
        mCategories?.let(builder::setCategories)
        mLocations?.let(builder::setLocations)
        mTypes?.let(builder::setTypes)
        mParents?.let(builder::setParents)
        mMapExtend?.let {
            builder.setMapExtend(MPMapExtend(it.southWest.latLng, it.northEast.latLng))
        }
        mGeometry?.let {
            val mpBounds = MPLatLngBounds(mGeometry.southWest.latLng, mGeometry.northEast.latLng)
            builder.setGeometry(MPFilter.Geometry(mpBounds.center.lat, mpBounds.center.lng, MPMapExtend(mpBounds)))
        }
        mFloorIndex?.let(builder::setFloorIndex)
        mDepth?.let(builder::setDepth)
        mIgnoreLocationActiveStatus?.let(builder::setIgnoreLocationActiveStatus)
        mIgnoreLocationSearchableStatus?.let(builder::setIgnoreLocationSearchableStatus)
        return builder.build()

    }
}
