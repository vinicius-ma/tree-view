
import 'package:flutter/material.dart';
import '../models/asset_type.dart';
import '../theme/colors.dart';

class AssetExpandableItem extends StatefulWidget {
  final String title;
  final AssetType type;
  final List<Widget> children;

  const AssetExpandableItem({
    super.key,
    required this.title,
    required this.type,
    this.children = const [],
  });

  @override
  State<AssetExpandableItem> createState() => AssetExpandableItemState();
}

class AssetExpandableItemState extends State<AssetExpandableItem> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Row(
          children: [
            ImageIcon(
              AssetImage('assets/images/${widget.type.icon}.png'),
              color: TractianColors.lightBlue,
              size: 24,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        dense: true,
        tilePadding: const EdgeInsets.only(left: 4),
        childrenPadding: const EdgeInsets.only(left: 20),
        children: widget.children,
      ),
    );
  }

  void addChildren(List<Widget> children) {
    setState(() {
      children.addAll(children);
    });
  }
}
