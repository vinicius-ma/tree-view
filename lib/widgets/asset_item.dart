
import 'package:flutter/material.dart';
import 'package:tractian_tree_view/models/asset_type.dart';
import 'package:tractian_tree_view/models/sensor_status.dart';
import 'package:tractian_tree_view/models/sensor_type.dart';
import 'package:tractian_tree_view/theme/colors.dart';

class AssetItem extends StatelessWidget {
  final String title;
  final AssetType type;
  final SensorStatus? status;
  final SensorType? sensorType;
  final int treeLevel;

  const AssetItem({
    super.key,
    required this.title,
    required this.type,
    required this.treeLevel,
    this.status,
    this.sensorType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: (8 * treeLevel).toDouble()),
      child: Row(
        children: [
          ImageIcon(
            AssetImage('assets/images/${type.icon}.png'),
            color: TractianColors.lightBlue,
            size: 24,
          ),
          Flexible(
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          status?.icon != null
              ? statusIcon() : Container(),
              sensorType?.icon != null 
              ? sensorIcon() : Container(),
        ],
      ),
    );
  }

  ImageIcon sensorIcon() {
    return ImageIcon(
                  AssetImage('assets/images/${sensorType!.icon}.png'),
                  color: sensorType!.color,
                  size: 16,
                );
  }

  ImageIcon statusIcon() {
    return ImageIcon(
              AssetImage('assets/images/${status!.icon}.png'),
              color: status!.color,
              size: 16,
            );
  }
}
