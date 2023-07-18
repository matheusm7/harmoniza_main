import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/pages/consultation/query_definition_page.dart';
import 'package:harmoniza_ativos/app/service/auth_service.dart';
import 'package:provider/provider.dart';

import 'app/pages/consultation/actives.dart';
import 'app/pages/consultation/asset_classes_page.dart';
import 'app/pages/homepage/home_page.dart';
import 'app/pages/login/login_page.dart';
import 'app/pages/main_page.dart';
import 'app/pages/register/register_page.dart';

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
          '/activesPage': (context) => const ActivesPage(
                subclasses: [],
                classNames: [],
              ),
        },
        debugShowCheckedModeBanner: false,
        home: const QueryDefinition(),
      ),
    );
  }
}
