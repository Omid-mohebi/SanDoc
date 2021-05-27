import 'package:expance/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FireBaseController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Rx<User> user = Rx<User>();
  @override
  void onInit() {
    user.bindStream(auth.authStateChanges());
    print('Auth change  ${auth.currentUser}');
    super.onInit();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn myGoogleSignIn = GoogleSignIn(scopes: ['email']);

  Future googleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await myGoogleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final User user = await auth
          .signInWithCredential(credential)
          .then((value) => value.user);

      if (user != null) {
        Get.offNamed(Routes.TAB_HOME, arguments: user);

        print('sign in succeeded: $user');

        return '$user';
      }
      print(user);
      return null;
    } catch (e) {
      print(e.message);
      Get.defaultDialog(
          title: 'Oops'.tr,
          middleText:
              'somethingWrong'.tr,
          textConfirm: 'retry'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
            googleSignIn();
          });
    }
  }

  Future signOutUser() async {
    await myGoogleSignIn.signOut();
    await auth.signOut();
    if (auth.currentUser == null) {
      print('sign out succeeded: $user');
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }
}
