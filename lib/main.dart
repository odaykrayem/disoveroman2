import 'package:disoveroman2/utils/scroll_glowing_remover.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common/routes/pages.dart';
import 'common/values/color.dart';
import 'firebase_options.dart';
import 'utils/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance
      // Your personal reCaptcha public key goes here:
      .activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [...AppPages.allBlocProviders(context)],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.green,
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
                fontFamily: 'Lobster',
                textTheme: ThemeData.light().textTheme.copyWith(
                      headlineSmall: const TextStyle(
                          color: Colors.black45,
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AprilFatface'),
                      titleLarge: const TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lobster'),
                    ),
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: AppColors.primaryText,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                )),
            onGenerateRoute: AppPages.GenerateRouteSettings,
          ),
        ));
  }
}
