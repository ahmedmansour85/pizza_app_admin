class MyUserEntity {
  String userid;
  String email;
  String username;
  bool hasActiveCart;
  bool isAdmin;

  MyUserEntity({
    required this.isAdmin,
    required this.email,
    required this.hasActiveCart,
    required this.userid,
    required this.username,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userid,
      'email': email,
      'username': username,
      'hasActiveCart': hasActiveCart,
      'isAdmin': isAdmin
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        email: doc['email'] ?? '',
        hasActiveCart: doc['hasActiveCart'] ?? false,
        userid: doc['userid'] ?? '',
        username: doc['username'] ?? '',
        isAdmin: doc['isAdmin'] ?? false);
  }
}
