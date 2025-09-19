import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  double _minPrice = 0;
  double _maxPrice = 5000;
  String _condition = 'Any';
  String _location = 'Any';
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    // Load search history from storage
    _searchHistory = ['iPhone', 'MacBook', 'Samsung', 'iPad'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(

                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search devices...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onSubmitted: (value) {
                  _performSearch(value);
                },
              ),
            ),
            const SizedBox(height: 10),

            // Search History
            if (_searchHistory.isNotEmpty) ...[
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _searchHistory.map((term) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          _searchController.text = term;
                          _performSearch(term);
                        },
                        child: Chip(
                          label: Text(term),
                          // MODIFICATION: Removed hardcoded background color for theme compatibility
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
            ],

            // Filters
            ExpansionTile(
              title: const Text('Filters'),
              initiallyExpanded: true,
              children: [
                // Category Filter
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Wrap(
                  spacing: 8,
                  children: ['All', 'Phones', 'Laptops', 'Tablets', 'Accessories']
                      .map((category) => FilterChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : 'All';
                      });
                    },
                  ))
                      .toList(),
                ),
                const SizedBox(height: 15),

                // Price Range
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                RangeSlider(
                  values: RangeValues(_minPrice, _maxPrice),
                  min: 0,
                  max: 5000,
                  divisions: 10,
                  labels: RangeLabels(
                    '₱${_minPrice.toInt()}',
                    '₱${_maxPrice.toInt()}',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _minPrice = values.start;
                      _maxPrice = values.end;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₱${_minPrice.toInt()}'),
                    Text('₱${_maxPrice.toInt()}'),
                  ],
                ),
                const SizedBox(height: 15),

                // Condition
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Condition', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Wrap(
                  spacing: 8,
                  children: ['Any', 'New', 'Like New', 'Good', 'Fair']
                      .map((condition) => FilterChip(
                    label: Text(condition),
                    selected: _condition == condition,
                    onSelected: (selected) {
                      setState(() {
                        _condition = selected ? condition : 'Any';
                      });
                    },
                  ))
                      .toList(),
                ),
                const SizedBox(height: 15),

                // Location
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Wrap(
                  spacing: 8,
                  children: ['Any', 'Davao City', 'Maa', 'Mintal', 'Calinan']
                      .map((location) => FilterChip(
                    label: Text(location),
                    selected: _location == location,
                    onSelected: (selected) {
                      setState(() {
                        _location = selected ? location : 'Any';
                      });
                    },
                  ))
                      .toList(),
                ),
                const SizedBox(height: 15),

                // Apply Filters Button
                ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF109991),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
            const SizedBox(height: 20),


            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  void _performSearch(String term) {
    if (term.isNotEmpty && !_searchHistory.contains(term)) {
      setState(() {
        _searchHistory.add(term);
      });
      // Save search history to storage
    }
    _applyFilters();
  }

  void _applyFilters() {
    // Implement actual filter logic here
    final searchTerm = _searchController.text;
    print('Searching for: $searchTerm');
    print('Category: $_selectedCategory');
    print('Price Range: $_minPrice - $_maxPrice');
    print('Condition: $_condition');
    print('Location: $_location');

    // Show a snackbar with applied filters
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filters applied: $_selectedCategory, ₱$_minPrice-₱$_maxPrice, $_condition, $_location'),
        duration: const Duration(seconds: 2),
      ),
    );

    // In a real app, you would fetch filtered results from your backend
  }

  Widget _buildSearchResults() {
    // Simulate search results
    final List<Map<String, dynamic>> results = [
      {'name': 'iPhone 15 Pro', 'price': 'P899', 'location': 'Davao City', 'image': 'assets/images/iphone15pro.jpg'},
      {'name': 'MacBook Pro', 'price': 'P1,199', 'location': 'Mintal', 'image': 'assets/images/macbook.jpg'},
      {'name': 'Samsung Galaxy S23', 'price': 'P699', 'location': 'Calinan', 'image': 'assets/images/placeholder.jpg'},
    ];

    if (_searchController.text.isEmpty) {
      return const Center(
        child: Text('Enter a search term to find devices'),
      );
    }


    return ListView.builder(
      // MODIFICATION: Added these two lines to allow this list to live inside the parent ListView.
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Image.asset(
            item['image'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
          ),
          title: Text(item['name']),
          subtitle: Text('${item['price']} • ${item['location']}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Navigate to product detail
          },
        );
      },
    );
  }
}