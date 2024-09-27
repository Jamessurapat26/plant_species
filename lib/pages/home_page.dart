import 'package:flutter/material.dart';
import 'plant_detail_page.dart';
import '../database/db_helper.dart';
import '../models/plant.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    final plants = await DBHelper.fetchPlants();
    setState(() {
      _plants = plants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Database'),
      ),
      body: _plants.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _plants.length,
              itemBuilder: (context, index) {
                final plant = _plants[index];
                return ListTile(
                  title: Text(plant.plantName),
                  subtitle: Text(plant.plantScientific),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlantDetailPage(plantID: plant.plantID),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
