import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';

import '../../data/model/user_model.dart';
import '../../routes/app_pages.dart';

class AppController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  set user(User? value) {
    _user.value = value;
  }

  StreamSubscription? streamSubscriptionUser;
  StreamController<User?> userStreamController = StreamController.broadcast();

  Stream<User?> streamUser() async* {
    streamSubscriptionUser = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        user = User.fromJson(event.data()!);
        userStreamController.sink.add(user);
      } else {
        Get.find<AppController>().user = null;
      }
    });
    yield* userStreamController.stream.asBroadcastStream();
  }

  void listenUserFirebase() async {
    if (auth.FirebaseAuth.instance.currentUser != null) {
      streamSubscriptionUser = FirebaseFirestore.instance
          .collection('users')
          .doc(auth.FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        if (event.exists) {
          Get.find<AppController>().user = User.fromJson(event.data()!);
          Get.offAllNamed(Routes.SIGN_IN);
        } else {
          Get.find<AppController>().user = null;
        }
      });
    }
  }

  @override
  void onInit() {
    print('init app controller');
    listenUserFirebase();
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscriptionUser?.cancel();
    super.onClose();
  }

  Future<void> signOut() async {
    print('signout app');
    await auth.FirebaseAuth.instance.signOut();
    Get.find<AppController>().user = null;
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
