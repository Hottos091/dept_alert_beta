import 'package:dept_alert_beta/model/contact.dart';

abstract class ContactEvent {
  Contact? contact;
  int? contactIndex;

  ContactEvent({
    this.contact,
    this.contactIndex,
  });
}

class AddContactEvent extends ContactEvent {
  AddContactEvent({required Contact contact}) : super(contact: contact);
}

class DeleteContactEvent extends ContactEvent {
  DeleteContactEvent({required int contactIndex}) : super(contactIndex: contactIndex);
}

class UpdateContactEvent extends ContactEvent {
  UpdateContactEvent({required Contact contact}) : super(contact: contact);
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