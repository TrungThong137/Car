import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../pages/utils/utils.dart';
import '../../constants/constants.dart';
import 'dialog.dart';

Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return WarningDialog(
          image: AppImages.icWarning,
          title: 'Thoát ứng dụng',
          content: 'Bạn muốn thoát ứng dụng không?',
          leftButtonName: 'Hủy',
          color: AppColors.BLACK_500,
          colorNameLeft: AppColors.BLACK_500,
          rightButtonName: 'Xác nhận',
          isWaning: true,
          onTapLeft: () {
            Navigator.pop(context);
          },
          onTapRight: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
        );
      },
    )??false;
  }