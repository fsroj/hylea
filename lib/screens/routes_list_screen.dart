import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';
import 'package:hylea/screens/create_route_screen.dart';
import 'package:hylea/screens/route_detail_screen.dart';
import 'package:provider/provider.dart';

// screens/routes_list_screen.dart
class RoutesListScreen extends StatelessWidget {
  const RoutesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Rutas'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateRouteScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          if (appData.routes.isEmpty) {
            return const Center(
              child: Text('No has creado ninguna ruta aún.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: appData.routes.length,
            itemBuilder: (context, index) {
              final route = appData.routes[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    route.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateRouteScreen(
                                route: route, // Pass the route for editing
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Show a confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Eliminar Ruta'),
                                content: Text(
                                    '¿Estás seguro de que quieres eliminar la ruta "${route.name}"?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(), // Dismiss dialog
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      appData.deleteRoute(route.id);
                                      Navigator.of(context)
                                          .pop(); // Dismiss dialog
                                    },
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RouteDetailScreen(route: route),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}