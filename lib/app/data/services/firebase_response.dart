class FirebaseResponse<T> {
  String message;
  T? data;
  bool success;

  FirebaseResponse(
      {required this.message, required this.data, required this.success});
}