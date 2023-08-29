import 'dart:async';
import 'dart:collection';

import 'package:finflow_iot/core/common/loader.dart';
import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:finflow_iot/core/utils.dart';
import 'package:finflow_iot/features/auth/controller/auth_controller.dart';
import 'package:finflow_iot/features/home/controller/home_controller.dart';
import 'package:finflow_iot/features/home/screens/add_id_page.dart';
import 'package:finflow_iot/features/home/screens/home_screen.dart';
import 'package:finflow_iot/models/sensor_val.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late bool _hasId = false;
  bool isLoading = true;
  // ignore: unused_field
  late StreamSubscription<DatabaseEvent> _subs;
  late SensorVal? sensorData;
  late HashSet<String> errorValues;

  void _onEntryChanged(DatabaseEvent event) {
    setState(() {
      errorValues = ref.read(homeControllerProvider).getIssues(sensorData!);
      sensorData =
          SensorVal.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      final homeProvider = ref.read(homeControllerProvider);
      _hasId = await homeProvider.hasExistingID();
      if (_hasId) {
        sensorData = await homeProvider.fetchLatestData();
        errorValues = homeProvider.getIssues(sensorData!);
        _subs = ref
            .read(homeControllerProvider)
            .getChanges()
            .onValue
            .listen(_onEntryChanged);
      }

      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  void getIdFromQr() async {
    setState(() {
      isLoading = true;
    });
    final res = await ref.read(homeControllerProvider).storeNewId();
    sensorData = await ref.read(homeControllerProvider).fetchLatestData();
    _subs = ref
        .read(homeControllerProvider)
        .getChanges()
        .onChildChanged
        .listen(_onEntryChanged);
    if (res) {
      setState(() {
        isLoading = false;
        _hasId = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: getAppBar(
        appBarActions: [
          GestureDetector(
            onTap: () => getIdFromQr(),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: Color(0xFF23286B),
                    size: 25,
                  ),
                ),
                if (!_hasId)
                  LottieBuilder.asset(
                    Constants.clickLottieFile,
                    height: SizeConfig.screenHeight / 10,
                    repeat: true,
                    animate: true,
                  ),
                SizedBox(
                  height: SizeConfig.screenHeight / 10,
                  width: SizeConfig.screenWidth / 7.5,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(context),
            icon: const Icon(
              Icons.power_settings_new_rounded,
              color: Color.fromARGB(255, 177, 10, 10),
              size: 25,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: !_hasId
                  ? const AddIdPage()
                  : HomeScreen(
                      sensorData: sensorData!,
                      errorValues: errorValues,
                    ),
            ),
    );
  }
}
