class Plant {
  final int plantID;
  final String plantName;
  final String plantScientific;
  final String plantImage;

  Plant({
    required this.plantID,
    required this.plantName,
    required this.plantScientific,
    required this.plantImage,
  });

  // Factory method to create a Plant object from a map
  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      plantID: map['plantID'],
      plantName: map['plantName'],
      plantScientific: map['plantScientific'],
      plantImage: map['plantImage'],
    );
  }

  // Convert a Plant object into a map
  Map<String, dynamic> toMap() {
    return {
      'plantID': plantID,
      'plantName': plantName,
      'plantScientific': plantScientific,
      'plantImage': plantImage,
    };
  }
}
