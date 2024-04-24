import 'package:authentication_repository_firebase/authentication_repository.dart';
import 'package:bloc_tutorials/src/home/view/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/login.dart';
import '../../splash/splash.dart';
import '../login_app.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) =>
            AppBloc(authenticationRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}


class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(listener: (context, state) {
          switch (state.status) {
            case AppStatus.authenticated:
              _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
              break;
            case AppStatus.unauthenticated:
              _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
              break;
            default:
          }
        },
        
        child: child,);
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}