import 'package:expance/app/lang/en_US.dart';
import 'package:expance/app/lang/fa_IR.dart';
import 'package:expance/app/lang/ps_AF.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
User get getuser => FirebaseAuth.instance.currentUser;

class LocalizationService extends Translations {
  String langu;
  void mylang() async {
    try {
      await databaseReference
          .child(getuser.uid)
          .child('lang')
          .once()
          .then((val) {
        print(val.value);
        langu = val.value;
        final locale = _getLocaleFromLanguage(langu);
        Get.updateLocale(locale);
      });
    } catch (e) {
      print('fffffffffffffff' + e);
    }
  }

  static final locale = Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');
  static final langs = ['English', 'فارسی', 'پښتو'];
  static final locales = [
    Locale('en', 'US'),
    Locale('fa', 'IR'),
    Locale('ps', 'AF'),
  ];
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fa_IR': faIR,
        'ps_AF': psAF,
      };
  Locale changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    return locale;
  }
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
  static String getShortLocalCodeForApi() {
    String code = "";
    String getLocalCode = Get.locale.languageCode;
    if (getLocalCode == "en")
      code = "en";
    else if (getLocalCode == "fa")
      code = "da";
    else if (getLocalCode == "ps") code = "ps";

    return code;
  }

  String standardLandguageCode() {
    var formated = Get.locale.languageCode.toLowerCase() +
        "_" +
        Get.locale.countryCode.toUpperCase();
    print(formated);
    return formated;
  }
}
