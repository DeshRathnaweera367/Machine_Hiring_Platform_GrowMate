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
  final FocusNode _searchFocusNode = FocusNode();
  
  // List of harvesters after filtering (search results)
  List<Harvester> _filteredHarvesters = [];
  
  // Currently selected category
  String _selectedCategory = 'All';
  
  // Filter values
  RangeValues _priceRange = const RangeValues(0, 100000);
  double _selectedRating = 0;
  bool _showAvailableOnly = false;
  
  // Animation controller for smooth transitions
  bool _isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    // Initially show all harvesters
    _filteredHarvesters = mockHarvesters;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
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
          // Filter button with active indicator
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () => _showFilterSheet(context),
              ),
              if (_isFilterApplied)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // SEARCH BAR with modern design
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _searchFocusNode.hasFocus 
                      ? Colors.green[700]! 
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: _filterHarvesters,
                decoration: InputDecoration(
                  hintText: '🔍 Search by name, location, or owner...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[600]),
                          onPressed: () {
                            _searchController.clear();
                            _filterHarvesters('');
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
          
          // CATEGORY CHIPS (quick filters) with smooth scrolling
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryChip('All', _selectedCategory == 'All'),
                _buildCategoryChip('Corn', _selectedCategory == 'Corn'),
                _buildCategoryChip('Rice', _selectedCategory == 'Rice'),
                _buildCategoryChip('Premium', _selectedCategory == 'Premium'),
                _buildCategoryChip('Budget', _selectedCategory == 'Budget'),
              ],
            ),
          ),
          
          // RESULTS COUNT and QUICK FILTERS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Results count with animation
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_filteredHarvesters.length} ${_filteredHarvesters.length == 1 ? 'harvester' : 'harvesters'}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                
                // Availability toggle
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
          
          // LIST OF HARVESTERS with empty state handling
          Expanded(
            child: _filteredHarvesters.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredHarvesters.length,
                    itemBuilder: (context, index) {
                      return HarvesterCard(
                        harvester: _filteredHarvesters[index],
                        onTap: () {
                          // Navigate to details screen with smooth transition
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  HarvesterDetailsScreen(
                                    harvester: _filteredHarvesters[index],
                                  ),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
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

  // Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated empty state icon
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Icon(
                  Icons.search_off,
                  size: 100,
                  color: Colors.grey[400],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'No harvesters found',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Reset all filters
              setState(() {
                _searchController.clear();
                _selectedCategory = 'All';
                _showAvailableOnly = false;
                _priceRange = const RangeValues(0, 100000);
                _selectedRating = 0;
                _isFilterApplied = false;
                _applyAllFilters();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reset Filters'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
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
            _isFilterApplied = true;
          });
        },
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.green[700],
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: isSelected ? 2 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
      if (_selectedCategory == 'Premium') {
        results = results.where((harvester) => 
          harvester.pricePerDay >= 80000
        ).toList();
      } else if (_selectedCategory == 'Budget') {
        results = results.where((harvester) => 
          harvester.pricePerDay < 50000
        ).toList();
      } else {
        results = results.where((harvester) => 
          harvester.machineType == _selectedCategory
        ).toList();
      }
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
    bool tempAvailable = _showAvailableOnly;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.75,
              maxChildSize: 0.9,
              minChildSize: 0.5,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(24),
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
                      
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter Harvesters',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.green[800],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            // Price Range Section
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money, color: Colors.green[700]),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Price Range (per day)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'LKR ${tempMin.round()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'LKR ${tempMax.round()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Rating Filter
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber[700]),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Minimum Rating',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [0.0, 3.0, 3.5, 4.0, 4.5].map((rating) {
                                      return FilterChip(
                                        label: Text(
                                          rating == 0 ? 'Any' : '$rating+',
                                          style: TextStyle(
                                            color: tempRating == rating
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        selected: tempRating == rating,
                                        onSelected: (selected) {
                                          setSheetState(() {
                                            tempRating = selected ? rating : 0;
                                          });
                                        },
                                        backgroundColor: Colors.grey[200],
                                        selectedColor: Colors.amber[700],
                                        checkmarkColor: Colors.white,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Machine Type
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.category, color: Colors.green[700]),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Machine Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: ['All', 'Corn', 'Rice', 'Premium', 'Budget']
                                        .map((type) {
                                      return FilterChip(
                                        label: Text(
                                          type,
                                          style: TextStyle(
                                            color: tempCategory == type
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        selected: tempCategory == type,
                                        onSelected: (selected) {
                                          setSheetState(() {
                                            tempCategory = selected ? type : 'All';
                                          });
                                        },
                                        backgroundColor: Colors.grey[200],
                                        selectedColor: Colors.green[700],
                                        checkmarkColor: Colors.white,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Availability
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.green[700]),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Show available only',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    value: tempAvailable,
                                    onChanged: (value) {
                                      setSheetState(() {
                                        tempAvailable = value;
                                      });
                                    },
                                    activeThumbColor: Colors.green[700],
                                    activeTrackColor: Colors.green[200],
                                    inactiveThumbColor: Colors.grey[400],
                                    inactiveTrackColor: Colors.grey[200],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setSheetState(() {
                                  tempMin = 0;
                                  tempMax = 100000;
                                  tempRating = 0;
                                  tempCategory = 'All';
                                  tempAvailable = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey[300]!),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                                elevation: 2,
                              ),
                              onPressed: () {
                                setState(() {
                                  _priceRange = RangeValues(tempMin, tempMax);
                                  _selectedRating = tempRating;
                                  _selectedCategory = tempCategory;
                                  _showAvailableOnly = tempAvailable;
                                  _isFilterApplied = true;
                                  _applyAllFilters();
                                });
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Apply Filters',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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