import 'package:fluttertoast/fluttertoast.dart';

import '../../../ui_manager/colors/app_colors.dart';

void showAppToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: AppColors.blueBase,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}