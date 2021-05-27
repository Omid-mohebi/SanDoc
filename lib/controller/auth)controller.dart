import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void Function(FirebaseAuthException e) verificationFaildCallBck;
  void Function(Exception e) authExciptionCallBck;
  User get getUser => firebaseAuth.currentUser;
  Rx<User> user = Rx<User>();
  @override
  void onInit() {
    // firebaseAuth.setLanguageCode("en_US");
    user.bindStream(firebaseAuth.authStateChanges());
    print('Auth change  ${firebaseAuth.currentUser}');
    super.onInit();
  }

  @override
  void onReady() async {
    //run every time auth state changes

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Firebase user one-time fetch

  Future<void> signInWithGoogle({bool forceShowAllAccounts = false}) async {
    var isSiginedToGoogle = await GoogleSignIn().isSignedIn();
    if (isSiginedToGoogle) {
      await GoogleSignIn().disconnect();
    }

    // Trigger the authentication flow
    final GoogleSignInAccount googleUser =
        await GoogleSignIn().signIn().whenComplete(() {
      print("blaaaaaaaaa");
    }).catchError((e) {
      print("Error 0xFF000000"); //network error perhabs
    });
    // print(googleUser.displayName);
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    if (googleAuth == null) {
      return;
    }
    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await firebaseAuth.signInWithCredential(credential).then((uc) {
      print("USER ${uc.user.toString()}");
      if (user != null) {
        Get.offNamed(Routes.TAB_HOME, arguments: user);

        print('sign in succeeded: $user');

        return '$user';
      }
      print(user);
      // return null;
      // } catch (e) {
      //   print(e.message);
      //   Get.defaultDialog(
      //       title: 'Oops'.tr,
      //       middleText:
      //           'somethingWrong'.tr,
      //       textConfirm: 'retry'.tr,
      //       confirmTextColor: Colors.white,
      //       onConfirm: () {
      //         Get.back();
      //         googleSignIn();
      // });
      // }
    }).catchError((e) {
      print("e3");
      print(e.message);
      Get.defaultDialog(
          title: 'Oops'.tr,
          middleText: 'somethingWrong'.tr,
          textConfirm: 'retry'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    });
  }

  // Sign out
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    // Utils.whereShouldIGo();
  }

  //user signined to firebase
  Future<bool> isUserSignedInedToFirebase() async {
    return to.getUser != null;
  }
}
