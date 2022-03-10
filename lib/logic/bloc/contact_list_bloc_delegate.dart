import 'package:dept_alert_beta/events/contact_list_event.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }
  //TODO override onChange + ajouter le observer au ContactBloc
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.currentState);
    print(transition.nextState);
  }

  @override 
  void onError(BlocBase blocbase, Object error, StackTrace stackTrace) {
    super.onError(blocbase, error, stackTrace);
    print(error);
  }

}