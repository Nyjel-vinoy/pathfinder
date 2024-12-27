import 'package:flutter/material.dart';
import 'package:navmap/screens/map_screen.dart';

class DropdownScreen extends StatefulWidget {
  final Offset currentLocation; // Scanned QR code position

  DropdownScreen({required this.currentLocation});

  @override
  _DropdownScreenState createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  String? selectedDestination;

  // Predefined destinations and positions
  final Map<String, Offset> predefinedDestinations = {
    "library": Offset(2951, 1229),
    "Lab2": Offset(1345, 1686),
    "Canteen": Offset(1324, 1534),
    "office": Offset(2061, 1631),
    "Lab1": Offset(1230, 1706),
    "Reception": Offset(1839, 1878),
    "Library": Offset(2964, 1174),
    "open auditorium": Offset(3045, 2013),
  };

  // Predefined paths with key combinations
  final Map<String, List<Offset>> predefinedPaths = {
    "Lab2 to Library": [
      Offset(1345, 1686),
      Offset(1345, 1618),
      Offset(2716, 1618),
      Offset(2716, 1410),
      Offset(2951, 1410),
      Offset(2951, 1229),
    ],
    "Library to Lab2": [
      Offset(2951, 1229),
      Offset(2951, 1410),
      Offset(2716, 1410),
      Offset(2716, 1618),
      Offset(1345, 1618),
      Offset(1345, 1686),
    ],
    "Reception to office": [
      Offset(1839, 1878),
      Offset(1944, 1878),
      Offset(1944, 1631),
      Offset(2061, 1631), //office
    ],
    "Reception to Canteen": [
      Offset(1839, 1878),
      Offset(1730, 1877),
      Offset(1730, 1627),
      Offset(1324, 1627),
      Offset(1324, 1534), //canteen
    ],
    "Reception to Lab1": [
      Offset(1839, 1878),
      Offset(1730, 1877),
      Offset(1730, 1627),
      Offset(1324, 1627),
      Offset(1230, 1627),
      Offset(1230, 1706),
    ],
    "Reception to Lab2": [
      Offset(1839, 1878),
      Offset(1730, 1877),
      Offset(1730, 1627),
      Offset(1324, 1627),
      Offset(1339, 1627),
      Offset(1339, 1697),
    ],
    "Reception to open auditorium": [
      Offset(1839, 1878),
      Offset(1952, 1883),
      Offset(1952, 1636),
      Offset(3045, 1636),
      Offset(3045, 2013),
    ],
    "Reception to Library": [
      Offset(1839, 1878),
      Offset(1952, 1883),
      Offset(1952, 1636),
      Offset(2721, 1636),
      Offset(2721, 1420),
      Offset(2946, 1420),
      Offset(2964, 1174), //library
    ],
  };

  /// Finds destinations that have predefined paths from the current location
  List<String> _getAvailableDestinations(Offset scannedPosition) {
    List<String> availableDestinations = [];
    predefinedPaths.forEach((key, value) {
      if (value.first == scannedPosition) {
        final destination =
            key.split(" to ").last; // Extract the destination name
        availableDestinations.add(destination);
      }
    });
    return availableDestinations;
  }

  @override
  Widget build(BuildContext context) {
    // Get the available destinations based on the current location
    List<String> availableDestinations =
        _getAvailableDestinations(widget.currentLocation);

    // Get the name of the scanned position
    String scannedPositionName = predefinedDestinations.entries
        .firstWhere((entry) => entry.value == widget.currentLocation,
            orElse: () => MapEntry("Unknown", Offset.zero))
        .key;

    return Scaffold(
      appBar: AppBar(title: Text('Select Destination')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scanned Position: $scannedPositionName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedDestination,
              hint: Text('Select your destination'),
              items: availableDestinations.map((destination) {
                return DropdownMenuItem(
                  value: destination,
                  child: Text(destination),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDestination = value;
                });

                if (selectedDestination != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        currentLocation: widget.currentLocation,
                        destination: selectedDestination!,
                        destinationPosition:
                            predefinedDestinations[selectedDestination!]!,
                        predefinedPaths: predefinedPaths, // Pass paths
                      ),
                    ),
                  );
                }
              },
            ),
            if (availableDestinations.isEmpty)
              Text(
                "No available destinations for the scanned position.",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
