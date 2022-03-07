import 'dart:convert';

import 'package:dept_alert_beta/events/contact_event.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ContactBloc extends Bloc<ContactEvent, List<Contact>> with HydratedMixin{
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

  @override
  List<Contact>? fromJson(Map<String, dynamic> json) {
    return json.entries.map<Contact>((entry) => Contact.fromMapEntry(entry)).toList();
  }

  @override
  Map<String, dynamic>? toJson(List<Contact> state) {//HOWTO create a map from a list
    return { 
      for (var item in state) item.id.toString() : {
        'firstname': item.firstname, 
        'lastname': item.lastname,
        'email_address': item.emailAddress
      } 
    };
  }

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