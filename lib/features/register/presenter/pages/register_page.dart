import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/features/home/bloc/home_bloc.dart';
import 'package:frontend_mobile/features/home/bloc/home_state.dart';
import 'package:frontend_mobile/features/login/bloc/login_bloc.dart';
import 'package:frontend_mobile/features/login/bloc/login_event.dart';
import 'package:frontend_mobile/features/register/bloc/register_bloc.dart';
import 'package:frontend_mobile/features/register/bloc/register_event.dart';
import 'package:frontend_mobile/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  static const path = '/register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formState = GlobalKey<FormState>();
  String? error;

  @override
  void initState() {
    super.initState();
    nameController.text = 'Alex Under';
    emailController.text = 'alex@email.com';
    passwordController.text = '123123123';

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<RegisterBloc>(context).stream.listen((state) {
        if (state.error == null || state.error!.isEmpty) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Gagal :('),
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formState,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Fullname'),
                ),
                validator: (val) {
                  if (val!.isEmpty) return 'fullname can not empty';
                  return null;
                },
              ),
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
                child: const Text('Register'),
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    BlocProvider.of<RegisterBloc>(context).add(RegisterLoading(
                      register: Register(
                        fullname: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
