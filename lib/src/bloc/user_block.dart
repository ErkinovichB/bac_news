import 'package:bac_news/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/location_user_model.dart';

class UserBloc {
  final Repository _repository = Repository();
  var userFetch = PublishSubject<List<LocationUserModel>>();

  Stream<List<LocationUserModel>> get getUserInfo => userFetch.stream;

  getAllUser() async {
    List<LocationUserModel> data = await _repository.getUser();
    userFetch.sink.add(data);
  }

  saveLocation(double latitude, double longitude) {
    _repository.saveUser(
      LocationUserModel(
        longitude: longitude,
        latitude: latitude,
        id: 0,
        currentTime: DateTime.now().hour.toString() +
            ":" +
            DateTime.now().minute.toString(),
      ),
    );
  }

  dispose() {
    userFetch.close();
  }
}

final userBloc = UserBloc();
