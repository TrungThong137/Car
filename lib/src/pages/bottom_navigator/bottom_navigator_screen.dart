// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/widget/diaglog/dialog.dart';
import 'package:car_app/src/pages/profile_page/profile_screen.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../notification/notification_screen.dart';
import '../car_order/car_order_screen.dart';
import 'bottom_navigator.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  BottomNavigatorViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {

    final page= ModalRoute.of(context)?.settings.arguments;

    return BaseWidget(
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(page as int?),
      viewModel: BottomNavigatorViewModel(), 
      builder: (context, viewModel, child) => buildScreen()
    );
  }

  Widget buildScreen(){
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _viewModel!.selectedIndex,
          selectedIconTheme: const IconThemeData(
            color: Colors.black,
            size: 25
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.withOpacity(0.8),
            size: 20
          ),
          onTap: (index)=> _viewModel!.changePage(index),
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:"Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label:"Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody()  {
    if(_viewModel!.selectedIndex == 0) {
      return const HomePage();
    } else if(_viewModel!.selectedIndex==1) {
      return const CarOrderScreen();
    } else if(_viewModel!.selectedIndex==2){
      return const NotificationScreen();
    }else{
      return const ProfileScreen();
    }
  }
}