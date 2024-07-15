import 'package:flutter/material.dart';
import 'package:tractian_tree_view/theme/colors.dart';

enum SensorType {
  energy("energy", icon: "bolt_filled", color: TractianColors.green),
  vibration("vibration"),
  other("other");

  final String name;
  final String? icon;
  final Color? color;

  const SensorType(
    this.name, {
    this.icon,
    this.color,
  });

  static SensorType? fromName(String? name) {
    return (name == null || name.isEmpty) ? null : values.firstWhere(
      (element) => element.name == name,
      orElse: () => other,
    );
  }
}