import 'package:bac_news/src/bloc/user_block.dart';
import 'package:bac_news/src/model/location_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    userBloc.getAllUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<LocationUserModel>>(
        stream: userBloc.getUserInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LocationUserModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                return Container(
                  height: 20,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        data[index].id.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        data[index].latitude.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        data[index].longitude.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
