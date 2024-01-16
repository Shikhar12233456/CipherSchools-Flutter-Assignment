import 'package:cipherx/back-end/box.dart';
import 'package:cipherx/models/Expence.dart';
import 'package:cipherx/provider/bottom-notifier.dart';
import 'package:cipherx/provider/catagory-dropdown-provider.dart';
import 'package:cipherx/provider/expence-data.dart';
import 'package:cipherx/provider/type-provider.dart';
import 'package:cipherx/screens/auth-screen.dart';
import 'package:cipherx/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenceAdapter());
  expenceBox = await Hive.openBox<Expence>('budget');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => ExpenceDataProvider()),
        ChangeNotifierProvider(create: (context) => TypeDropDownProvider()),
        ChangeNotifierProvider(create: (context) => CategoryDropDownProvider()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashS(),
      ),
    );
  }
}
