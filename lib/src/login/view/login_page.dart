import 'package:authentication_repository_firebase/authentication_repository.dart';
import 'package:bloc_tutorials/src/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}