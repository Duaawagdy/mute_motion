// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mute_motion/core/utils/AppRouter.dart';
// import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
// import 'package:mute_motion/feature/resgisterscreen/provider/them_provider.dart';
// import 'package:provider/provider.dart';
//   void main() {
//     WidgetsFlutterBinding.ensureInitialized();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight,
//       DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
//     ]);
//     runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, themeProvider, child) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
//             ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
//           ],
//           child: MaterialApp.router(
//             themeMode: ThemeProvider().themeMode,
//             theme: ThemeData(brightness: Brightness.light),
//             darkTheme: ThemeData(brightness: Brightness.dark),
//             debugShowCheckedModeBanner: false,
//             routerConfig: approuter.router,
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:mute_motion/core/utils/AppRouter.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
import 'models/api_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Request notification permissions
  await _requestNotificationPermission();

  runApp(const MyApp());
}

Future<void> _requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
        Provider<ApiProvider>(create: (context) => ApiProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: approuter.router,
      ),
    );
  }
}