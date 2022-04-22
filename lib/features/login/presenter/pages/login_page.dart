import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/features/home/bloc/home_bloc.dart';
import 'package:frontend_mobile/features/home/bloc/home_state.dart';
import 'package:frontend_mobile/features/login/bloc/login_bloc.dart';
import 'package:frontend_mobile/features/login/bloc/login_event.dart';
import 'package:frontend_mobile/features/register/presenter/pages/register_page.dart';
import 'package:frontend_mobile/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  static const path = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formState = GlobalKey<FormState>();
  String? error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<LoginBloc>(context).stream.listen((state) {
        if (state.error == null || state.error!.isEmpty) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email atau password tidak valid.'),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Form(
                  key: formState,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          label: Text('Email'),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) return 'email can not empty';
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          label: Text('Password'),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) return 'password can not empty';
                          return null;
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          if (formState.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginLoading(
                              login: Login(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ));
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Belum punya akun?'),
                            TextButton(
                              child: const Text('Register'),
                              onPressed: () {
                                Navigator.of(context)
                                    .popAndPushNamed(RegisterPage.path);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
