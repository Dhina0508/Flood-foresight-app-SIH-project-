import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/homepage.dart';
import 'package:new_project/screens/loginpage.dart';
import 'package:new_project/screens/map/search.dart';
import 'package:new_project/screens/sectors.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(23.1, 78.7), zoom: 4.8);

  List<Marker> markers = [];
  void initState() {
    initalize();
    super.initState();
  }

  initalize() {
    Marker FirstMarker = Marker(
        markerId: MarkerId('Trial1'),
        position: LatLng(12.923721, 80.102037),
        infoWindow: InfoWindow(
          title: 'Tambaram',
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Sectors()));
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    markers.add(FirstMarker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Dimension.iconSize16 * 3,
            color: Color.fromRGBO(28, 11, 67, 0.9),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color.fromRGBO(28, 11, 67, 0.9),
          ),
          height: 40,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPlacesScreen()));
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontFamily: 'Cinzel'),
                  )),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers.map((e) => e).toSet(),
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(228, 44, 31, 73),
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 17)));

          markers.clear();

          markers.add(Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(position.latitude, position.longitude)));

          setState(() {});
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.my_location_outlined),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please turn on Location'),
        behavior: SnackBarBehavior.floating,
      ));
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
