// ignore_for_file: unused_field, deprecated_member_use

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/app_bar/custom_appbar.dart';
import 'package:car_app/src/configs/widget/button/button_outline.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:car_app/src/models/car_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/widget/empty/empty.dart';
import '../utils/utils.dart';
import 'car_booking_detail.dart';
import 'components/components.dart';

class CarBookingDetailScreen extends StatefulWidget {
  const CarBookingDetailScreen({super.key});

  @override
  State<CarBookingDetailScreen> createState() => _CarBookingDetailScreenState();
}

class _CarBookingDetailScreenState extends State<CarBookingDetailScreen> {

  CarBookingDetailViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {

    final infoBooking= ModalRoute.of(context)?.settings.arguments;

    return BaseWidget(
      onViewModelReady: (viewModel) 
        => _viewModel=viewModel!..init(infoBooking as CarBookingModel?),
      viewModel: CarBookingDetailViewModel(), 
      builder: (context, viewModel, child) => buildCarBookingDetail(),
    );
  }

  Widget buildAppBar(){
    return CustomerAppBar(
      title: 'Đặt xe thành công',
      onTap:()=> _viewModel!.goToHome(),
    );
  }

  Widget buildIconSuccess(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeMedium),
      child: SvgPicture.asset(AppImages.icCheck, color: AppColors.Green_Money,),
    );
  }

  Widget buildTitleOrderSent(){
    return Paragraph(
      content: 'Đã gửi đơn hàng',
      style: STYLE_BIG.copyWith(
        fontWeight: FontWeight.w700
      ),
    );
  }

  Widget buildInfoUser(){
    final name= _viewModel!.infoBooking?.nameUser;
    final address= _viewModel!.infoBooking?.address;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeVerySmall),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Thông tin vận chuyển của bạn: ',
              style: STYLE_MEDIUM_BOLD.copyWith(color: AppColors.BLACK_500),
            ),
            TextSpan(
              text: '$name. ${_viewModel!.formatPhone()}. $address',
              style: STYLE_MEDIUM.copyWith(color: AppColors.BLACK_400, 
                fontWeight: FontWeight.w500)
            ),
          ]
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeSmall,
        horizontal: SizeToPadding.sizeLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppOutlineButton(
            width: MediaQuery.sizeOf(context).width/3,
            content: 'Thay đổi địa chỉ',
            onTap: () {},
          ),
          AppOutlineButton(
            width: MediaQuery.sizeOf(context).width/3,
            content: 'Xem đơn hàng',
            onTap: () => _viewModel!.goToCarOrder(1),
          )
        ],
      ),
    );
  }

  Widget buildDivider(){
    return Divider(
      color: AppColors.BLACK_400,
      endIndent: SpaceBox.sizeBig,
      indent: SpaceBox.sizeBig,
    );
  }

  Widget buildTitleShowCar(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeVerySmall),
      child: Paragraph(
        content: 'Có thể bạn cũng thích',
        style: STYLE_MEDIUM.copyWith(
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget buildListCar(){
    return _viewModel!.listCar.isEmpty || _viewModel!.listCar==[]?
      Padding(
        padding: EdgeInsets.only(top: SizeToPadding.sizeBig *3),
        child: const EmptyDataWidget(
          title: 'Hãng xe này trống',
          content: 'Hiện tại chưa có xe nào. Vui lòng quay lại sau!',
        ),
      )
      : GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 250,
        ), 
        itemCount: _viewModel!.listCar.length,
        itemBuilder: (context, index) => InfoCarWidget(
          car: _viewModel!.listCar[index],
          onTap: () => _viewModel!.goToCarDetail(index),
        ),
      );
  }

  Widget buildBody(){
    return Column(
      children: [
        buildIconSuccess(),
        buildTitleOrderSent(),
        buildInfoUser(),
        buildButton(),
        buildDivider(),
        buildTitleShowCar(),
        buildListCar(),
      ],
    );
  }

  Widget buildCarBookingDetail(){
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: SizeToPadding.sizeMedium,
          left: SizeToPadding.sizeMedium),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildAppBar(),
              buildBody(),
            ],
          ),
        ),
      ),
    );
  }
}