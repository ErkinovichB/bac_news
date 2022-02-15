import 'package:bac_news/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'location_user_model.dart';

class UserBloc {
  final Repository _repository = Repository();
  var userFetch = PublishSubject<List<LocationUserModel>>();

  Stream<List<LocationUserModel>> get getUserInfo => userFetch.stream;

  getAllUser(int userId) async {
    List<LocationUserModel> data = await _repository.getUser();
    userFetch.sink.add(data);
  }

  dispose() {
    userFetch.close();
  }
}

final userBloc = UserBloc();
