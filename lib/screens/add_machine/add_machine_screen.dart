import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/harvester.dart';

class AddMachineScreen extends StatefulWidget {
  const AddMachineScreen({super.key});

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Image picker
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  
  // Form field values
  String _machineName = '';
  String _ownerName = '';
  String _location = '';
  String _district = '';
  double _pricePerDay = 0;
  double _pricePerHour = 0;
  String _machineType = 'Corn';
  String _description = '';
  int _year = DateTime.now().year;
  int _hoursUsed = 0;
  String _fuelType = 'Diesel';
  
  // Features list
  final List<String> _features = [];
  final TextEditingController _featureController = TextEditingController();

  // Define constant lists
  static const List<String> _districts = [
    'Ampara', 'Anuradhapura', 'Badulla', 'Kurunegala',
    'Monaragala', 'Polonnaruwa', 'Trincomalee'
  ];

  static const List<String> _fuelTypes = [
    'Diesel', 'Petrol', 'Electric'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _featureController.dispose();
    super.dispose();
  }

  // Method to show image picker options
  Future<void> _showImagePickerOptions() async {
    if (!mounted) return;
    
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.green),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 85,
      );
      
      if (pickedFile != null && mounted) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            // ignore: prefer_const_constructors
            SnackBar(
              content: const Text('✅ Image selected successfully!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Harvester',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Modern Image picker section with Flutter Placeholder
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : _buildModernPlaceholder(),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.green[700],
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                          onPressed: _showImagePickerOptions,
                        ),
                      ),
                    ),
                    if (_selectedImage != null)
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Machine Type Selection
              const Text(
                'Machine Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTypeCard('Corn', Icons.grain),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTypeCard('Rice', Icons.rice_bowl),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Machine Name
              const Text(
                'Machine Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _machineName,
                decoration: InputDecoration(
                  hintText: 'e.g., John Deere S790',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.precision_manufacturing),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter machine name';
                  }
                  return null;
                },
                onChanged: (value) => _machineName = value,
                onSaved: (value) => _machineName = value ?? '',
              ),
              const SizedBox(height: 16),

              // Owner Name
              const Text(
                'Owner Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _ownerName,
                decoration: InputDecoration(
                  hintText: 'e.g., Kamal Perera',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter owner name';
                  }
                  return null;
                },
                onChanged: (value) => _ownerName = value,
                onSaved: (value) => _ownerName = value ?? '',
              ),
              const SizedBox(height: 16),

              // Location (Row with Location and District)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _location,
                          decoration: InputDecoration(
                            hintText: 'e.g., Ampara Town',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onChanged: (value) => _location = value,
                          onSaved: (value) => _location = value ?? '',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'District',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text('Select District'),
                              ),
                              value: _district.isEmpty ? null : _district,
                              items: _districts.map((String district) {
                                return DropdownMenuItem<String>(
                                  value: district,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(district),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _district = value ?? '';
                                });
                              },
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Price (Row with Daily and Hourly)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price Per Day (LKR)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _pricePerDay == 0 ? '' : _pricePerDay.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g., 85000',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.attach_money),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onChanged: (value) => _pricePerDay = double.tryParse(value) ?? 0,
                          onSaved: (value) => _pricePerDay = double.tryParse(value ?? '0') ?? 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price Per Hour (LKR)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _pricePerHour == 0 ? '' : _pricePerHour.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g., 11000',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.access_time),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onChanged: (value) => _pricePerHour = double.tryParse(value) ?? 0,
                          onSaved: (value) => _pricePerHour = double.tryParse(value ?? '0') ?? 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Year and Hours Used
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Manufacturing Year',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _year == DateTime.now().year ? '' : _year.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g., 2023',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onChanged: (value) => _year = int.tryParse(value) ?? DateTime.now().year,
                          onSaved: (value) => _year = int.tryParse(value ?? '2023') ?? 2023,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hours Used',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _hoursUsed == 0 ? '' : _hoursUsed.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g., 450',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.speed),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onChanged: (value) => _hoursUsed = int.tryParse(value) ?? 0,
                          onSaved: (value) => _hoursUsed = int.tryParse(value ?? '0') ?? 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Fuel Type
              const Text(
                'Fuel Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _fuelType,
                    items: _fuelTypes.map((String fuel) {
                      return DropdownMenuItem<String>(
                        value: fuel,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(fuel),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _fuelType = value ?? 'Diesel';
                      });
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Features
              const Text(
                'Features',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _featureController,
                      decoration: InputDecoration(
                        hintText: 'e.g., GPS Navigation',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_featureController.text.isNotEmpty) {
                        setState(() {
                          _features.add(_featureController.text);
                          _featureController.clear();
                        });
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Display added features
              if (_features.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _features.map((feature) {
                    return Chip(
                      label: Text(feature),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () {
                        setState(() {
                          _features.remove(feature);
                        });
                      },
                      backgroundColor: Colors.green[50],
                    );
                  }).toList(),
                ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _description,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe your harvester...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onChanged: (value) => _description = value,
                onSaved: (value) => _description = value ?? '',
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Add Harvester',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Modern placeholder using Flutter's built-in widgets
  Widget _buildModernPlaceholder() {
    return Container(
      width: 200,
      height: 150,
      color: _machineType == 'Corn' ? Colors.amber[50] : Colors.lightBlue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _machineType == 'Corn' ? Icons.grain : Icons.rice_bowl,
            size: 50,
            color: _machineType == 'Corn' 
                ? Colors.amber[700] 
                : Colors.blue[700],
          ),
          const SizedBox(height: 8),
          Text(
            _machineType == 'Corn' ? 'Corn Harvester' : 'Rice Harvester',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _machineType == 'Corn' 
                  ? Colors.amber[900] 
                  : Colors.blue[900],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap camera to add photo',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Build machine type selection card
  Widget _buildTypeCard(String type, IconData icon) {
    bool isSelected = _machineType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _machineType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green[700]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green[700] : Colors.grey[600],
              size: 32,
            ),
            const SizedBox(height: 4),
            Text(
              type,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.green[700] : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Submit form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Validate district separately
      if (_district.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a district'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
      
      // Create new harvester ID
      String newId = 'custom_${DateTime.now().millisecondsSinceEpoch}';
      
      // Create new harvester object
      Harvester newHarvester = Harvester(
        id: newId,
        name: _machineName,
        ownerName: _ownerName,
        ownerId: 'owner_${DateTime.now().millisecondsSinceEpoch}',
        location: _location,
        district: _district,
        pricePerDay: _pricePerDay,
        pricePerHour: _pricePerHour,
        rating: 0.0,
        imageUrl: _selectedImage != null ? 'user_image.jpg' : 'placeholder',
        features: _features,
        isAvailable: true,
        description: _description,
        machineType: _machineType,
        year: _year,
        hoursUsed: _hoursUsed,
        fuelType: _fuelType,
        reviewsCount: 0,
      );
      
      // Show success dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Machine Added Successfully!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('$_machineName has been added to the platform.'),
                const SizedBox(height: 8),
                if (_selectedImage != null)
                  const Text(
                    '📸 Photo uploaded',
                    style: TextStyle(color: Colors.green),
                  ),
                Text(
                  '📍 $_location, $_district',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      
      debugPrint('New Harvester Added: $newHarvester');
    }
  }
}