import 'package:car_app/src/models/infor_drawer.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../inbox_page.dart';
import '../car_order/car_order_screen.dart';
import '../profile_page/profile_page.dart';
import '../splash_page/wallet_page.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 25
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey.withOpacity(0.8),
          size: 20
        ),
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:"Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label:"Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label:"Profile",
          ),
        ],
      ),
    );
  }

  Widget getBody( )  {
    if(selectedIndex == 0) {
      return const HomePage();
    } else if(selectedIndex==1) {
      return const CarOrderScreen();
    } else if(selectedIndex==2){
      return const InboxPage();
    }else if(selectedIndex ==3){
      return const WalletPage();
    }else{
      return const ProfilePage();
    }
  }
}

List<InforDrawer> inforDrawer=[
  InforDrawer(icon: Icons.home_outlined, text: 'Home'),
  InforDrawer(icon: Icons.search, text: 'Search'),
  InforDrawer(icon: Icons.star_outline, text: 'Star'),
  InforDrawer(icon: Icons.favorite_outline, text: 'Heart'),
  InforDrawer(icon: Icons.logout, text: 'Log out'),
];