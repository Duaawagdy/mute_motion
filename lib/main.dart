import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mute_motion/core/utils/AppRouter.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/them_provider.dart';
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
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, themeProvider, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
            ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
          ],
          child: MaterialApp.router(
            themeMode: ThemeProvider().themeMode,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            debugShowCheckedModeBanner: false,
            routerConfig: approuter.router,
          ),
        );
      },
    );
  }
}
