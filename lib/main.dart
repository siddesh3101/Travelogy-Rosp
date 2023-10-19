import 'package:coep/pages/first_screen.dart';
import 'package:coep/pages/pehchan/add_socials.dart';
import 'package:coep/pages/button.dart';
import 'package:coep/pages/fake_shut_down.dart';
import 'package:coep/pages/home_page.dart';

import 'package:coep/pages/offline_page.dart';
import 'package:coep/pages/pehchan/bloc/social_bloc.dart';
import 'package:coep/pages/pehchan/new.dart';
import 'package:coep/pages/pehchan/router.dart';
import 'package:coep/pages/pehchan/social_home_screen.dart';
import 'package:coep/pages/pehchan/splash_screen.dart';
import 'package:coep/pages/select_date.dart';
import 'package:coep/pages/siren.dart';
import 'package:coep/pages/welcome_screen.dart';
import 'package:coep/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'geofenching.dart';
import 'maps.dart';

LoggedInUserModel currentUser = LoggedInUserModel();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CreateQrBloc()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          onGenerateRoute: AppRouter.routes,
          // localizationsDelegates: GlobalMaterialLocalizations.delegates,
          // supportedLocales: const [
          //   Locale('en', ''),
          //   Locale('zh', ''),
          //   Locale('he', ''),
          //   Locale('es', ''),
          //   Locale('ru', ''),
          //   Locale('ko', ''),
          //   Locale('hi', ''),
          // ],
          home: HomeScreen()),
    );
  }
}
