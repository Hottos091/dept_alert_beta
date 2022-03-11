import 'package:dept_alert_beta/model/contact.dart';

abstract class ContactEvent {
  Contact? contact;
  int? contactId;

  ContactEvent({
    this.contact,
    this.contactId,
  });
}

class ContactListContactAdded extends ContactEvent {
  ContactListContactAdded({required Contact contact}) : super(contact: contact);
}

class ContactListContactLoading extends ContactEvent {
  ContactListContactLoading() : super();
}

class ContactListContactDeleted extends ContactEvent {
  ContactListContactDeleted({required int contactId}) : super(contactId: contactId);
}
class ContactListContactUpdating extends ContactEvent {
  ContactListContactUpdating({required Contact contact}) : super(contact: contact);
}
class ContactListContactUpdated extends ContactEvent {
  ContactListContactUpdated({required Contact contact}) : super(contact: contact);
}