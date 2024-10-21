import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:auto_route/auto_route.dart';

final vietmapControllerProvider =
    StateProvider<VietmapController?>((ref) => null);
@RoutePage()
class MapScreen extends HookConsumerWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const apiKey = '38db2f3d058b34e0f52f067fe66a902830fac1a044e8d444';
    final mapController = ref.watch(vietmapControllerProvider);

    Line? line;

    useEffect(() {
      return null;
    }, []);

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
            onMapCreated: (VietmapController controller) {
              ref.read(vietmapControllerProvider.notifier).state = controller;
            },
            onStyleLoadedCallback: () {
              print("Map style loaded");
            },
          ),
          mapController == null
              ? const SizedBox.shrink()
              : MarkerLayer(
                  ignorePointer: true,
                  mapController: mapController,
                  markers: [
                    //TAO NOTE Ở ĐÂY ĐỌC CHO DỄ =>  MAKER CHÍNH LÀ CÁC ICONS THỂ HIỆN VỊ TRÍ TRÊN MAP
                    Marker(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.location_on,
                            color: Colors.red, size: 50),
                      ),
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
              // TAO NOTE Ở ĐÂY ĐỌC CHO DỄ => HÀM NÀY DÙNG ĐỂ VẼ LINE NỐI ĐỊA ĐIỂM
              line = await mapController?.addPolyline(
                const PolylineOptions(geometry: [
                  LatLng(10.762317, 106.654551),
                  LatLng(10.762375, 106.652140)
                ], polylineColor: Colors.blue, polylineWidth: 10),
              );
            },
            tooltip: "Vẽ polyne",
            child: Icon(Icons.route),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              mapController?.removePolyline(line!);
            },
            tooltip: "Xóa polyne",
            child: Icon(Icons.shape_line),
          ),
        ],
      ),
    );
  }
}