import 'package:dept_alert_beta/events/contact_event.dart';
import 'package:dept_alert_beta/logic/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:dept_alert_beta/model/databaseClientTest.dart';
import 'package:dept_alert_beta/widgets/contacts_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewContactScreen extends StatefulWidget {
  final String title;

  const NewContactScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  late TextEditingController firstnameTextEditingController;
  late TextEditingController lastnameTextEditingController;
  late TextEditingController emailAddressTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstnameTextEditingController = TextEditingController();
    lastnameTextEditingController = TextEditingController();
    emailAddressTextEditingController = TextEditingController();
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
              addContactBloc();
            },
          ),

          const ContactList(),
        ],
      ),
    );
  }

  Future<void> addContact() async {
    Contact contact = Contact(firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print('[IN] AddContact() : contact.id = ${contact.id}');
    await DatabaseClient.instance.insertContact(contact);
  }
  void addContactBloc() async {
    Contact newContact = Contact(firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print('[addContactBloc] New contact : $newContact');

    BlocProvider.of<ContactBloc>(context).add(AddContactEvent(contact: newContact));
  }
  Card getInputContent() {//TODO create a "class extends StatelessWidget" with this
    return Card(
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
  }

  String getFirstname() => firstnameTextEditingController.text;

  String getLastname() => lastnameTextEditingController.text;

  String getEmailAddress() => emailAddressTextEditingController.text;
}