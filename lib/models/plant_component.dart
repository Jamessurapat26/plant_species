class PlantComponent {
  final int componetID;
  final String componentName;
  final String componentIcon;

  PlantComponent({
    required this.componetID,
    required this.componentName,
    required this.componentIcon,
  });

  // Factory method to create a PlantComponent object from a map
  factory PlantComponent.fromMap(Map<String, dynamic> map) {
    return PlantComponent(
      componetID: map['componetID'],
      componentName: map['componentName'],
      componentIcon: map['componentIcon'],
    );
  }

  // Convert a PlantComponent object into a map
  Map<String, dynamic> toMap() {
    return {
      'componetID': componetID,
      'componentName': componentName,
      'componentIcon': componentIcon,
    };
  }
}
