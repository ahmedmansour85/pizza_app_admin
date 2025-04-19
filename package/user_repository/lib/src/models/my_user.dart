import '../entities/entity.dart';

class MyUser {
  String userid;
  String name;
  String email;
  bool hasActiveCart;
  bool isAdmin;

  MyUser({
    required this.isAdmin,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    required this.userid,
  });

  static final empty = MyUser(
    email: '',
    name: '',
    hasActiveCart: false,
    userid: '',
    isAdmin: false,
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
        email: email,
        hasActiveCart: hasActiveCart,
        userid: userid,
        isAdmin: isAdmin,
        username: name);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        isAdmin: entity.isAdmin,
        email: entity.email,
        name: entity.username,
        hasActiveCart: entity.hasActiveCart,
        userid: entity.userid);
  }

  @override
  String toString() {
    return 'MyUser:$email,$userid,$name,$hasActiveCart';
  }
}
