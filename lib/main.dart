import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/controller/auth%20controller/auth_controller.dart';
import 'package:harmoniza_ativos/app/data/theme/dark_theme.dart';
import 'package:harmoniza_ativos/app/data/theme/light_theme.dart';
import 'package:harmoniza_ativos/app/pages/consultation/pdf%20page/util/patient_data.dart';
import 'package:harmoniza_ativos/app/pages/historic%20consultation/historic_consultation.dart';
import 'package:provider/provider.dart';

import 'app/controller/app state/app_state.dart';
import 'app/pages/auth pages/login/login_page.dart';
import 'app/pages/auth pages/register/register_page.dart';
import 'app/pages/consultation/actives classes/asset_classes_page.dart';
import 'app/pages/consultation/actives page/actives.dart';
import 'app/pages/consultation/vehicle/historic.dart';
import 'app/pages/homepage/home_page.dart';
import 'app/pages/main_page.dart';

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
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => HistoricConsultationState()),
        ChangeNotifierProvider(create: (_) => PatientData()),
      ],
      child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          routes: {
            '/historicConsultation': (context) => const HistoricConsultation(),
            '/mainPage': (context) => const MainPage(),
            '/loginPage': (context) => const LoginPage(),
            '/registerPage': (context) => const RegisterPage(),
            '/assetClasses': (context) => const AssetClassesPage(
                  periodo: '',
                  isGestante: false,
                  descricao: '',
                  nomeCompleto: '',
                  selectedMedications: [],
                  isPorDiagnosticoSelected: false,
                  selectedVehicleMap: {},
                ),
            '/homePage': (context) => const HomePage(),
            '/activesPage': (context) => const ActivesPage(
                  isGestante: false,
                  periodo: '',
                  descricao: '',
                  nomeCompleto: '',
                  subclasses: [],
                  classNames: [],
                  selectedMedications: [],
                  isPorDiagnosticoSelected: false,
                  selectedVehicleMap: {},
                ),
          },
          debugShowCheckedModeBanner: false,
          home: const LoginPage()),
    );
  }
}
