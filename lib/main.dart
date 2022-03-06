import 'package:dept_alert_beta/bloc/contact_bloc.dart';
import 'package:dept_alert_beta/presentation/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:dept_alert_beta/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dept_alert_beta/presentation/router/app_router.dart';

import 'model/contact.dart';

Future<void> main() async {
  runApp(MyApp(
    appRouter: AppRouter(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(<Contact> []),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NewContactScreen(title: 'Flutter Demo Home Page'),
      ),
      
    );
  }
}
