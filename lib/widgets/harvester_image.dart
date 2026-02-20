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
    // For network images (if you use them in the future)
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildModernPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildModernPlaceholder();
        },
      );
    }
    
    // For local asset images
    else if (!imageUrl.startsWith('placeholder') && !imageUrl.contains('user_image')) {
      String fullPath = 'assets/images/$imageUrl';
      return Image.asset(
        fullPath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildModernPlaceholder();
        },
      );
    }
    
    // For placeholder or user uploaded images (show modern placeholder)
    else {
      return _buildModernPlaceholder();
    }
  }

  // Modern placeholder using Flutter's built-in widgets
  Widget _buildModernPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: machineType == 'Corn' ? Colors.amber[50] : Colors.lightBlue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            machineType == 'Corn' ? Icons.grain : Icons.rice_bowl,
            size: 40,
            color: machineType == 'Corn' 
                ? Colors.amber[700] 
                : Colors.blue[700],
          ),
          const SizedBox(height: 8),
          Text(
            machineType == 'Corn' ? 'Corn Harvester' : 'Rice Harvester',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: machineType == 'Corn' 
                  ? Colors.amber[900] 
                  : Colors.blue[900],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Image coming soon',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}