import 'package:bac_news/src/bloc/user_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:location/location.dart';

import 'info_screen.dart';

class SaveLocationScreen extends StatefulWidget {
  const SaveLocationScreen({Key? key}) : super(key: key);

  @override
  _SaveLocationScreenState createState() => _SaveLocationScreenState();
}

class _SaveLocationScreenState extends State<SaveLocationScreen> {
  String text = "Stop Service";
  Location location = Location();

  @override
  void initState() {
    location.enableBackgroundMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Service App'),
          actions: [
            GestureDetector(
              child: Container(
                width: 50,
                color: Colors.red,
                child: Icon(Icons.eleven_mp),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InfoScreen();
                    },
                  ),
                );
                print("object");
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<Map<String, dynamic>?>(
              stream: FlutterBackgroundService().onDataReceived,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                location.getLocation().then(
                      (value) => {
                        userBloc.saveLocation(
                          value.latitude ?? 0.0,
                          value.longitude ?? 0.0,
                        ),
                      },
                    );
                final data = snapshot.data!;
                DateTime? date = DateTime.tryParse(data["current_date"]);
                return Text(date.toString());
              },
            ),
            // ElevatedButton(
            //   child: Text("Foreground Mode"),
            //   onPressed: () {
            //     FlutterBackgroundService()
            //         .sendData({"action": "setAsForeground"});
            //   },
            // ),
            // ElevatedButton(
            //   child: Text("Background Mode"),
            //   onPressed: () {
            //     FlutterBackgroundService()
            //         .sendData({"action": "setAsBackground"});
            //   },
            // ),
            ElevatedButton(
              child: Text(text),
              onPressed: () async {
                final service = FlutterBackgroundService();
                var isRunning = await service.isServiceRunning();
                if (isRunning) {
                  service.sendData(
                    {"action": "stopService"},
                  );
                } else {
                  service.start();
                }

                if (!isRunning) {
                  text = 'Stop Service';
                } else {
                  text = 'Start Service';
                }
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
