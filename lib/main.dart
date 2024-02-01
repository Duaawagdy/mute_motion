import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mute_motion/core/utils/AppRouter.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
import 'package:provider/provider.dart';
  void main() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
    ]);
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, child) {
        return MultiProvider(
          providers:
          [
            ChangeNotifierProvider<AuthProvider>(create: (context)=> AuthProvider()),
          ],
          child: MaterialApp
          .router(
          debugShowCheckedModeBanner: false,
          routerConfig: approuter.router,
             //theme: ThemeData.dark(useMaterial3: false).copyWith(scaffoldBackgroundColor: Color(0xff003248))
          ),
        );
      }
    );
  }
}
