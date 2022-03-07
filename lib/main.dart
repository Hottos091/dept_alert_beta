import 'package:dept_alert_beta/presentation/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dept_alert_beta/presentation/router/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/bloc/contact_bloc.dart';
import 'model/contact.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  final HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  );

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
