enum SensorType {
  energy,
  vibration,
  other;

  static SensorType? fromName(String? name) {
    return (name == null || name.isEmpty) ? null : values.firstWhere(
      (element) => element.name == name,
      orElse: () => other,
    );
  }
}