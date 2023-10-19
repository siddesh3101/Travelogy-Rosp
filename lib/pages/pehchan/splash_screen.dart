import 'dart:async';

import 'package:coep/pages/pehchan/social_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'add_socials.dart';

class SocialSplash extends StatefulWidget {
  static const String routeName = '/splashi';
  @override
  _SocialSplashState createState() => _SocialSplashState();
}

class _SocialSplashState extends State<SocialSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      await Navigator.pushNamed(
        context,
        SocialHomeScreen.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
