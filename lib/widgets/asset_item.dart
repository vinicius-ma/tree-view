
import 'package:flutter/material.dart';
import '../models/asset_type.dart';
import '../models/sensor_status.dart';
import '../models/sensor_type.dart';
import '../theme/colors.dart';

class AssetItem extends StatelessWidget {
  final String title;
  final AssetType type;
  final SensorStatus? status;
  final SensorType? sensorType;

  const AssetItem({
    super.key,
    required this.title,
    required this.type,
    this.status,
    this.sensorType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24),
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
          status?.icon != null ? 
            statusIcon() : 
              sensorType?.icon != null ?
                sensorIcon() : Container(),
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
