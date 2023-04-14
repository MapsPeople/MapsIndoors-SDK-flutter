package com.mapspeople.mapsindoors.models

import com.google.gson.annotations.SerializedName
import com.mapsindoors.core.errors.MIError

data class MPError(
    @SerializedName("code") private val mCode : Int,
    @SerializedName("message") private val mMessage : String,
    @SerializedName("status") private val mStatus : Int?,
    @SerializedName("tag") private val mTag : Any?
) {
    companion object {
        fun fromMIError(error: MIError?) : MPError? {
            return if (error != null) {
                MPError(error.code, error.message, if (error.status != 0) error.status else null, error.tag)
            } else {
                null
            }
        }
    }
}
