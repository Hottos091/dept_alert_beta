import 'dart:convert';
import 'package:dept_alert_beta/events/contact_list_event.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dept_alert_beta/logic/bloc/contact_list_state.dart';


class ContactListBloc extends Bloc<ContactEvent, ContactListState> {
  ContactListBloc() : super(const ContactListState.initial()){
    on<ContactListContactAdded>((event, emit) {
      final List<Contact> newState = List.of(state.contacts);
      
      if(event.contact != null) {
          newState.add(event.contact!);
      }
      emit(ContactListState(contacts: newState, status: ListStatus.loaded));
    });

    on<ContactListContactDeleted>((event, emit) {
      final deleteSuccess = List.of(state.contacts)..removeWhere((element) => element.id == event.contactId);
      emit(ContactListState.success(deleteSuccess));
    });

    on<ContactListContactUpdated>((event, emit) {
      final List<Contact>updatedList = List.of(state.contacts);
      updatedList[event.contact!.id] = event.contact!;
      ///TODO CHANGE METHOD FOR 'List.Where'. This will cause error :
      ///if an user is added after an user has been deleted, id-1 won't be equal to index anymore
      ///with List.Where, List.of(state.contacts) 
      ///=> List.Where(contact.id == event.contactToUpdate.id ?? contact : event.contactToUpdate)

      emit(ContactListState.success(updatedList));
    });

    on<ContactListContactLoading>((event, emit){
      emit(const ContactListState.loading());
    });
  }
  
  List<Contact> get initialState => <Contact>[];
}
  /*@override
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
}*/