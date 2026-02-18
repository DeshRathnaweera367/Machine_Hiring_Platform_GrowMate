import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/harvester.dart';

// This is a reusable card widget - like a photo frame for each harvester
class HarvesterCard extends StatelessWidget {
  final Harvester harvester;  // Which harvester to show
  final VoidCallback onTap;   // What to do when tapped

  const HarvesterCard({
    super.key,
    required this.harvester,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // When user taps, do something
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SECTION
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: harvester.imageUrl.startsWith('http')
                        ? Image.network(
                            harvester.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          ),
                  ),
                ),
                // AVAILABILITY BADGE (if not available)
                if (!harvester.isAvailable)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Booked',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                // MACHINE TYPE BADGE
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: harvester.machineType == 'Corn' 
                          ? Colors.amber[700] 
                          : Colors.lightBlue[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      harvester.machineType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // CONTENT SECTION
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME AND PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          harvester.name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'LKR ${harvester.pricePerDay}/day',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // OWNER AND LOCATION
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: Text(
                          harvester.ownerName,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        flex: 3,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(text: harvester.location),
                              TextSpan(
                                text: ' (${harvester.district})',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // RATING
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber[700],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        harvester.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${harvester.reviewsCount} reviews)',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // FEATURES (show first 3 features)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      ...harvester.features.take(3).map((feature) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        );
                      }),
                      if (harvester.features.length > 3)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '+${harvester.features.length - 3} more',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}