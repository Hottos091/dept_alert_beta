const String tableContacts = 'contact';

class ContactFields {
  static const String id = '_id';
  static const String firstname = 'firstname';
  static const String lastname = 'lastname';
  static const String emailAddress = 'email_address';
}

class Contact {
  //static int contactCpt = 0;
  late final int? id;
  late final String firstname;
  late final String lastname;
  late final String emailAddress;

  Contact({this.id, required this.firstname, required this.lastname, required this.emailAddress});

  Contact.fromMap(Map<String, dynamic> map){
    id = map[ContactFields.id];
    firstname = map[ContactFields.firstname];
    lastname = map[ContactFields.lastname];
    emailAddress = map[ContactFields.emailAddress];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'firstname': firstname,
      'lastname': lastname,
      'email_address': emailAddress,
      '_id': id
    };

    return map;
  }
}
