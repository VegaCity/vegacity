import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:auto_route/auto_route.dart';

final vietmapControllerProvider =
    StateProvider<VietmapController?>((ref) => null);

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const apiKey = '38db2f3d058b34e0f52f067fe66a902830fac1a044e8d444';
  VietmapController? _mapController;
  Line? _line;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test map"),
      ),
      body: Stack(
        children: [
          VietmapGL(
            trackCameraPosition: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            myLocationEnabled: true,
            styleString:
                "https://maps.vietmap.vn/api/maps/light/styles.json?apikey=$apiKey",
            initialCameraPosition: const CameraPosition(
              target: LatLng(10.762317, 106.654551),
              zoom: 15.0,
            ),
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            onStyleLoadedCallback: () {
              print("Map style loaded");
            },
          ),
          if (_mapController != null)
            MarkerLayer(
              ignorePointer: true,
              mapController: _mapController!,
              markers: [
                Marker(
                  alignment: Alignment.bottomCenter,
                  child: const Icon(Icons.location_on,
                      color: Colors.red, size: 50),
                  latLng: const LatLng(10.762317, 106.654551),
                ),
                Marker(
                  child: const Icon(Icons.location_on),
                  latLng: const LatLng(10.762317, 106.654551),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              // Add polyline between two points
              _line = await _mapController?.addPolyline(
                const PolylineOptions(
                  geometry: [
                    LatLng(10.762317, 106.654551),
                    LatLng(10.762375, 106.652140),
                  ],
                  polylineColor: Colors.blue,
                  polylineWidth: 10,
                ),
              );
            },
            tooltip: "Vẽ polyline",
            child: const Icon(Icons.route),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              if (_line != null) {
                _mapController?.removePolyline(_line!);
              }
            },
            tooltip: "Xóa polyline",
            child: const Icon(Icons.shape_line),
          ),
        ],
      ),
    );
  }
}
