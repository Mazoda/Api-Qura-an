import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/AppRouter/AppRouter.dart';
import 'package:quranapi/firebase_options.dart';
import 'package:quranapi/helpers/SpHelper.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/screens/SplashScreen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SpHelper.spHelper.initS();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DioProvider>(create: (context) => DioProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 900),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
              navigatorKey: AppRouter.navkey);
        });
  }
}
