import 'package:flutter/material.dart';
import '../models/machine_model.dart';

class MachineListScreen extends StatefulWidget {
  final List<Machine> machines;
  final Function(Machine) onMachineSelect;
  final VoidCallback onNavigateToBookings;

  const MachineListScreen({
    super.key,
    required this.machines,
    required this.onMachineSelect,
    required this.onNavigateToBookings,
  });

  @override
  State<MachineListScreen> createState() => _MachineListScreenState();
}

class _MachineListScreenState extends State<MachineListScreen> {
  String searchQuery = '';
  String selectedCategory = 'all';
  String selectedLocation = 'all';

  final List<String> locations = [
    'all',
    'Anuradhapura',
    'Kurunegala',
    'Matara',
    'Polonnaruwa',
    'Ampara',
    'Hambantota',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMachines = widget.machines.where((m) {
      final matchesSearch =
          m.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          m.owner.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          m.owner.location.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesCategory =
          selectedCategory == 'all' || m.category == selectedCategory;

      final matchesLocation =
          selectedLocation == 'all' || m.owner.location == selectedLocation;

      return matchesSearch && matchesCategory && matchesLocation;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE6F0E6),
      appBar: AppBar(
        title: const Text('GrowMate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: widget.onNavigateToBookings,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search machines, owners, locations...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
            const SizedBox(height: 10),

            /// Location filter
            DropdownButtonFormField<String>(
              value: selectedLocation,
              items: locations
                  .map(
                    (loc) => DropdownMenuItem(
                      value: loc,
                      child: Text(loc),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedLocation = value ?? 'all');
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            /// Machine Grid
            Expanded(
              child: GridView.builder(
                itemCount: filteredMachines.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final machine = filteredMachines[index];

                  return GestureDetector(
                    onTap: () => widget.onMachineSelect(machine),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Image
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  machine.image,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: machine.availability == 'Available'
                                        ? Colors.green
                                        : Colors.orange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    machine.availability,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// Info
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  machine.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${machine.owner.name} • ${machine.owner.location}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'LKR ${machine.pricePerDay}/day',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}