import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DavaoMapScreen extends StatefulWidget {
  const DavaoMapScreen({super.key});

  @override
  State<DavaoMapScreen> createState() => _DavaoMapScreenState();
}

class _DavaoMapScreenState extends State<DavaoMapScreen> {
  final List<Map<String, dynamic>> _repairShops = [
    {
      'name': 'GreenTech E-Waste Collection',
      'address': 'Ecoland Drive, Matina, Davao City',
      'type': 'Collection Point',
      'services': ['E-Waste Drop-off', 'Battery Recycling', 'Device Recycling'],
      'distance': '2.8 km',
      'rating': 4.7,
      'lat': 7.0689,
      'lng': 125.6048,
    },
    {
      'name': 'SM Lanang Premier E-Waste Collection',
      'address': 'Cyberzone, 3rd Floor, SM Lanang Premier, J.P. Laurel Ave, Lanang, Davao City',
      'type': 'E-Waste Collection Point',
      'services': ['Collection of old mobile phones', 'Collection of batteries', 'Collection of chargers and cables', 'Collection of small electronics'],
      'distance': '0.8km',
      'rating': 4.3,
      'lat': 7.0950,
      'lng': 125.6310,
    },
    {
      'name': 'EcoWaste Davao',
      'address': 'Lanang, Davao City',
      'type': 'Collection Point',
      'services': ['E-Waste Collection', 'Proper Disposal', 'Environmental Education'],
      'distance': '4.5 km',
      'rating': 4.8,
      'lat': 7.1124,
      'lng': 125.6521,
    },
  ];

  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredShops = _repairShops.where((shop) {
      if (_selectedFilter == 'All') return true;
      return shop['type'] == _selectedFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Davao Repair & Recycling'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Repair Shop', 'Collection Point'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with Map Preview (placeholder)
          Container(
            height: 150,
            color: Colors.grey[200],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 50, color: Color(0xFF109991)),
                  SizedBox(height: 10),
                  Text(
                    'Davao City Map',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Repair shops & e-waste collection points'),
                ],
              ),
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildFilterChip('All', Icons.all_inclusive),
                _buildFilterChip('Repair Shop', Icons.build),
                _buildFilterChip('Collection Point', Icons.recycling),
              ],
            ),
          ),

          // Locations List
          Expanded(
            child: ListView.builder(
              itemCount: filteredShops.length,
              itemBuilder: (context, index) {
                final shop = filteredShops[index];
                return _buildLocationCard(shop);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: _selectedFilter == label,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
        },
        selectedColor: const Color(0xFF109991),
        labelStyle: TextStyle(
          color: _selectedFilter == label ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> shop) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(
          shop['type'] == 'Repair Shop' ? Icons.build : Icons.recycling,
          color: const Color(0xFF109991),
          size: 32,
        ),
        title: Text(shop['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(shop['address'], style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: (shop['services'] as List).take(2).map((service) {
                return Chip(
                  label: Text(service,
                      style: const TextStyle(fontSize: 10)),
                  backgroundColor: const Color(0xFF109991).withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(shop['distance'], style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                Text(shop['rating'].toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          _showLocationDetails(shop);
        },
      ),
    );
  }

  void _showLocationDetails(Map<String, dynamic> shop) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shop['name'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(shop['address'], style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 15),

              const Text('Services:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...(shop['services'] as List).map((service) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Color(0xFF109991), size: 20),
                  title: Text(service),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 24,
                );
              }).toList(),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _openMaps(shop['lat'], shop['lng']),
                      icon: const Icon(Icons.directions),
                      label: const Text('Get Directions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF109991),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _callLocation(shop['name']),
                      icon: const Icon(Icons.phone),
                      label: const Text('Call'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open maps')),
      );
    }
  }

  void _callLocation(String name) {
    // Simulate calling functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $name...')),
    );
  }
}