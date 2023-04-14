package com.mapspeople.mapsindoors

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MapViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val view = MapView(context!!)
        sOnViewCreated?.onViewCreated(view)
        return view
    }

    companion object {
        var sOnViewCreated: OnViewCreatedListener? = null

        fun setOnViewCreated(listener: OnViewCreatedListener) {
            sOnViewCreated = listener
        }
    }
}