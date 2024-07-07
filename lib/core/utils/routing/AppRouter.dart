import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/feature/about_us/presentation/view/about_as_screen.dart';
import 'package:mute_motion/feature/car_system/presentation/view/car_system_screen.dart';
import 'package:mute_motion/feature/cardetaials/view/cardetailsscreen%20.dart';
import 'package:mute_motion/feature/chat/presentation/views/chat_screen_view.dart';
import 'package:mute_motion/feature/delete_account/presentation/view/delete_completed_screen.dart';
import 'package:mute_motion/feature/delete_account/presentation/view/delete_my_screen.dart';
import 'package:mute_motion/feature/login/presentation/views/forgot_password.dart';
import 'package:mute_motion/feature/login/presentation/views/loginview.dart';
import 'package:mute_motion/feature/map/view/map.dart';
import 'package:mute_motion/feature/my_orders/my_orders/view/my_orders_screen.dart';
//import 'package:mute_motion/feature/my_orders/view/my_orders_screen.dart';
import 'package:mute_motion/feature/navbar/view/navbar_roots.dart';
import 'package:mute_motion/feature/orders_screen/view/orders_screen.dart';
import 'package:mute_motion/feature/presentation/SplashView.dart';
import 'package:mute_motion/feature/profile/presentation/view/profile_screen.dart';
import 'package:mute_motion/feature/resgisterscreen/view/resgisterscreen.dart';
import 'package:mute_motion/feature/searsh/presentation/view/search_screen.dart';
import 'package:mute_motion/feature/signs/presentation/view/signs.dart';
import 'package:mute_motion/feature/traslator/presentation/view/translator_screen.dart';

class approuter {
  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Splashview();
      },
    ),
    GoRoute(
      path: '/loginview',
      builder: (context, state) {
        return login_screen();
      },
    ),
    GoRoute(
      path: '/forgotpassword',
      builder: (context, state) {
        return ForgotPassword();
      },
    ),
    GoRoute(
      path: '/resgister',
      builder: (context, state) {
        return RegisterScreen();
      },
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) {
        return Orders_Screen();
      },
    ),
    GoRoute(
      path: '/navbar',
      builder: (context, state) {
        return Navbar_Roots();
      },
    ),
    GoRoute(
      path: '/aboutus',
      builder: (context, state) {
        return About_As();
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return ProfileScreen();
      },
    ),
    GoRoute(
      path: '/myorders',
      builder: (context, state) {
        return My_Orders();
      },
    ),
    GoRoute(
      path: '/translation',
      builder: (context, state) {
        return Translator_Screen();
      },
    ),
    GoRoute(
      path: '/sign',
      builder: (context, state) {
        return signs();
      },
    ),
    GoRoute(
      path: '/cardetails',
      builder: (context, state) {
        return CarDetailsScreen();
      },
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) {
        return map();
      },
    ),
    GoRoute(
      path: '/carsystem',
      builder: (context, state) {
        return CarSystemScreen();
      },
    ),
    GoRoute(
      path: '/deletemyaccount',
      builder: (context, state) {
        return DeleteAccountScreen();
      },
    ),
    GoRoute(
      path: '/deletecompleted',
      builder: (context, state) {
        return DeleteCompletedScreen();
      },
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        return ChatScreenView();
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        return SearchScreen();
      },
    )
  ]);
  static void clearAndNavigate(BuildContext context, String path) {
    while (context.canPop() == true) {
      context.pop();
    }
    context.pushReplacement(path);
  }
}
