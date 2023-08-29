import 'dart:collection';

import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/utils.dart';
import 'package:finflow_iot/features/home/repository/home_repository.dart';
import 'package:finflow_iot/models/sensor_val.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

final homeControllerProvider = Provider(
  (ref) => HomeController(
    homeRepository: ref.read(homeRepositoryProvider),
  ),
);

class HomeController {
  final HomeRepository _homeRepository;

  HomeController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<bool> hasExistingID() async {
    final hasId = await _homeRepository.hasExistingID();
    return hasId;
  }

  Future<bool> storeNewId() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      cameraStatus = await Permission.camera.request();
    }
    bool status = false;

    if (cameraStatus.isGranted) {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (barcodeScanRes != "-1") {
        _homeRepository.storeNewId(barcodeScanRes);
        status = true;
      }
    } else {
      showToast("Camera Permission Denied");
    }

    return status;
  }

  Future<SensorVal?> fetchLatestData() async {
    final res = await _homeRepository.fetchLatestData();
    SensorVal? data;

    res.fold((l) => showToast(l.message), (r) {
      data = r;
    });

    return data;
  }

  Query getChanges() {
    return _homeRepository.getChanges();
  }

  HashSet<String> getIssues(SensorVal sensorData) {
    HashSet<String> errorValues = HashSet<String>();
    Map<String, dynamic> data = sensorData.toMap();

    data.forEach((String key, value) {
      if ((value as num) < Constants.sensors[key]!.expectedVal[0] ||
          value > Constants.sensors[key]!.expectedVal[1]) {
        errorValues.add(key);
      }
    });

    return errorValues;
  }

  void requestTest() async {
    final res = await _homeRepository.requestTest();

    res.fold(
        (l) => showToast(l.message), (r) => showToast("Test Request Sent!"));

    await _homeRepository.callOffRequest();
  }
}
