
import 'package:authentication_repository_firebase/authentication_repository.dart';
import 'package:bloc_tutorials/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/login_app/login_app.dart';
import 'src/simple_bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  // await authenticationRepository.user.first;

  runApp( LoginApp(authenticationRepository: authenticationRepository,));
}
