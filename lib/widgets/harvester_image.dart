import 'package:flutter/material.dart';

class HarvesterImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final String machineType;

  const HarvesterImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = 180,
    this.fit = BoxFit.cover,
    required this.machineType,
  });

  @override
  Widget build(BuildContext context) {
    // Construct the full asset path
    String fullPath = 'assets/images/$imageUrl';
    
    return Image.asset(
      fullPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Show colored placeholder with filename when image fails to load
        return Container(
          width: width,
          height: height,
          color: machineType == 'Corn' ? Colors.amber[100] : Colors.lightBlue[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported,
                size: 40,
                color: machineType == 'Corn' ? Colors.amber[700] : Colors.blue[700],
              ),
              const SizedBox(height: 4),
              Text(
                imageUrl,
                style: TextStyle(
                  fontSize: 12,
                  color: machineType == 'Corn' ? Colors.amber[900] : Colors.blue[900],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Image not available',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}