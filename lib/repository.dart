import 'db_helper.dart';
import 'location_user_model.dart';

class Repository {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<LocationUserModel>> getUser() => databaseHelper.getUser();

  Future<int> saveUser(LocationUserModel item) => databaseHelper.saveUser(item);

}
