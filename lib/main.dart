import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/config.dart';
import 'package:frontend_mobile/drivers/api.dart';
import 'package:frontend_mobile/features/home/bloc/home_bloc.dart';
import 'package:frontend_mobile/features/home/presenter/pages/home_page.dart';
import 'package:frontend_mobile/features/login/bloc/login_bloc.dart';
import 'package:frontend_mobile/features/login/presenter/pages/login_page.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton<Config>(
    Config(backend: 'http://localhost:8081/api'),
  );
  GetIt.I.registerFactory<Dio>(APIDriver.init);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (c) => HomeBloc()),
      BlocProvider(create: (c) => LoginBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.path,
      routes: {
        HomePage.path: (context) => const HomePage(),
        LoginPage.path: (context) => const LoginPage(),
      },
    );
  }
}
