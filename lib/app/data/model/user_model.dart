class User {
  String email;
  String userName;
  String phoneNumber;
  String userID;
  String fcmToken;
  // List<String> favoriteMenuIdList;

  User({
    this.email = '',
    this.userName = '',
    this.phoneNumber = '',
    this.userID = '',
    this.fcmToken = '',
    // this.favoriteMenuIdList = const [],
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userName: parsedJson['userName'] ?? '',
        userID: parsedJson['userID'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        // favoriteMenuIdList: parsedJson['favoriteMenuId'] != null
        //     ? parsedJson['favoriteMenuId'].cast<String>()
        //     : []
            );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'userID': userID,
      'fcmToken': fcmToken,
      // 'favoriteMenuId': favoriteMenuIdList,
    };
    return json;
  }
}
