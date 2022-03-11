import 'package:dept_alert_beta/presentation/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dept_alert_beta/presentation/router/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/bloc/contact_list_bloc.dart';
import 'model/contact.dart';

Future<void> main() async {
  //TODO : CREATE A NEW CUBIT THAT WILL SUBSCRIBE TO CONTACTBLOC. ONE OF THIS NEW CUBIT ATTRIBUTE WILL BE 'contactLastId'
  //And it will keep track of the last id from the list. We'll later save the blocs and cubits as JSON with Hydrated bloc if possible.  If not, with firebase or sqlite
  //TODO #2 :  handle data persistance associated with flutter_bloc >= 8.0.0
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: unused_local_variable
  final HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  );

  HydratedBlocOverrides.runZoned(() => 
    runApp(MyApp(appRouter: AppRouter())),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NewContactScreen(title: 'Flutter Demo Home Page'),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
      
    );
  }
}
