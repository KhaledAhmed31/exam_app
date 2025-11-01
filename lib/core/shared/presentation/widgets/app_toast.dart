import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

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