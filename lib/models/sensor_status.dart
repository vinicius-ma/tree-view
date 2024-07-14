enum SensorStatus {
  operating,
  critical,
  other;

  static SensorStatus? fromName(String? name) {
    return (name == null || name.isEmpty) ? null : values.firstWhere(
      (element) => element.name == name,
      orElse: () => other,
    );
  }
}
