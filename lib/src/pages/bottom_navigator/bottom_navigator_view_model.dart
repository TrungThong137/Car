import 'package:car_app/src/configs/base/base.dart';
import 'package:flutter/material.dart';

import '../../models/infor_drawer.dart';

class BottomNavigatorViewModel extends BaseViewModel{

  int selectedIndex=0;

  List<InforDrawer> inforDrawer=[
    InforDrawer(icon: Icons.home_outlined, text: 'Home'),
    InforDrawer(icon: Icons.search, text: 'Search'),
    InforDrawer(icon: Icons.star_outline, text: 'Star'),
    InforDrawer(icon: Icons.favorite_outline, text: 'Heart'),
    InforDrawer(icon: Icons.logout, text: 'Log out'),
  ];

  dynamic init(int? page){
    selectedIndex=page??0;
    notifyListeners();
  }

  void changePage(int page){
    selectedIndex=page;
    notifyListeners();
  }
}