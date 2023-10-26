
import 'package:flutter/material.dart';

import '../routers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: widget!,
      ),
      
      // locale: AppPref.isCheckLocale == _Contants.defaultLanguage
      //     ? window.locale
      //     : AppPref.isCheckLocale == _Contants.languageVietName
      //         ? const Locale(_Contants.languageVietName, _Contants.countryVN)
      //         : const Locale(
      //             _Contants.languageEnglish,
      //             _Contants.countryEnglish,
      //           ),
      initialRoute: Routers.getStarted,
      onGenerateRoute: Routers.generateRoute,
      // home: const SplashScreen(),
    );
  }
}