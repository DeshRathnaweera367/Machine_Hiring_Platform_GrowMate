import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/harvester.dart';
import '../booking/booking_screen.dart';

// This screen shows detailed information about ONE harvester
class HarvesterDetailsScreen extends StatelessWidget {
  final Harvester harvester;

  const HarvesterDetailsScreen({super.key, required this.harvester});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // CUSTOM APP BAR with image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.green[700],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Container(
                    color: Colors.grey[300],
                    child: harvester.imageUrl.startsWith('http')
                        ? Image.network(harvester.imageUrl, fit: BoxFit.cover)
                        : Center(
                            child: Icon(Icons.image, size: 100, color: Colors.grey[400]),
                          ),
                  ),
                  // Dark gradient overlay for text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent, 
                          Colors.black.withValues(alpha: 0.7)
                        ],
                      ),
                    ),
                  ),
                  // Price badge to show both price options
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LKR ${harvester.pricePerDay}/day',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'LKR ${harvester.pricePerHour}/hour',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // CONTENT SECTION
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title, Type and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          harvester.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: harvester.machineType == 'Corn' 
                              ? Colors.amber[100] 
                              : Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          harvester.machineType,
                          style: TextStyle(
                            color: harvester.machineType == 'Corn' 
                                ? Colors.amber[900] 
                                : Colors.blue[900],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        if (index < harvester.rating.floor()) {
                          return const Icon(Icons.star, color: Colors.amber, size: 20);
                        } else if (index < harvester.rating) {
                          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
                        } else {
                          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
                        }
                      }),
                      const SizedBox(width: 8),
                      Text(
                        '${harvester.rating} (${harvester.reviewsCount} reviews)',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Machine Specs Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSpecItem(Icons.calendar_today, 'Year', '${harvester.year}'),
                        _buildSpecItem(Icons.speed, 'Hours', '${harvester.hoursUsed} hrs'),
                        _buildSpecItem(Icons.local_gas_station, 'Fuel', harvester.fuelType),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Owner info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.person, size: 30, color: Colors.green[700]),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Owner',
                                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                              ),
                              Text(
                                harvester.ownerName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${harvester.location}, ${harvester.district} District',
                                      style: TextStyle(color: Colors.grey[600]),
                                      overflow: TextOverflow.ellipsis,
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
                  const SizedBox(height: 20),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    harvester.description,
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  
                  // Features
                  const Text(
                    'Features',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: harvester.features.map((feature) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Text(
                          feature,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  
                  // Availability and Pricing Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Rental Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Availability
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: harvester.isAvailable ? Colors.green : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              harvester.isAvailable ? 'Available for booking' : 'Currently not available',
                              style: TextStyle(
                                color: harvester.isAvailable ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Price comparison
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green[200]!),
                                ),
                                child: Column(
                                  children: [
                                    const Text('Daily Rate', style: TextStyle(fontSize: 12)),
                                    Text(
                                      'LKR ${harvester.pricePerDay}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue[200]!),
                                ),
                                child: Column(
                                  children: [
                                    const Text('Hourly Rate', style: TextStyle(fontSize: 12)),
                                    Text(
                                      'LKR ${harvester.pricePerHour}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // BOTTOM BOOKING BUTTON (sticky at bottom)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: harvester.isAvailable ? Colors.green[700] : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: harvester.isAvailable
                ? () {
                    // Navigate to booking screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(harvester: harvester),
                      ),
                    );
                  }
                : null,  // Disable if not available
            child: Text(
              harvester.isAvailable ? 'Book Now' : 'Not Available',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build spec items
  Widget _buildSpecItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.green[700], size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 11,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}