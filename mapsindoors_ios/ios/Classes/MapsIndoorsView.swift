import Flutter
import GoogleMaps
import MapsIndoors
import MapsIndoorsCore

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var mapsIndoorsData: MapsIndoorsData

    init(messenger: FlutterBinaryMessenger, mapsIndoorsData: MapsIndoorsData) {
        self.messenger = messenger
        self.mapsIndoorsData = mapsIndoorsData
        super.init()
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            arguments: args,
            binaryMessenger: messenger,
            mapsIndoorsData: mapsIndoorsData)
    }
}

class FLNativeView: NSObject, FlutterPlatformView, MPMapControlDelegate {
    private var _GMSView: GMSMapView?
    private let MP_APIKEY = "mapspeople"
    private var mapsIndoorsData: MapsIndoorsData? = nil
    
    init(
        frame: CGRect,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        mapsIndoorsData: MapsIndoorsData
    ) {
        super.init()
        
        self.mapsIndoorsData = mapsIndoorsData;
        _GMSView = GMSMapView.init(frame: frame, camera: GMSCameraPosition())

        mapsIndoorsData.googleMap = _GMSView
        // To fix an odd bug, where the map center would be in the top left corner of the view.
        // It should be the center of the view.
        _GMSView?.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition()))
    }

    func view() -> UIView {
        return _GMSView!
    }
}
