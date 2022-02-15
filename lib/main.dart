import 'dart:async';
import 'package:bac_news/src/ui/save_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeService();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SaveLocationScreen(),
    ),
  );
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  service.setForegroundMode(true);
  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();
    service.setNotificationInfo(
      title: "My App Service",
      content: "Updated at ${DateTime.now()}",
    );

    service.sendData(
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
}
