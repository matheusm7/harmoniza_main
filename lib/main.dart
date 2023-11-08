import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harmoniza_ativos/app/controller/auth%20controller/auth_controller.dart';
import 'package:harmoniza_ativos/app/data/theme/dark_theme.dart';
import 'package:harmoniza_ativos/app/data/theme/light_theme.dart';
import 'package:harmoniza_ativos/app/pages/auth%20pages/login/login_page.dart';
import 'package:harmoniza_ativos/app/pages/consultation/actives%20classes/asset_classes_page.dart';
import 'package:harmoniza_ativos/app/pages/consultation/actives%20page/actives.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/util/patient_data.dart';
import 'package:harmoniza_ativos/app/pages/consultation/vehicle/historic.dart';
import 'package:harmoniza_ativos/app/pages/historic%20consultation/historic_consultation.dart';
import 'package:harmoniza_ativos/app/pages/homepage/home_page.dart';
import 'package:harmoniza_ativos/app/pages/main_page.dart';
import 'package:harmoniza_ativos/app/pages/onboarding/onboarding_page.dart';
import 'package:provider/provider.dart';

import 'app/controller/app state/app_state.dart';
import 'app/pages/auth pages/register/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  final appState = AppState();
  await appState.init();
  final appStates = HistoricConsultationState();
  await appState.init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthController()), ChangeNotifierProvider.value(value: appState), ChangeNotifierProvider(create: (_) => PatientData()), ChangeNotifierProvider.value(value: appStates)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: {
        '/historicConsultation': (context) => const HistoricConsultation(),
        '/mainPage': (context) => const MainPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/assetClasses': (context) => const AssetClassesPage(periodo: '', isGestante: false, descricao: '', nomeCompleto: '', selectedMedications: [], isPorDiagnosticoSelected: false, selectedVehicleMap: {}),
        '/homePage': (context) => const HomePage(),
        '/activesPage': (context) => const ActivesPage(isGestante: false, periodo: '', descricao: '', nomeCompleto: '', subclasses: [], classNames: [], selectedMedications: [], isPorDiagnosticoSelected: false, selectedVehicleMap: {}),
      },
      debugShowCheckedModeBanner: false,
      home: user != null ? const MainPage() : const OnBoarding(),
    );
  }
}
