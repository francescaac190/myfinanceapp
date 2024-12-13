import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinanceapp/model/add_date.dart';
import 'package:myfinanceapp/screens/home_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myfinanceapp/screens/statistics.dart';
import 'package:myfinanceapp/widgets/bottomnavigationbar.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'MyFinance',
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(primary: Colors.red),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('es', 'ES'), // Spanish
        // Add more locales if needed
      ],
      home: Bottom(),
      routes: <String, WidgetBuilder>{
        '/h': (BuildContext context) => const HomeMain(),
        '/stat': (BuildContext context) => StatisticsPage(),
        // '/a': (BuildContext context) => const HomeMain(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/iconoapp.png'),
                // addVerticalSpace(24),
                Text(
                  'MyFinance',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  'MyFinance es una aplicación que te ayuda a manejar tus finanzas de manera responsable',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/stat');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade400,
                    minimumSize: Size(double.infinity, 50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Comenzar',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
