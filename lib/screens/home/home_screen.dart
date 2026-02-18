import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/harvester.dart';
import '../details/harvester_details_screen.dart';
import '../../widgets/harvester_card.dart';

// This is the MAIN SCREEN - first thing users see
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for search text field
  final TextEditingController _searchController = TextEditingController();
  
  // List of harvesters after filtering (search results)
  List<Harvester> _filteredHarvesters = [];
  
  // Currently selected category
  String _selectedCategory = 'All';
  
  // Filter values
  RangeValues _priceRange = const RangeValues(0, 100000);
  double _selectedRating = 0;
  bool _showAvailableOnly = false;

  @override
  void initState() {
    super.initState();
    // Initially show all harvesters
    _filteredHarvesters = mockHarvesters;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Find Harvesters',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterHarvesters,
                decoration: InputDecoration(
                  hintText: 'Search by harvester name or location...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          
          // CATEGORY CHIPS (quick filters)
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryChip('All', _selectedCategory == 'All'),
                _buildCategoryChip('Corn', _selectedCategory == 'Corn'),
                _buildCategoryChip('Rice', _selectedCategory == 'Rice'),
              ],
            ),
          ),
          
          // RESULTS COUNT and QUICK FILTERS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredHarvesters.length} harvesters found',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    const Text('Available only', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Switch(
                      value: _showAvailableOnly,
                      onChanged: (value) {
                        setState(() {
                          _showAvailableOnly = value;
                          _applyAllFilters();
                        });
                      },
                      activeThumbColor: Colors.green[700],
                      activeTrackColor: Colors.green[200],
                      inactiveThumbColor: Colors.grey[400],
                      inactiveTrackColor: Colors.grey[200],
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // LIST OF HARVESTERS
          Expanded(
            child: _filteredHarvesters.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No harvesters found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredHarvesters.length,
                    itemBuilder: (context, index) {
                      return HarvesterCard(
                        harvester: _filteredHarvesters[index],
                        onTap: () {
                          // Navigate to details screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HarvesterDetailsScreen(
                                harvester: _filteredHarvesters[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Helper method to build category chips
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = label;
            _applyAllFilters();
          });
        },
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.green[700],
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // Search filter function
  void _filterHarvesters(String query) {
    _applyAllFilters(searchQuery: query);
  }

  // Apply all filters together
  void _applyAllFilters({String? searchQuery}) {
    String query = searchQuery ?? _searchController.text;
    
    // Start with all harvesters
    var results = List<Harvester>.from(mockHarvesters);
    
    // Apply search filter
    if (query.isNotEmpty) {
      results = results.where((harvester) {
        return harvester.name.toLowerCase().contains(query.toLowerCase()) ||
               harvester.location.toLowerCase().contains(query.toLowerCase()) ||
               harvester.district.toLowerCase().contains(query.toLowerCase()) ||
               harvester.machineType.toLowerCase().contains(query.toLowerCase()) ||
               harvester.ownerName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    
    // Apply category filter
    if (_selectedCategory != 'All') {
      results = results.where((harvester) => 
        harvester.machineType == _selectedCategory
      ).toList();
    }
    
    // Apply availability filter
    if (_showAvailableOnly) {
      results = results.where((harvester) => harvester.isAvailable).toList();
    }
    
    // Apply price filter
    results = results.where((harvester) =>
      harvester.pricePerDay >= _priceRange.start &&
      harvester.pricePerDay <= _priceRange.end
    ).toList();
    
    // Apply rating filter
    if (_selectedRating > 0) {
      results = results.where((harvester) =>
        harvester.rating >= _selectedRating
      ).toList();
    }
    
    setState(() {
      _filteredHarvesters = results;
    });
  }

  // Bottom sheet for advanced filters
  void _showFilterSheet(BuildContext context) {
    double tempMin = _priceRange.start;
    double tempMax = _priceRange.end;
    double tempRating = _selectedRating;
    String tempCategory = _selectedCategory;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.5,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar at top
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Filter Harvesters',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Price Range
                      const Text('Price Range (per day)',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: RangeValues(tempMin, tempMax),
                        min: 0,
                        max: 100000,
                        divisions: 20,
                        labels: RangeLabels(
                          'LKR ${tempMin.round()}',
                          'LKR ${tempMax.round()}',
                        ),
                        onChanged: (values) {
                          setSheetState(() {
                            tempMin = values.start;
                            tempMax = values.end;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('LKR ${tempMin.round()}', 
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('LKR ${tempMax.round()}', 
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Rating Filter
                      const Text('Minimum Rating',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [0.0, 3.0, 3.5, 4.0, 4.5].map((rating) {
                          return FilterChip(
                            label: Text(rating == 0 ? 'Any' : '$rating+'),
                            selected: tempRating == rating,
                            onSelected: (selected) {
                              setSheetState(() {
                                tempRating = selected ? rating : 0;
                              });
                            },
                            backgroundColor: Colors.grey[100],
                            selectedColor: Colors.green[100],
                            checkmarkColor: Colors.green[700],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      
                      // Machine Type
                      const Text('Machine Type',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ['All', 'Corn', 'Rice'].map((type) {
                          return FilterChip(
                            label: Text(type),
                            selected: tempCategory == type,
                            onSelected: (selected) {
                              setSheetState(() {
                                tempCategory = selected ? type : 'All';
                              });
                            },
                            backgroundColor: Colors.grey[100],
                            selectedColor: Colors.green[100],
                            checkmarkColor: Colors.green[700],
                          );
                        }).toList(),
                      ),
                      
                      const Spacer(),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                // Reset all filters
                                setSheetState(() {
                                  tempMin = 0;
                                  tempMax = 100000;
                                  tempRating = 0;
                                  tempCategory = 'All';
                                });
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                              ),
                              child: const Text('Reset'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _priceRange = RangeValues(tempMin, tempMax);
                                  _selectedRating = tempRating;
                                  _selectedCategory = tempCategory;
                                  _applyAllFilters();
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Apply Filters'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}