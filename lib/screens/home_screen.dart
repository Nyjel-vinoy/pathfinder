import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:navmap/screens/dropdown_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: MobileScanner(
        onDetect: (BarcodeCapture barcode) {
          if (barcode.barcodes.isNotEmpty) {
            final scannedData = barcode.barcodes.first.rawValue;

            if (scannedData != null) {
              try {
                // Assume QR code contains "x,y" coordinates
                final List<String> parts = scannedData.split(',');
                if (parts.length == 2) {
                  final double x = double.parse(parts[0].trim());
                  final double y = double.parse(parts[1].trim());

                  // Navigate to DropdownScreen and pass coordinates
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DropdownScreen(
                        currentLocation:
                            Offset(x, y), // Pass Offset for position
                      ),
                    ),
                  );
                } else {
                  // Invalid QR code format
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid QR Code Format')),
                  );
                }
              } catch (e) {
                // Handle parsing error
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error reading QR Code data')),
                );
              }
            } else {
              // QR Code is empty
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR Code is empty')),
              );
            }
          }
        },
      ),
    );
  }
}
