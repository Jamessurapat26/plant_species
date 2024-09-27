import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Database',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    // Initialize the database
    _database = await openDatabase(
      join(await getDatabasesPath(), 'plant_database.db'),
      onCreate: (db, version) async {
        // Create tables
        await db.execute('''
          CREATE TABLE plant (
            plantID INTEGER PRIMARY KEY,
            plantName TEXT,
            plantScientific TEXT,
            plantImage TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE plantComponent (
            componetID INTEGER PRIMARY KEY,
            componentName TEXT,
            componentIcon TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE LandUseType (
            LandUseTypeID INTEGER PRIMARY KEY,
            LandUseTypeName TEXT,
            LandUseTypeDescription TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE LandUse (
            LandUseID INTEGER PRIMARY KEY,
            plantID INTEGER,
            componetID INTEGER,
            LandUseTypeName TEXT,
            LandUseDescription TEXT,
            FOREIGN KEY (plantID) REFERENCES plant(plantID),
            FOREIGN KEY (componetID) REFERENCES plantComponent(componetID)
          )
        ''');

        // Insert initial data
        await _insertInitialData(db);
      },
      version: 1,
    );
  }

  Future<void> _insertInitialData(Database db) async {
    // Insert data into plant table
    await db.insert('plant', {
      'plantID': 101001,
      'plantName': 'Mango',
      'plantScientific': 'Mangifera indica',
      'plantImage': 'mango.jpg',
    });

    await db.insert('plant', {
      'plantID': 101002,
      'plantName': 'Neem',
      'plantScientific': 'Azadirachta indica',
      'plantImage': 'neem.jpg',
    });

    await db.insert('plant', {
      'plantID': 101003,
      'plantName': 'Bamboo',
      'plantScientific': 'Bambusa vulgaris',
      'plantImage': 'bamboo.jpg',
    });

    await db.insert('plant', {
      'plantID': 101004,
      'plantName': 'Ginger',
      'plantScientific': 'Zingiber officinale',
      'plantImage': 'ginger.jpg',
    });

    // Insert data into plantComponent table
    await db.insert('plantComponent', {
      'componetID': 122001,
      'componentName': 'Leaf',
      'componentIcon': 'leaf_icon.png',
    });

    await db.insert('plantComponent', {
      'componetID': 122002,
      'componentName': 'Flower',
      'componentIcon': 'flower_icon.png',
    });

    await db.insert('plantComponent', {
      'componetID': 122003,
      'componentName': 'Fruit',
      'componentIcon': 'fruit_icon.png',
    });

    await db.insert('plantComponent', {
      'componetID': 122004,
      'componentName': 'Stem',
      'componentIcon': 'stem_icon.png',
    });

    await db.insert('plantComponent', {
      'componetID': 122005,
      'componentName': 'Root',
      'componentIcon': 'root_icon.png',
    });

    // Insert data into LandUseType table
    await db.insert('LandUseType', {
      'LandUseTypeID': 201001,
      'LandUseTypeName': 'Food',
      'LandUseTypeDescription': 'Used as food or ingredients',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 201002,
      'LandUseTypeName': 'Medicine',
      'LandUseTypeDescription': 'Used for medicinal purposes',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 201003,
      'LandUseTypeName': 'Insecticide',
      'LandUseTypeDescription': 'Used to repel insects',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 201004,
      'LandUseTypeName': 'Construction',
      'LandUseTypeDescription': 'Used in building materials',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 201005,
      'LandUseTypeName': 'Culture',
      'LandUseTypeDescription': 'Used in traditional practices',
    });

    // Insert data into LandUse table
    await db.insert('LandUse', {
      'LandUseID': 301001,
      'plantID': 101001,
      'componetID': 122003,
      'LandUseTypeName': 'Food',
      'LandUseDescription': 'Mango fruit is eaten fresh or dried',
    });

    await db.insert('LandUse', {
      'LandUseID': 301002,
      'plantID': 101002,
      'componetID': 122001,
      'LandUseTypeName': 'Medicine',
      'LandUseDescription': 'Neem leaves are used to treat skin infections',
    });

    await db.insert('LandUse', {
      'LandUseID': 301003,
      'plantID': 101003,
      'componetID': 122004,
      'LandUseTypeName': 'Construction',
      'LandUseDescription': 'Bamboo stems are used in building houses',
    });

    await db.insert('LandUse', {
      'LandUseID': 301004,
      'plantID': 101004,
      'componetID': 122005,
      'LandUseTypeName': 'Medicine',
      'LandUseDescription': 'Ginger roots are used for digestive issues',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Database'),
      ),
      body: Center(
        child: Text('Database initialized with sample data!'),
      ),
    );
  }
}
