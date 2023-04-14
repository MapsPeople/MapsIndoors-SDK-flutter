part of 'package:mapsindoors/mapsindoors.dart';

class MPDefaultFloorSelector extends StatefulWidget implements MPFloorSelector {
  MPDefaultFloorSelector({super.key});
  late final Function(List<MPFloor>? floors) setFloorsFunc;
  late final Function(OnFloorSelectionChangedListener listener)
      setOnFloorSelectionChangedListenerFunc;
  late final Function(MPFloor floor) setSelectedFloorFunc;
  late final Function(int floorIndex) setSelectedFloorByFloorIndexFunc;
  late final Function(int floorIndex) setUserPositionFloorFunc;
  late final Function(bool show) showFunc;
  late final Function(num newZoomLevel) zoomLevelChangedFunc;

  @override
  Widget? getWidget() => this;
  @override
  bool isAutoFloorChangeEnabled() => true;
  @override
  void setFloors(List<MPFloor>? floors) => setFloorsFunc(floors);
  @override
  void setOnFloorSelectionChangedListener(
          OnFloorSelectionChangedListener listener) =>
      setOnFloorSelectionChangedListenerFunc(listener);
  @override
  void setSelectedFloor(MPFloor floor) => setSelectedFloorFunc(floor);
  @override
  void setSelectedFloorByFloorIndex(int floorIndex) =>
      setSelectedFloorByFloorIndexFunc(floorIndex);
  @override
  void setUserPositionFloor(int floorIndex) =>
      setUserPositionFloorFunc(floorIndex);
  @override
  void show(bool show) => showFunc(show);
  @override
  void zoomLevelChanged(num newZoomLevel) =>
      zoomLevelChangedFunc(newZoomLevel);

  @override
  FloorSelectorState createState() => FloorSelectorState();
}

class FloorSelectorState extends State<MPDefaultFloorSelector>
    implements MPFloorSelectorInterface {
  final List<MPFloor> _floors = List.empty(growable: true);
  OnFloorSelectionChangedListener? _listener;
  bool _visible = true;
  int _userPositionFloor = -1;
  MPFloor? _selectedFloor;
  num showOnZoomLevel = 17.0;

  @override
  void initState() {
    super.initState();
    widget.setFloorsFunc = (floors) => setFloors(floors);
    widget.setOnFloorSelectionChangedListenerFunc =
        (listener) => setOnFloorSelectionChangedListener(listener);
    widget.setSelectedFloorFunc = (floor) => setSelectedFloor(floor);
    widget.setSelectedFloorByFloorIndexFunc =
        (floorIndex) => setSelectedFloorByFloorIndex(floorIndex);
    widget.setUserPositionFloorFunc =
        (floorIndex) => setUserPositionFloor(floorIndex);
    widget.showFunc = (show) => this.show(show);
    widget.zoomLevelChangedFunc =
        (newZoomLevel) => zoomLevelChanged(newZoomLevel);
  }

  @override
  Widget? getWidget() {
    return null;
  }

  @override
  bool isAutoFloorChangeEnabled() {
    return true;
  }

  @override
  void setFloors(List<MPFloor>? floors) {
    if (floors == null) {
      return;
    }
    List<MPFloor> list = List.from(floors);
    list.sort();
    setState(() {
      _floors.clear();
      _floors.addAll(list.reversed);
    });
  }

  @override
  void setOnFloorSelectionChangedListener(
      OnFloorSelectionChangedListener listener) {
    setState(() {
      _listener = listener;
    });
  }

  @override
  void setSelectedFloor(MPFloor floor) {
    _listener?.onFloorSelectionChanged(floor);
    setState(() {
      _selectedFloor = floor;
    });
  }

  @override
  void setSelectedFloorByFloorIndex(int floorIndex) {
    if (_floors.isEmpty) {
      return;
    }

    for (final floor in _floors) {
      if (floor.floorIndex == floorIndex) {
        setSelectedFloor(floor);
        return;
      }
    }
  }

  @override
  void setUserPositionFloor(int floorIndex) {
    setState(() {
      _userPositionFloor = floorIndex;
    });
  }

  @override
  void show(bool show) {
    setState(() {
      _visible = show;
    });
  }

  @override
  void zoomLevelChanged(num newZoomLevel) =>
      show(newZoomLevel >= showOnZoomLevel);

  @override
  Widget build(BuildContext context) {
    if (_visible && _floors.isNotEmpty) {
      return SizedBox(
        width: 50,
        height: 400,
        child: ListView.builder(
            itemCount: _floors.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () => setSelectedFloor(_floors[index]),
                style: (_floors[index] == _selectedFloor)
                    ? buttonStyleWithColor(Colors.green)
                    : (_userPositionFloor == _floors[index].floorIndex)
                        ? buttonStyleWithColor(Colors.amber)
                        : null,
                child: Text(_floors[index].displayName),
              );
            }),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

ButtonStyle buttonStyleWithColor(Color color) {
  return ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => color));
}
