import 'package:flutter/material.dart';

class RecyclingScreen extends StatelessWidget {
  const RecyclingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Waste Recycling'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.recycling, size: 64, color: Color(0xFF109991)),
              SizedBox(height: 20),
              Text(
                'E-Waste Recycling',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Responsibly recycle your old electronics to help reduce e-waste and protect the environment.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Text(
                'Features coming soon:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              ListTile(
                leading: Icon(Icons.location_on, color: Color(0xFF109991)),
                title: Text('Find nearby recycling centers'),
              ),
              ListTile(
                leading: Icon(Icons.schedule, color: Color(0xFF109991)),
                title: Text('Schedule pickup services'),
              ),
              ListTile(
                leading: Icon(Icons.eco, color: Color(0xFF109991)),
                title: Text('Track your environmental impact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}