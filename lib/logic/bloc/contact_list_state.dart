//part of 'contact_list_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/contact.dart';

enum ListStatus {loading, loaded, failure}

class ContactListState extends Equatable {
  final ListStatus status;
  final List<Contact> contacts;

  const ContactListState._({
    this.status = ListStatus.loading,
    this.contacts = const <Contact>[],
  });

  const ContactListState({required this.contacts, this.status = ListStatus.loading});

  const ContactListState.initial() : this._();

  const ContactListState.loading() : this._();

  const ContactListState.success(List<Contact> contacts)
    : this._(status: ListStatus.loaded, contacts: contacts);
  
  const ContactListState.failure() : this._(status: ListStatus.failure);

  ContactListState copyWith({List<Contact>? contacts}) {
    return ContactListState._(
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object> get props => [status, contacts];
}