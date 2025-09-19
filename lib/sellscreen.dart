import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/device_health.dart';
import '../models/eco_score.dart';
import 'screens/device_health_check.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = 'Phones';
  String _selectedCondition = 'Like New';
  String _location = 'Manila';
  List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  DeviceHealth? _deviceHealth;
  EcoScore? _ecoScore;
  double? _tradeInValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Images (max 5)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildImageUploadSection(),
              const SizedBox(height: 20),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Item Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: ['Phones', 'Laptops', 'Tablets', 'Accessories']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              const Text('Condition', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedCondition,
                items: ['New', 'Like New', 'Good', 'Fair', 'Poor']
                    .map((condition) => DropdownMenuItem(
                  value: condition,
                  child: Text(condition),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCondition = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price (₱)',
                  border: OutlineInputBorder(),
                  prefixText: '₱',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _location,
                items: ['Manila', 'Maa', 'Mintal', 'Davao', 'Other']
                    .map((location) => DropdownMenuItem(
                  value: location,
                  child: Text(location),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _location = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Device Health Check Section
              const Text('Device Health Check', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _checkDeviceHealth,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF109991),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Check Device Health'),
              ),
              const SizedBox(height: 10),

              if (_deviceHealth != null) ...[
                const SizedBox(height: 10),
                const Text('Device Health Report', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Overall Condition: ${_deviceHealth!.overallCondition}'),
                Text('Health Score: ${_deviceHealth!.healthScore.toStringAsFixed(1)}%'),
                Text('Battery Health: ${_deviceHealth!.batteryHealth.toStringAsFixed(1)}%'),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _calculateEcoScore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF148846),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Calculate Eco Score'),
                ),
              ],

              if (_ecoScore != null) ...[
                const SizedBox(height: 10),
                const Text('Eco Assessment', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Eco Score: ${_ecoScore!.calculateEcoScore().toStringAsFixed(1)}%'),
                Text('Eco Rating: ${_ecoScore!.getEcoRating()}'),
                if (_tradeInValue != null)
                  Text('Estimated Trade-in Value: ₱${_tradeInValue!.toStringAsFixed(2)}'),
              ],

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF109991),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('List Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedImages.length + 1,
            itemBuilder: (context, index) {
              if (index == _selectedImages.length) {
                return _selectedImages.length < 5
                    ? GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 30),
                        Text('Add photo'),
                      ],
                    ),
                  ),
                )
                    : Container();
              }

              return Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(_selectedImages[index].path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_selectedImages.length}/5 photos',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImages.add(image);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _checkDeviceHealth() async {
    final health = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeviceHealthCheckScreen()),
    );

    if (health != null) {
      setState(() {
        _deviceHealth = health;
      });
    }
  }

  void _calculateEcoScore() {
    if (_deviceHealth != null) {
      final ecoScore = EcoScore(
        deviceHealthScore: _deviceHealth!.healthScore,
        deviceAge: 12,
        deviceType: _selectedCategory,
      );

      setState(() {
        _ecoScore = ecoScore;
        _tradeInValue = ecoScore.calculateTradeInValue(1000);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final itemData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'condition': _selectedCondition,
        'price': _priceController.text,
        'location': _location,
        'images': _selectedImages.length,
      };

      print('Item data: $itemData');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item listed successfully!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _selectedImages.clear();
        _selectedCategory = 'Phones';
        _selectedCondition = 'Like New';
        _location = 'Manila';
        _deviceHealth = null;
        _ecoScore = null;
        _tradeInValue = null;
      });
    }
  }
}