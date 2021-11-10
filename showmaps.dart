import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleGoogleMap extends StatefulWidget {
  const SimpleGoogleMap({Key? key}) : super(key: key);

  @override
  _SimpleGoogleMapState createState() => _SimpleGoogleMapState();
}

class _SimpleGoogleMapState extends State<SimpleGoogleMap> {
  GoogleMapController? mapController;
  static const LatLng _center = LatLng(45.521563, -122.677433);
  static const LatLng _anotherLocation =
      LatLng(45.51687726835272, -122.61597925732826);
  void onMapCreate(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps"),
        centerTitle: true,
      ),
      body: GoogleMap(
          markers: {portlandMarker, portlandanother},
          mapType: MapType.terrain,
          onMapCreated: onMapCreate,
          initialCameraPosition:
              const CameraPosition(target: _center, zoom: 11.0)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _gotoIntel,
        label: Text("go to mosque"),
        icon: Icon(Icons.place),
      ),
    );
  }

  Marker portlandMarker = Marker(
      markerId: const MarkerId("portland"),
      position: _center,
      infoWindow: const InfoWindow(
          title: "Portland", snippet: "This is a fucking town "),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));
  Marker portlandanother = Marker(
      markerId: const MarkerId("portland"),
      position: _anotherLocation,
      infoWindow: const InfoWindow(
          title: "Portland", snippet: "This is a fucking town "),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));
  static final CameraPosition intelposition = CameraPosition(
      target: LatLng(31.59043313330705, 74.3117412139082), zoom: 11.0);
  Future<void> _gotoIntel() async {
    final GoogleMapController? controller = mapController;
    await controller
        ?.animateCamera(CameraUpdate.newCameraPosition(intelposition));
  }
}
