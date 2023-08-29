import 'dart:collection';

import 'package:finflow_iot/core/common/error_tile.dart';
import 'package:finflow_iot/core/common/tile_widget.dart';
import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/my_spaces.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:finflow_iot/features/home/controller/home_controller.dart';
import 'package:finflow_iot/models/sensor_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  final SensorVal sensorData;
  final HashSet<String> errorValues;
  const HomeScreen({
    required this.sensorData,
    required this.errorValues,
    super.key,
  });

  void requestTest(WidgetRef ref) {
    ref.read(homeControllerProvider).requestTest();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> sensorMap = sensorData.toMap();
    return SizedBox.expand(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MySpaces.vGapInBetween,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Updated: ',
                          style:
                              MyFonts.medium.size(16).setColor(Colors.black45),
                        ),
                        Text(
                          "${DateFormat().add_MMMMEEEEd().format(sensorData.timeStamp)} at ${DateFormat().add_jmz().format(sensorData.timeStamp)}",
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFF048204)),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => requestTest(ref),
                  icon: const Icon(Icons.replay_sharp),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Color(0xFFD3EAFF),
            ),
            if (errorValues.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Row(
                  children: errorValues.map((sensorName) {
                    final sensorInfo = Constants.sensors[sensorName]!;
                    return ErrorTile(
                      title: sensorInfo.title,
                      sensorVal: sensorMap[sensorName].toString(),
                      unit: sensorInfo.unit,
                      expectedVal: sensorInfo.expectedVal,
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: ((SizeConfig.horizontalBlockSize * 45) /
                  (SizeConfig.verticalBlockSize * 10)),
              children: sensorMap.keys.map((key) {
                return TileWidget(
                  title: Constants.sensors[key]!.title,
                  status: errorValues.contains(key) ? "Error" : "Good",
                  st: errorValues.contains(key)
                      ? MyFonts.medium.size(13).setColor(Colors.red)
                      : MyFonts.medium.size(13),
                );
              }).toList(),
            ),
            MySpaces.vGapInBetween,
            if (errorValues.isEmpty)
              Image.asset(
                Constants.homePageImage,
              ),
            MySpaces.vGapInBetween,
            if (errorValues.isEmpty)
              Container(
                width: MediaQuery.of(context).size.width / 1.09,
                height: MediaQuery.of(context).size.height / 18.45,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F9FF),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFFD3EAFF),
                      width: 0.5,
                    )),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Color(0xFF23286B),
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'No immediate action required',
                      style: TextStyle(
                        color: Color(0xFF23286B),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

//   Future<void> getData() async {
//     DatabaseReference ref = FirebaseDatabase.instance.ref('ID1');
//     ref.onValue.listen((DatabaseEvent event) {
//       final data = event.snapshot.value;
//       print(data);
//     });
//   }
// }
