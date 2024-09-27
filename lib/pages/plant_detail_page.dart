import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/plant.dart';
import '../models/plant_component.dart';

class PlantDetailPage extends StatelessWidget {
  final int plantID;

  PlantDetailPage({required this.plantID});

  Future<Plant> _getPlantDetails() async {
    return await DBHelper.fetchPlantDetails(plantID);
  }

  Future<List<PlantComponent>> _getPlantComponents() async {
    return await DBHelper.fetchPlantComponents(plantID);
  }

  Future<List<Map<String, dynamic>>> _getLandUses() async {
    return await DBHelper.fetchLandUses(plantID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
      ),
      body: FutureBuilder<Plant>(
        future: _getPlantDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading plant details'));
          } else {
            final plant = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      plant.plantName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Scientific Name: ${plant.plantScientific}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Components:'),
                  ),
                  FutureBuilder<List<PlantComponent>>(
                    future: _getPlantComponents(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      final components = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: components
                            .map((component) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(component.componentName),
                                ))
                            .toList(),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Land Uses:'),
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getLandUses(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      final landUses = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: landUses
                            .map((landUse) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${landUse['LandUseTypeName']}: ${landUse['LandUseDescription']}'),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
