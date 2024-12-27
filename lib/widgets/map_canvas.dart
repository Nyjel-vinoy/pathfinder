import 'package:flutter/material.dart';
import 'package:navmap/widgets/paint_path.dart';

class MapCanvas extends StatelessWidget {
  final Offset currentLocation;
  final Offset destinationPosition;
  final List<Offset> path;
  final String mapImagePath;
  final double initialScale;

  const MapCanvas({
    required this.currentLocation,
    required this.destinationPosition,
    required this.path,
    required this.mapImagePath,
    required this.initialScale,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = 4423.0;
    final imageHeight = 3156.0;

    return InteractiveViewer(
      minScale: initialScale,
      maxScale: 2.0,
      constrained: false,
      child: Stack(
        children: [
          Image.asset(
            mapImagePath,
            width: imageWidth * initialScale,
            height: imageHeight * initialScale,
            fit: BoxFit.fill,
          ),
          CustomPaint(
            painter: PathPainter(path: path, scale: initialScale),
            size: Size(imageWidth * initialScale, imageHeight * initialScale),
          ),
          Positioned(
            left: currentLocation.dx * initialScale - 10,
            top: currentLocation.dy * initialScale - 10,
            child: Icon(Icons.man, color: Colors.white, size: 25),
          ),
          Positioned(
            left: destinationPosition.dx * initialScale - 10,
            top: destinationPosition.dy * initialScale - 10,
            child: Icon(Icons.location_pin, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }
}
