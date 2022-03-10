import 'dart:convert';

const String tableContacts = 'contact';

class ContactFields {
  static const String id = '_id';
  static const String firstname = 'firstname';
  static const String lastname = 'lastname';
  static const String emailAddress = 'email_address';
}

class Contact {
  static int contactCpt = 0;
  late final int id;
  late final String firstname;
  late final String lastname;
  late final String emailAddress;

  Contact({required this.id, required this.firstname, required this.lastname, required this.emailAddress}) {
    contactCpt++;
  }

  Contact.fromMap(Map<String, dynamic> map){
    id = map[ContactFields.id];
    firstname = map[ContactFields.firstname];
    lastname = map[ContactFields.lastname];
    emailAddress = map[ContactFields.emailAddress];
  }

  Contact.fromMapEntry(MapEntry<String, dynamic> mapEntry){
    id = int.parse(mapEntry.key);
    firstname = mapEntry.value[ContactFields.firstname];
    lastname = mapEntry. value[ContactFields.lastname];
    emailAddress = mapEntry.value[ContactFields.emailAddress];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'emailAddress': emailAddress,
    };
  }

  dynamic getListMap(List<dynamic> items) {
    //if (items == null) return null;
    List<Map<String, dynamic>> contactItems = [];
    for (var element in items) {
      contactItems.add(element.toMap());
    }

    return contactItems;
  }

  @override
  String toString() {
    return "ID : $id\nFirstname : $firstname\nLastname : $lastname\nEmail Address : $emailAddress";
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));
  
  Contact copyWith({int? id, String? firstname, String? lastname, String? emailAddress}) {
    return Contact(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }
  
  @override
  // ignore: override_on_non_overriding_member
  List<Object> get props => [id, firstname, lastname, emailAddress];
}
