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

class ContactListContactDeleted extends ContactEvent {
  ContactListContactDeleted({required int contactId}) : super(contactId: contactId);
}

class ContactListContactUpdated extends ContactEvent {
  ContactListContactUpdated({required Contact contact}) : super(contact: contact);
}

/*enum EventType {add, delete, update}


class ContactEvent {
  Contact? contact;
  int? contactIndex;
  EventType? eventType;

  ContactEvent({
    required this.contact,
    required this.contactIndex,
    required this.eventType,
  });

  ContactEvent.add({required this.contact}) {
    eventType = EventType.add;
  }
  ContactEvent.update({required this.contact, required this.contactIndex}) {  
    eventType = EventType.update;
  }

  ContactEvent.delete({required this.contactIndex}) {
    eventType = EventType.delete;
  }
}*/