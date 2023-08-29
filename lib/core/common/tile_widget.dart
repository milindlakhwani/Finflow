import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/my_spaces.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final String title;
  final String status;
  final TextStyle st;

  const TileWidget({
    super.key,
    required this.title,
    required this.status,
    required this.st,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFD3EAFF),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: MyFonts.medium.size(16),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
            MySpaces.vSmallestGapInBetween,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status,
                  style: st,
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 10,
                  color: Color(0xFF23286B),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
