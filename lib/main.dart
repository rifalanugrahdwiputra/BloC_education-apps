import 'package:education_bloc/modules/auth/login_page.dart';
import 'package:education_bloc/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/home_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getTokenFromSharedPreferences();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const MyApp()),
  );
}

Future<String> getTokenFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool token = false;
  @override
  void initState() {
    super.initState();
    getTokenFromSharedPreferences();
  }

  Future<String> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      setState(() {
        token = true;
      });
    } else {
      setState(() {
        token = false;
      });
    }
    return prefs.getString('token') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education BloC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: token != true
          ? LoginScreen()
          : BlocProvider<UserBloc>(
              create: (context) => UserBloc(),
              child: const HomeScreen(),
            ),
    );
  }
}
