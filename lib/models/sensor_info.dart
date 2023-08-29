class SensorInfo {
  String title;
  String unit;
  List<double> expectedVal;
  SensorInfo({
    required this.title,
    required this.unit,
    required this.expectedVal,
  });

  SensorInfo copyWith({
    String? title,
    String? unit,
    List<double>? expectedVal,
  }) {
    return SensorInfo(
      title: title ?? this.title,
      unit: unit ?? this.unit,
      expectedVal: expectedVal ?? this.expectedVal,
    );
  }
}
