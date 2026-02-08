import 'package:flutter/material.dart';
import '../models/machine_model.dart';

class MachineDetailsScreen extends StatelessWidget {
  final Machine machine;
  final Function(Machine) onBookNow;
  final VoidCallback onBack;

  const MachineDetailsScreen({
    super.key,
    required this.machine,
    required this.onBookNow,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0E6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: onBack,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Machine Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        machine.image,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      machine.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Text(
                      machine.description,
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 16),

                    // Prices
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _priceBox('Per Day', machine.pricePerDay),
                        _priceBox('Per Hour', machine.pricePerHour),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Owner Info
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(machine.owner.name),
                      subtitle: Text(machine.owner.location),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 16),
                          Text(machine.owner.rating.toString()),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Specifications
                    const Text(
                      'Specifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _specBox('Brand', machine.specifications.brand),
                        _specBox('Model', machine.specifications.model),
                        _specBox('Year', machine.specifications.year.toString()),
                        _specBox('Fuel', machine.specifications.fuelType),
                      ],
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Book button
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: ElevatedButton.icon(
                onPressed: machine.availability == 'Available'
                    ? () => onBookNow(machine)
                    : null,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  machine.availability == 'Available'
                      ? 'Book Now'
                      : 'Not Available',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceBox(String label, double price) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          'LKR $price',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _specBox(String title, String value) {
    return Chip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontSize: 10)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}