import 'package:dept_alert_beta/events/contact_event.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBloc extends Bloc<ContactEvent, List<Contact>> {
  ContactBloc(List<Contact> initialState) : super(initialState){

    on<AddContactEvent>((event, emit) {
      List<Contact> newState = List.from(state);
      if(event.contact != null) {
          newState.add(event.contact!);
      }
      emit(newState);
    });
  }

  List<Contact> get initialState => <Contact>[];

  /*Stream<List<Contact>> mapEventToState(ContactEvent event) async* {
    switch (event.eventType) {
      case EventType.add:
        List<Contact> newState = List.from(state);
        if(event.contact != null) {
          newState.add(event.contact!);
        }
        yield newState;
        break;

      case EventType.delete:
        List<Contact> newState = List.from(state);
        newState.removeAt(event.contactIndex!);
        yield newState;
        break;

      case EventType.update:
        List<Contact> newState = List.from(state);
        newState[event.contactIndex!] = event.contact!;
        yield newState;
        break;

      default:
        throw Exception('Event not found $event');
    }
  }*/
}