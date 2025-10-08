import 'package:flutter/material.dart';
import 'editscreen.dart';
import 'settingsscreen.dart';
import 'paymentscreen.dart';
import 'addressscreen.dart';
import 'helpscreen.dart';
import 'aboutscreen.dart';
import 'screens/recycling_screen.dart'; // Fixed import path
import 'screens/davao_map_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Davao City Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProfileOption(context, 'E-Waste Collection Points Map', Icons.map, const DavaoMapScreen()),
            _buildProfileOption(context, 'E-Waste Recycling', Icons.recycling, const RecyclingScreen()),
            const SizedBox(height: 20),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF109991),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Weszly Keith Empasis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Kempasis@email.com'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildEcoImpact(),
            const SizedBox(height: 20),

            const Text(
              'Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProfileOption(context, 'Edit Profile', Icons.edit, const EditProfileScreen()),
            _buildProfileOption(context, 'Settings', Icons.settings, const SettingsScreen()),
            //_buildProfileOption(context, 'Payment Methods', Icons.payment, const PaymentScreen()),
            _buildProfileOption(context, 'Addresses', Icons.location_on, const AddressScreen()),
            const SizedBox(height: 20),

            const Text(
              'App Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProfileOption(context, 'Help & Support', Icons.help, const HelpScreen()),
            _buildProfileOption(context, 'About ReBooted', Icons.info, const AboutScreen()),
            _buildProfileOption(context, 'E-Waste Recycling', Icons.recycling, const RecyclingScreen()), // Fixed reference
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEcoImpact() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Eco Impact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'By buying and selling secondhand electronics, you\'ve helped reduce e-waste!',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildImpactStat('5', 'Items Bought'),
                _buildImpactStat('3', 'Items Sold'),
                _buildImpactStat('8', 'Total Impact'),
              ],
            ),
            const SizedBox(height: 15),
            const LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF109991)),
            ),
            const SizedBox(height: 5),
            const Text(
              'Level 2 Eco Warrior',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF109991),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, IconData icon, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF109991)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}