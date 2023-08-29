import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/my_spaces.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  final String title;
  final String sensorVal;
  final String unit;
  final List<double> expectedVal;

  const ErrorTile({
    super.key,
    required this.title,
    required this.sensorVal,
    required this.unit,
    required this.expectedVal,
  });

  String get variation {
    String res = "";
    if (num.parse(sensorVal) > expectedVal[1]) {
      res = "${num.parse(sensorVal) - expectedVal[1]}";
    }
    if (num.parse(sensorVal) < expectedVal[0]) {
      res = "${num.parse(sensorVal) - expectedVal[0]}";
    }
    return res;
  }

  String get expectedRange {
    String res =
        "${expectedVal[0].toInt() == expectedVal[0] ? expectedVal[0].toInt() : expectedVal[0]} ";

    if (expectedVal[1] != 0.0) {
      res +=
          "- ${expectedVal[1].toInt() == expectedVal[1] ? expectedVal[1].toInt() : expectedVal[1]} ";
    }
    return res;
  }

  IconData get icon {
    if (num.parse(sensorVal) > expectedVal[1]) return Icons.arrow_upward;
    if (num.parse(sensorVal) < expectedVal[0]) return Icons.arrow_downward;
    return Icons.priority_high_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF970C0C), width: 0.5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.verticalBlockSize * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: MyFonts.medium.size(16),
                    ),
                    SizedBox(
                      width: SizeConfig.horizontalBlockSize * 2.5,
                    ),
                    const Icon(
                      Icons.warning,
                      color: Color(0xFF970C0C),
                      size: 15,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Take Action',
                      style: MyFonts.medium.size(12).setColor(
                            const Color(0xFF970C0C),
                          ),
                    ),
                    SizedBox(
                      height: SizeConfig.horizontalBlockSize * 2,
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF970C0C),
                      size: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.verticalBlockSize * 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text.rich(
                          TextSpan(
                              text: '$sensorVal ',
                              style: MyFonts.medium
                                  .size(32)
                                  .setColor(Colors.black87),
                              children: [
                                TextSpan(
                                  text: unit,
                                  style: MyFonts.medium
                                      .size(16)
                                      .setColor(Colors.black87),
                                )
                              ]),
                        ),
                        SizedBox(
                          width: SizeConfig.horizontalBlockSize * 2.5,
                        ),
                        Icon(
                          icon,
                          color: const Color(0xFF970C0C),
                          size: 12,
                        ),
                        MySpaces.hSmallestGapInBetween,
                        Text(
                          variation,
                          // '${((double.tryParse(expectedVal)! - double.tryParse(sensorVal)!) / double.tryParse(expectedVal)!) * 100} ',
                          style: MyFonts.medium
                              .size(12)
                              .setColor(const Color(0xFF970C0C)),
                        ),
                      ],
                    ),
                    Text(
                      'Current',
                      style: MyFonts.medium.size(16).setColor(Colors.black87),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: expectedRange,
                            style: MyFonts.medium
                                .size(24)
                                .setColor(Colors.black45),
                            children: [
                              TextSpan(
                                text: unit,
                                style: MyFonts.medium
                                    .size(14)
                                    .setColor(Colors.black45),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Should be',
                      style: MyFonts.medium.size(14).setColor(Colors.black45),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.verticalBlockSize,
          ),
          // Container(
          //   width: double.infinity,
          //   height: 32,
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   decoration: const BoxDecoration(color: Color(0xFFFAEAEA)),
          //   child: Text(
          //     solution,
          //     style: MyFonts.medium.size(14).setColor(const Color(0xFF970C0C)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
