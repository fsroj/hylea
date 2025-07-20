import 'package:flutter/material.dart';
import 'package:hylea/screens/modes_screen.dart';
import 'package:hylea/screens/routes_list_screen.dart';

// screens/home_screen.dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hylea'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHomeButton(
              context,
              'Modos de Enfoque',
              Icons.fitness_center,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ModesScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildHomeButton(
              context,
              'Rutas',
              Icons.map,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RoutesListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 30),
      label: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
    );
  }
}