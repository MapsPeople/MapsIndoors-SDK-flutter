package com.mapspeople.mapsindoors.models

import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.MPPoint
import com.mapsindoors.core.MPQuery

data class Query(
    @SerializedName("query") private val mQuery : String?,
    @SerializedName("near") private val mNear : MPPoint?,
    @SerializedName("queryProperties") private val mQueryProperties : List<String>?
) {
    fun toMPQuery() : MPQuery {
        val builder = MPQuery.Builder()
        mQuery?.let(builder::setQuery)
        mNear?.let(builder::setNear)
        mQueryProperties?.let(builder::setQueryProperties)
        return builder.build()
    }
}

