import 'dart:typed_data';

import 'package:coep/pages/pehchan/add_socials.dart';
import 'package:coep/pages/pehchan/find_user_screen.dart';
import 'package:coep/pages/pehchan/social_home_screen.dart';
import 'package:coep/pages/pehchan/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case AddSocials.routeName:
        return PageTransition(
          child: const AddSocials(),
          type: PageTransitionType.theme,
        );
      case SocialHomeScreen.routeName:
        return PageTransition(
          child: const SocialHomeScreen(),
          type: PageTransitionType.theme,
        );
      case FindUserScreen.routeName:
        return PageTransition(
          child: const FindUserScreen(),
          type: PageTransitionType.theme,
        );
      case SocialSplash.routeName:
        return PageTransition(
          child: SocialSplash(),
          type: PageTransitionType.theme,
        );

      default:
        return null;
    }
  }
}
