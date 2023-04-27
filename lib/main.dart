import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/splash_screen.dart';
import 'package:frenzy_seller/theme/custom_theme.dart';
import 'package:frenzy_seller/theme/theme.dart';
import 'package:frenzy_seller/utils/custom_scrool_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyDxYwRoOFAFujdaxzf6xbeCUB4C6Ve9G9I",
      authDomain: "frenzy-store-flutter.firebaseapp.com",
      projectId: "frenzy-store-flutter",
      storageBucket: "frenzy-store-flutter.appspot.com",
      messagingSenderId: "670937123556",
      appId: "1:670937123556:web:669ec5b61560580a573af1",
    )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp( CustomTheme(
    initialThemeKey: MyThemeKeys.LIGHT,

    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.of(context),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: const SplashScreen()
    );
  }
}

