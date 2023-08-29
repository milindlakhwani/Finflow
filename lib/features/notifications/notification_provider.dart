import 'package:finflow_iot/core/providers/firebase_providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider = Provider(
  (ref) => Notification(
    firebaseMessaging: ref.read(messaginProvider),
  ),
);

class Notification {
  final FirebaseMessaging _firebaseMessaging;

  Notification({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}
