package com.mapspeople.mapsindoors.models

import com.mapsindoors.core.MPPositionProvider
import com.mapsindoors.core.MPPositionResultInterface
import com.mapsindoors.core.OnPositionUpdateListener

class PositionProvider(val name : String) : MPPositionProvider {
    private var latest : MPPositionResultInterface? = null
    private val listeners : MutableList<OnPositionUpdateListener>

    init {
        listeners = arrayListOf()
    }

    override fun addOnPositionUpdateListener(p0: OnPositionUpdateListener) {
        synchronized(listeners) {
            listeners.add(p0)
        }
    }

    override fun removeOnPositionUpdateListener(p0: OnPositionUpdateListener) {
        synchronized(listeners) {
            listeners.remove(p0)
        }
    }

    override fun getLatestPosition(): MPPositionResultInterface? {
        return latest
    }

    fun updatePosition(pos : MPPositionResultInterface?) {
        latest = pos?.also { update ->
            synchronized(listeners) {
                for (listener in listeners) {
                    listener.onPositionUpdate(update)
                }
            }
        }
    }

    override fun toString(): String {
        return "{ $name }"
    }
}