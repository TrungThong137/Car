import 'package:car_app/src/pages/bottom_navigator/bottom_navigator.dart';
import 'package:car_app/src/pages/car_company/car_company.dart';
import 'package:car_app/src/pages/car_detail/car_detail.dart';
import 'package:car_app/src/pages/car_order/car_order_screen.dart';
import 'package:car_app/src/pages/deals_page/top_deals_page_screen.dart';
import 'package:car_app/src/pages/home/home_page.dart';
import 'package:car_app/src/pages/login_page/login.dart';
import 'package:car_app/src/pages/register_page/sign_up_screen.dart';
import 'package:car_app/src/pages/splash_page/preview_page.dart';
import 'package:car_app/src/pages/splash_page/welcom_page.dart';
import 'package:flutter/material.dart';

import 'car_booking/car_booking.dart';
import 'car_booking_detail/car_booking_detail.dart';

class TemplateArguments {
  TemplateArguments(this.data, this.created);
  final dynamic data;
  final String created;
}

class Routers {
  static const String getStarted = '/getStarted';
  static const String home = '/home';
  static const String homeDetails = '/homeDetails';
  static const String previewPage = '/previewPage';
  static const String carCompany = '/carCompany';
  static const String topDetails = '/topDetails';
  static const String carDetail = '/carDetail';
  static const String carBooking = '/carBooking';
  static const String carBookingDetail = '/carBookingDetail';
  static const String carOrder = '/carOrder';
  static const String bottomNavigatorScreen = '/bottomNavigatorScreen';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case getStarted:
        return animRoute(
          const SplashScreen(),
          beginOffset: right,
          name: getStarted,
          arguments: arguments,
        );

      case bottomNavigatorScreen:
        return animRoute(
          const BottomNavigationBarScreen(),
          beginOffset: right,
          name: bottomNavigatorScreen,
          arguments: arguments,
        );

      case carOrder:
        return animRoute(
          const CarOrderScreen(),
          beginOffset: right,
          name: carOrder,
          arguments: arguments,
        );

      case carBookingDetail:
        return animRoute(
          const CarBookingDetailScreen(),
          beginOffset: right,
          name: carBookingDetail,
          arguments: arguments,
        );

      case carBooking:
        return animRoute(
          const CarBookingScreen(),
          beginOffset: right,
          name: carBooking,
          arguments: arguments,
        );
      
      case carDetail:
        return animRoute(
          const CarDetailsScreen(),
          beginOffset: right,
          name: carDetail,
          arguments: arguments,
        );
      
      case topDetails:
        return animRoute(
          const TopDealsPageScreen(),
          beginOffset: right,
          name: topDetails,
          arguments: arguments,
        );
      
      case carCompany:
        return animRoute(
          const CarCompanyScreen(),
          beginOffset: right,
          name: carCompany,
          arguments: arguments,
        );

      case previewPage:
        return animRoute(
          const PreviewPage(),
          beginOffset: right,
          name: previewPage,
          arguments: arguments,
        );

      case home:
        return animRoute(
          const HomePage(),
          beginOffset: right,
          name: home,
          arguments: arguments,
        );

      case signIn:
        return animRoute(
          const LoginScreen(),
          beginOffset: right,
          name: signIn,
          arguments: arguments,
        );

      case signUp:
        return animRoute(
          const SignUpScreen(),
          beginOffset: right,
          name: signUp,
          arguments: arguments,
        );

      // case profileMember:
      //   return animRoute(const ProfileMemberScreen(),
      //       beginOffset: right, name: profileMember, arguments: arguments);

      default:
        return animRoute(
          Center(
            child: Text('No route defined for ${settings.name}'),
          ),
          name: '/error',
        );
    }
  }

  static Route animRoute(
    Widget page, {
    required String name,
    Offset? beginOffset,
    Object? arguments,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = beginOffset ?? const Offset(0, 0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset center = const Offset(0, 0);
  static Offset top = const Offset(0, 1);
  static Offset bottom = const Offset(0, -1);
  static Offset left = const Offset(-1, 0);
  static Offset right = const Offset(1, 0);
}
