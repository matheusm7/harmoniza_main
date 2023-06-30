import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/providers/auth_provider.dart';
import 'package:harmoniza_ativos/src/pages/navpages/actives.dart';
import 'package:harmoniza_ativos/src/pages/navpages/bottom_navigation_bar.dart';
import 'package:harmoniza_ativos/src/pages/navpages/consultation/query_definition_page.dart';
import 'package:harmoniza_ativos/src/pages/navpages/homepage/home_page.dart';
import 'package:harmoniza_ativos/src/pages/navpages/login/login_page.dart';
import 'package:harmoniza_ativos/src/pages/navpages/register/register_page.dart';
import 'package:provider/provider.dart';

import 'src/pages/navpages/consultation/asset_classes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        routes: {
          '/mainPage': (context) => const MainPage(),
          '/loginPage': (context) => const LoginPage(),
          '/registerPage': (context) => const RegisterPage(),
          '/assetClasses': (context) => const AssetClassesPage(),
          '/homePage': (context) => const HomePage(),
          '/activesPage': (context) => const ActivesPage(),
        },
        debugShowCheckedModeBanner: false,
        home: const QueryDefinition(),
      ),
    );
  }
}
