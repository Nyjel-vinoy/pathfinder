import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navmap/widgets/map_canvas.dart';

class MapScreen extends StatelessWidget {
  final Offset currentLocation; // Scanned QR code position
  final String destination; // Destination name
  final Offset destinationPosition; // Destination coordinates
  final Map<String, List<Offset>> predefinedPaths; // Predefined paths

  MapScreen({
    required this.currentLocation,
    required this.destination,
    required this.destinationPosition,
    required this.predefinedPaths,
  });

  @override
  Widget build(BuildContext context) {
    // Lock the screen orientation to portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Map image dimensions
    final imageWidth = 4423.0;
    final imageHeight = 3156.0;

    // Initial scale calculation to fill the screen without cropping
    double scaleX = screenWidth / imageWidth;
    double scaleY = screenHeight / imageHeight;
    double initialScale = scaleX > scaleY ? scaleX : scaleY;

    // Determine the predefined path key
    String pathKey = "${_getLocationKey(currentLocation)} to $destination";
    final path = predefinedPaths[pathKey];

    // If no valid path exists, show an error and return to the previous screen
    if (path == null || path.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showError(context, "No predefined path exists for this route!");
        Navigator.pop(context); // Return to the dropdown screen
      });
      return Container(); // Prevent rendering further if no valid path
    }

    return Scaffold(
      body: MapCanvas(
        currentLocation: currentLocation,
        destinationPosition: destinationPosition,
        path: path, // Pass the path to the MapCanvas widget
        mapImagePath: 'assets/images/map4.png', // Path to the map image
        initialScale: initialScale, // Initial scale for the map
      ),
    );
  }

  /// Gets the name of the location by matching its position
  String _getLocationKey(Offset position) {
    for (var entry in predefinedPaths.entries) {
      if (entry.value.first == position) {
        return entry.key.split(" to ").first;
      }
    }
    return "Unknown";
  }

  /// Displays an error message using a SnackBar
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
