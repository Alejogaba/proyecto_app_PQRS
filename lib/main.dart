import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proyecto_p_q_r_s/controlador/auth_helper.dart';

import 'firebase_options.dart';

import 'flutter_flow/internationalization.dart';

import 'index.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart'; //--1

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    bool ready = await GRecaptchaV3.ready(
        "6Le5wysnAAAAABlIaA3rjB6mATXfjfYYrLpi87K5"); //--2
    print("Is Recaptcha ready? $ready");
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  late FluroRouter _router;
  @override
  void initState() {
    super.initState();
    _router = FluroRouter();
    defineRoutes();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProyectoPQRS',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      themeMode: ThemeMode.light,
      initialRoute: 'login',
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            print("Error initializing");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (AuthHelper.estaLogeado()) {
              return VentanaDashboardWidget();
            } else {
              return HomePageWidget();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void defineRoutes() {
    _router.define(
      '/',
      handler: Handler(
        handlerFunc: (context, params) => HomePageWidget(),
      ),
    );
    _router.define(
      '/homePage',
      handler: Handler(
        handlerFunc: (context, params) => HomePageWidget(),
      ),
    );
    _router.define(
      '/registrarPeticion',
      handler: Handler(
        handlerFunc: (context, params) => RegistrarPeticionWidget(),
      ),
    );

    _router.define(
      '/registraSoporte',
      handler: Handler(
        handlerFunc: (context, params) => RegistrarSoporteWidget(),
      ),
    );
    _router.define(
      '/detallesSoporte',
      handler: Handler(
        handlerFunc: (context, params) => DetallesSoporteWidget(),
      ),
    );
    _router.define(
      '/ventanaSoporte',
      handler: Handler(
        handlerFunc: (context, params) => VentanaSoporteWidget(),
      ),
    );
    _router.define(
      '/ventanPQRS',
      handler: Handler(
        handlerFunc: (context, params) => VentanPQRSWidget(),
      ),
    );
    _router.define(
      '/ventanaDashboard',
      handler: Handler(
        handlerFunc: (context, params) => VentanaDashboardWidget(),
      ),
    );
    _router.define(
      '/ventanaFuncionarios',
      handler: Handler(
        handlerFunc: (context, params) => VentanaFuncionariosWidget(),
      ),
    );
    _router.define(
      '/login',
      handler: Handler(
        handlerFunc: (context, params) => LoginWidget(),
      ),
    );
    _router.define(
      '/ventanaDependencias',
      handler: Handler(
        handlerFunc: (context, params) => VentanaDependenciasWidget(),
      ),
    );
  }
}
