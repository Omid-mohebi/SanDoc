import 'package:flutter/material.dart';

class AppThemeConsts {
  static  getWindowHeightInSafeArea (context){

return      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  }
}
