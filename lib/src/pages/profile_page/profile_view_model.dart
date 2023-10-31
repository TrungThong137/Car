
import 'package:car_app/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../configs/base/base.dart';
import '../../firebase/firebase_auth.dart';
import '../../models/infor_drawer.dart';
import '../routers.dart';
import '../utils/utils.dart';

class ProfileViewModel extends BaseViewModel{

  int selectedIndex = -1;
  
  FireAuth fireAuth = FireAuth();

  List<InforDrawer> infoDrawer = [
    InforDrawer(icon: Icons.home_outlined, text: 'Home'),
    InforDrawer(icon: Icons.search, text: 'Search'),
    InforDrawer(icon: Icons.star_outline, text: 'Star'),
    InforDrawer(icon: Icons.favorite_outline, text: 'Heart'),
    InforDrawer(icon: Icons.logout, text: 'Log out'),
  ];

  Users? users;

  dynamic init(){
    getUser();
  }

  Future<void> goToSignIn () => Navigator.pushReplacementNamed(context, Routers.signIn);
  Future<void> goToHome () 
    => Navigator.pushReplacementNamed(context, Routers.bottomNavigatorScreen);

  void getUser() async{
    final  id= FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where("id", isEqualTo: id)
        .get();
    final userData = snapshot.docs.map((e) => e.data()).single;
    users= Users.fromJson(userData);
    notifyListeners();
  }

  void onTapItem(int index){
    switch (index) {
      case 0:
        selectedIndex=index;
        goToHome();
        break;
      case 1:
        selectedIndex=index;
        break;
      case 2:
        selectedIndex=index;
        break;
      case 3:
        selectedIndex=index;
        break;
      default:
        selectedIndex=index;
        logout();
    }
  }

  void logout(){
    AppPref.logout();
    fireAuth.signOut();
    goToSignIn();
    notifyListeners();
  }

}