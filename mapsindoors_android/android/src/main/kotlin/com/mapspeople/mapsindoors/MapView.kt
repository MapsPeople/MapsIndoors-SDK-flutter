package com.mapspeople.mapsindoors

import android.content.Context
import android.view.View
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import io.flutter.plugin.platform.PlatformView

class MapView(context: Context) : PlatformView, OnMapReadyCallback {
    private val mMapView: MapView = MapView(context)
    private var mGoogleMap: GoogleMap? = null
    private var mOnDisposeListener: OnDisposeListener? = null

    fun setOnDisposeListener(onDisposeListener: OnDisposeListener) {
        mOnDisposeListener = onDisposeListener
    }

    override fun getView(): View {
        return mMapView
    }

    override fun dispose() {
        mOnDisposeListener?.onDisposed()
        mMapView.onDestroy()
        mGoogleMap = null
    }

    init {
        mMapView.getMapAsync(this)
        mMapView.onCreate(null)
    }

    override fun onMapReady(p0: GoogleMap) {
        mGoogleMap = p0
        mMapView.onStart()
    }
}