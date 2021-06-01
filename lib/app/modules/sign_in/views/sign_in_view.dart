import 'package:expance/controller/auth)controller.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:expance/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:lottie/lottie.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 25,
              ),
              Lottie.asset('assets/lot/43885-laptop-working.json'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: GestureDetector(
                  onTap: () async {
                    await AuthController.to.signInWithGoogle();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.chartBlue,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20,
                            color: AppColors.containerShad,
                            offset: Offset(0.0, 2))
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/google2.png'),
                            height: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'signIn'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}
