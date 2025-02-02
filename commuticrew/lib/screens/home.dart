import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:location/location.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  String transitInstructions = '';
  LatLng? currentLocation;

  final origin = const LatLng(34.0699, -118.4438);
  final destination = const LatLng(34.062012, -118.302696);


  // static const LatLng origin = LatLng(34.0699, -118.4438);  // UCLA
  // static const LatLng destination = LatLng(34.062012, -118.302696);  // Ktown

 @override
void initState() {
  super.initState();
  _addMarkers();
  _getDirections();
  _checkLocationPermission();
}



Future<void> _checkLocationPermission() async {
  final status = await bg.BackgroundGeolocation.requestPermission();
  print('status: $status');

  if (status != true) {
    print('Location permission denied');
    return;
  }

  _initializeLocationTracking(); // Start tracking after permission is granted
}

void _initializeLocationTracking() {
  bg.BackgroundGeolocation.ready(bg.Config(
    desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    distanceFilter: 10.0,  // Min distance before triggering an update
    stopOnTerminate: false, // Continue tracking after app closes
    startOnBoot: true,      // Restart tracking after device reboot
    debug: true,            // Show debugging notifications
    logLevel: bg.Config.LOG_LEVEL_VERBOSE,
    preventSuspend: true,   // Keep app active for background tracking
    locationUpdateInterval: 1000, // 1 second interval
    fastestLocationUpdateInterval: 500, // Minimum update time
    allowIdenticalLocations: true
  )).then((bg.State state) {
    if (!state.enabled) {
      bg.BackgroundGeolocation.start().then((bg.State state) {
        debugPrint('[BackgroundGeolocation] started successfully');
        
        // Listen for background location updates
        bg.BackgroundGeolocation.onLocation((bg.Location location) {
          debugPrint('Location: ${location.coords.latitude}, ${location.coords.longitude}');
          setState(() {
            currentLocation = LatLng(location.coords.latitude, location.coords.longitude);
            _updateUserMarker();
          });
        }, (bg.LocationError error) {
          debugPrint('Location error: ${error.code} - ${error.message}');
        });
      });
    }
  });
}


  

  void _updateUserMarker() {
  if (currentLocation != null) {
    markers.removeWhere((marker) => marker.markerId.value == 'user');
    markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: currentLocation!,
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
    setState(() {}); // Update UI
  }
}



  @override
void dispose() {
  bg.BackgroundGeolocation.stop();
  super.dispose();
}

  void _addMarkers() {
    markers.addAll([
      Marker(
        markerId: const MarkerId('origin'),
        position: origin,
        infoWindow: const InfoWindow(title: 'Origin'),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: destination,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    ]);
  }

  Future<void> _getDirections() async {
    String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    // const String apiKey = '';  // Replace with your API key
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=transit'
        '&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(data);
        
        if (data['status'] == 'OK') {
          _decodePolyline(data['routes'][0]['overview_polyline']['points']);
          _parseTransitInstructions(data['routes'][0]['legs'][0]['steps']);
        }
      }
    } catch (e) {
      // debugPrint('Error fetching directions: $e');
    }
  }
  void _zoomToFitRoute() {
    if (polylineCoordinates.isEmpty) return;
    
    // debugPrint('Zooming to fit route');  // Debug print

    // Create bounds from all points
    double southwestLat = polylineCoordinates.first.latitude;
    double southwestLng = polylineCoordinates.first.longitude;
    double northeastLat = polylineCoordinates.first.latitude;
    double northeastLng = polylineCoordinates.first.longitude;

    // Find the bounds of our points
    for (LatLng point in polylineCoordinates) {
      if (point.latitude < southwestLat) southwestLat = point.latitude;
      if (point.longitude < southwestLng) southwestLng = point.longitude;
      if (point.latitude > northeastLat) northeastLat = point.latitude;
      if (point.longitude > northeastLng) northeastLng = point.longitude;
    }

    // Create bounds
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(southwestLat, southwestLng),
      northeast: LatLng(northeastLat, northeastLng),
    );

    // debugPrint('Bounds calculated: $bounds');  // Debug print

    // Add padding to the bounds
    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        50.0, // padding in pixels
      ),
    );
  }

  void _decodePolyline(String encoded) {
    polylineCoordinates.clear();
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polylineCoordinates.add(
        LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()),
      );
      setState(() {
      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 5,
      ));
      
      // Add this after setting polylines
      _zoomToFitRoute();
    });
    }

    setState(() {
      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 5,
      ));
    });
  }

  void _parseTransitInstructions(List<dynamic> steps) {
    String instructions = '';
    for (var step in steps) {
      if (step['travel_mode'] == 'TRANSIT') {
        var transit = step['transit_details'];
        instructions += 'Take ${transit['line']['vehicle']['name']} '
            '${transit['line']['short_name'] ?? transit['line']['name']} '
            'from ${transit['departure_stop']['name']} '
            'to ${transit['arrival_stop']['name']}\n\n';
      }
    }
    setState(() {
      transitInstructions = instructions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transit Directions'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 254, 182),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 40.0, right: 40.0, left: 40.0, bottom: 40.0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      (origin.latitude + destination.latitude) / 2,
                      (origin.longitude + destination.longitude) / 2,
                    ),
                    zoom: 6,
                  ),
                  markers: markers,
                  polylines: polylines,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Text(
                    transitInstructions.isEmpty ? 'Loading directions...' : transitInstructions,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Container (
              height: 300,
              margin: const EdgeInsets.only(right: 40.0),
            alignment: Alignment.bottomRight,
            child: const Image(image: AssetImage('assets/images/alligator.png'))),
          ],
        ),
      ),
    );
  }
}