// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/pages/notification/components/components.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/constants.dart';
import '../../configs/widget/empty/empty.dart';
import '../../configs/widget/text/paragraph.dart';
import 'notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(),
      viewModel: NotificationViewModel(), 
      builder: (context, viewModel, child) => buildScreen(),
    );
  }

  Widget buildAppBar(){
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        top: 14,
        bottom: 10,
        left: SizeToPadding.sizeMedium,
        right: SizeToPadding.sizeMedium,
      ),
      color: AppColors.BLACK_500,
      child: Paragraph(
        content: 'Thông báo',
        textAlign: TextAlign.center,
        style: STYLE_LARGE.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.COLOR_WHITE
        ),
      )
    );
  }

  Widget buildNotification(){
    return _viewModel!.listCar.isEmpty
      ? Padding(
        padding: EdgeInsets.only(top: SizeToPadding.sizeBig * 7),
        child: const EmptyDataWidget(
          title: 'không tìm thấy',
          content: 'Hiện tại không có thông báo nào. Vui lòng quay lại sau!',
        ),
      )
      : ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _viewModel!.listCar.length,
        itemBuilder: (context, index) => NotificationCarWidget(
          context: context,
          car: _viewModel!.listCar[index],
        ),
      );
  }

  Widget buildScreen(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAppBar(),
            buildNotification(),
          ],
        ),
      )
    );
  }
}