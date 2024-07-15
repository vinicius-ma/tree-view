import 'package:flutter/material.dart';
import 'package:tractian_tree_view/theme/colors.dart';

enum SensorStatus {
  operating("operating"),
  critical("critical", icon:"error", color: TractianColors.red),
  other("other");

  final String name;
  final String? icon;
  final Color? color;

  const SensorStatus(
    this.name, {
    this.icon,
    this.color,
  });

  static SensorStatus? fromName(String? name) {
    return (name == null || name.isEmpty)
        ? null
        : values.firstWhere(
            (element) => element.name == name,
            orElse: () => other,
          );
  }
}
