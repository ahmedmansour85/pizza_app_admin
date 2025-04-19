import 'models/model.dart';

abstract class UserRepo {
  Stream<MyUser?> get user;

  Future<MyUser> signup(MyUser user, String password);
  Future<void> signin(String email, String password);
  Future<void> signout();
  Future<void> setUserData(MyUser user);
}
