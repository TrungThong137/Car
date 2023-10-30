// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/widget/form_field/app_form_field.dart';
import 'package:car_app/src/models/car_model.dart';
import 'package:car_app/src/pages/car_booking/car_booking.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/constants.dart';
import '../../configs/widget/app_bar/custom_appbar.dart';
import '../../configs/widget/button/button.dart';
import '../../configs/widget/text/paragraph.dart';

class CarBookingScreen extends StatefulWidget {
  const CarBookingScreen({super.key});

  @override
  State<CarBookingScreen> createState() => _CarBookingScreenState();
}

class _CarBookingScreenState extends State<CarBookingScreen> {

  CarBookingViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    final dataBooking = ModalRoute.of(context)?.settings.arguments;
    return BaseWidget(
      viewModel: CarBookingViewModel(), 
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(dataBooking as CarModel?),
      builder: (context, viewModel, child) => buildCarBookingScreen(),
    );
  }

  Widget buildAppbar() {
    return Container(
      padding: EdgeInsets.only(
        top: 14,
        bottom: 10,
        left: SizeToPadding.sizeMedium,
        right: SizeToPadding.sizeMedium,
      ),
      color: AppColors.BLACK_500,
      child: CustomerAppBar(
        color: AppColors.COLOR_WHITE,
        style: STYLE_LARGE.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.COLOR_WHITE,
        ),
        onTap: () => Navigator.pop(context),
        title: 'Đặt xe',
      ),
    );
  }

  Widget buildFieldPhone(){
    return AppFormField(
      textEditingController: _viewModel!.phoneController,
      hintText: 'Nhập số điện thoại',
      maxLenght: 10,
      isRequired: true,
      labelText: 'Số điện thoại',
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        _viewModel!
          ..validPhone(value.trim())
          ..onConfirm();
      },
      validator: _viewModel!.messagePhone ?? '',
    );
  }

  Widget buildFieldFullName() {
    return AppFormField(
      labelText: 'Họ và tên',
      hintText: 'Nhập họ và tên',
      textEditingController: _viewModel!.fullNameController,
      onChanged: (value) {
        _viewModel!
          ..validFullName(value.trim())
          ..onConfirm();
      },
      isRequired: true,
      validator: _viewModel!.messageFullName ?? '',
    );
  }

   Widget buildAddress() {
    return AppFormField(
      labelText: 'Địa chỉ',
      hintText: 'Nhập địa chỉ',
      textEditingController: _viewModel!.addressController,
      onChanged: (value) {
        _viewModel!
          ..validAddress(value.trim())
          ..onConfirm();
      },
      isRequired: true,
      validator: _viewModel!.messageAddress ?? '',
    );
  }

  Widget buildFieldEmail() {
    return AppFormField(
      labelText: 'Email',
      hintText: 'Nhập Email',
      textEditingController: _viewModel!.emailController,
      onChanged: (value) {
        _viewModel!
          ..validEmail(value.trim())
          ..onConfirm();
      },
      isRequired: true,
      validator: _viewModel!.messageEmail ?? '',
    );
  }

  Widget buildMethodPay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Paragraph(
          style: STYLE_LARGE_BOLD.copyWith(fontWeight: FontWeight.w500),
          content: 'Thanh toán: ',
        ),
        Paragraph(
          style: STYLE_LARGE_BOLD.copyWith(fontWeight: FontWeight.w500),
          content: 'Thanh toán sau khi nhận xe',
        ),
      ],
    );
  }

  Widget buildNameCar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Paragraph(
            style: STYLE_LARGE_BOLD.copyWith(fontWeight: FontWeight.w500),
            content: 'Xe đặt: ',
          ),
          Paragraph(
            style: STYLE_LARGE_BOLD.copyWith(),
            content: _viewModel!.carModel?.name,
          ),
        ],
      ),
    );
  }

  Widget buildMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Paragraph(
          style: STYLE_BIG.copyWith(fontWeight: FontWeight.w500),
          content: 'Tổng tiền: ',
        ),
        Paragraph(
          style: STYLE_LARGE_BOLD.copyWith(color: AppColors.PRIMARY_RED),
          content: _viewModel!.carModel?.price.toString(),
        ),
      ],
    );
  }

  Widget buildNote() {
    return AppFormField(
      maxLines: 3,
      textEditingController: _viewModel!.noteController,
      labelText: 'Ghi chú',
    );
  }

   Widget buildConfirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeToPadding.sizeMedium * 2,
      ),
      child: AppButton(
        content: 'Xác nhận',
        enableButton: _viewModel!.enableButton,
        onTap: () => _viewModel!.bookingCar(),
      ),
    );
  }

  Widget buildFieldInfoUser(){
    return Padding(
      padding: EdgeInsets.only(
        top: SizeToPadding.sizeMedium,
        left: SizeToPadding.sizeMedium,
        right: SizeToPadding.sizeMedium,
      ),
      child: Column(
        children: [
          buildFieldPhone(),
          buildFieldFullName(),
          buildAddress(),
          buildFieldEmail(),
          buildNote(),
          buildMethodPay(),
          buildNameCar(),
          buildMoney(),
          buildConfirmButton(),
        ],
      ),
    );
  }

  Widget buildCarBookingScreen(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAppbar(),
            buildFieldInfoUser(),
          ],
        ),
      ),
    );
  }
}