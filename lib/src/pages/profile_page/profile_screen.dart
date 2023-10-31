// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/constants/app_space.dart';
import 'package:car_app/src/pages/profile_page/profile.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/constants.dart';
import '../../configs/widget/text/paragraph.dart';
import 'components/components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(),
      viewModel: ProfileViewModel(), 
      builder: (context, viewModel, child) => buildScreen(),
    );
  }

  Widget buildInfoCard(){
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeBig),
      child: InfoCard(
        name: _viewModel!.users?.fullName??'',
        profession: _viewModel!.users?.emailAddress??'',
      ),
    );
  }

  

  Widget buildDivider(){
    return const Padding(
      padding: EdgeInsets.only(left: 24, ),
      child: Divider(
        height: 1.2,
        color: Colors.black,
      ),
    );
  }

  Widget buildListService(){
    return Wrap(
      children: List.generate(_viewModel!.infoDrawer.length, (index) {
        return SlideMenuTitle(
          icon: _viewModel!.infoDrawer[index].icon,
          text: _viewModel!.infoDrawer[index].text,
          index: index,
          selectedIndex: _viewModel!.selectedIndex,
          ontap: ()=> _viewModel!.onTapItem(index),
        );
      }),
    );
  }

  Widget buildAppBar(){
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        vertical: SizeToPadding.sizeLarge,
        horizontal: SizeToPadding.sizeMedium
      ),
      color: AppColors.BLACK_500,
      child: Paragraph(
        content: 'Thông tin tài khoản',
        textAlign: TextAlign.center,
        style: STYLE_LARGE.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.COLOR_WHITE
        ),
      )
    );
  }

  Widget buildScreen(){
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.infinity,
          color: Colors.white,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(),
                buildInfoCard(),
                buildDivider(),
                buildListService(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
