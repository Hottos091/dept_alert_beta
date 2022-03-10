import 'package:dept_alert_beta/events/contact_list_event.dart';
import 'package:dept_alert_beta/logic/bloc/contact_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:dept_alert_beta/model/databaseClientTest.dart';
import 'package:dept_alert_beta/widgets/contacts_list.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewContactScreen extends StatefulWidget {
  final String title;
  final Contact? contactToUpdate;

  const NewContactScreen({Key? key, required this.title, this.contactToUpdate}) : super(key: key);

  @override
  State<NewContactScreen> createState() => _NewContactScreenState(contactToUpdate);
}

class _NewContactScreenState extends State<NewContactScreen> {
  final Contact? contactToUpdate;

  late TextEditingController firstnameTextEditingController;
  late TextEditingController lastnameTextEditingController;
  late TextEditingController emailAddressTextEditingController;
  late bool update = false;

  _NewContactScreenState(this.contactToUpdate);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstnameTextEditingController = TextEditingController();
    lastnameTextEditingController = TextEditingController();
    emailAddressTextEditingController = TextEditingController();
    update = contactToUpdate == null;
    print("contactToUpdate == null : $update");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
        body: Column(children: [
          getInputContent(),
          TextButton(
            child: const Text('Confirmer', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              addContact();
            },
          ),
          const ContactList(),
        ],
      ),
    );
  }

  /*Future<void> addContactDb() async {
    Contact contact = Contact(firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print('[IN] AddContact() : contact.id = ${contact.id}');
    await DatabaseClient.instance.insertContact(contact);
  }*/

  void addContact() async {
    Contact newContact = Contact(id: Contact.contactCpt, firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print('[addContactBloc] New contact : $newContact');

    BlocProvider.of<ContactListBloc>(context).add(ContactListContactAdded(contact: newContact));//TODO : change to ContactListContactAdding. in short, emit an adding event before added event
  }

  

  Card getInputContent() {//TODO create a "class extends StatelessWidget" with this
    Card card = Card(
        child: Column(
            children: [
              TextFormField(
                controller: firstnameTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Prénom: ',
                  hintText: 'Entrez votre prénom.',
                ),
              ),
              TextFormField(
                controller: lastnameTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Nom: ',
                  hintText: 'Entrez votre nom.',
                ),
              ),
              TextFormField(
                controller: emailAddressTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Email: ',
                  hintText: 'Entrez votre adresse email.',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ]
        )
    );

    if(contactToUpdate != null) fillInputFields(contactToUpdate!);

    return card;
  }
  
  void fillInputFields(Contact contactToUpdate) {
    firstnameTextEditingController.text = contactToUpdate.firstname;
    lastnameTextEditingController.text = contactToUpdate.lastname;
    emailAddressTextEditingController.text = contactToUpdate.emailAddress;
  }
    
  String getFirstname() => firstnameTextEditingController.text;

  String getLastname() => lastnameTextEditingController.text;

  String getEmailAddress() => emailAddressTextEditingController.text;
}