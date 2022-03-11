import 'package:dept_alert_beta/events/contact_list_event.dart';
import 'package:dept_alert_beta/logic/bloc/contact_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:dept_alert_beta/model/databaseClientTest.dart';
import 'package:dept_alert_beta/widgets/contacts_list.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/contact_list_state.dart';

//TODO SEPARATE LIST FROM ADD/UPDATE SCREEN -> USE BOOLEAN 'isUpdate'
class UpdateContactScreen extends StatefulWidget {
  final String title;
  final Contact contactToUpdate;

  const UpdateContactScreen({Key? key, required this.title, required this.contactToUpdate}) : super(key: key);

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreen();
}

class _UpdateContactScreen extends State<UpdateContactScreen> {
  late TextEditingController firstnameTextEditingController;
  late TextEditingController lastnameTextEditingController;
  late TextEditingController emailAddressTextEditingController;

  _UpdateContactScreen();

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
    ListStatus listStatus = BlocProvider.of<ContactListBloc>(context).state.status;
    
    switch(listStatus) {
      case ListStatus.loading:
        return const CircularProgressIndicator();
      
      case ListStatus.loaded:
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Column(children: [
            getInputContent(),
            TextButton(
              child: const Text('Update', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                updateContact();
              },
            ),
            //const ContactList(),
          ],
        ),
      );

      default:
        throw Exception();
    }
  }

  /*Future<void> addContactDb() async {
    Contact contact = Contact(firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print('[IN] AddContact() : contact.id = ${contact.id}');
    await DatabaseClient.instance.insertContact(contact);
  }*/

  void updateContact() async {
    print("[BEFORE UPDATE]\n====\n${widget.contactToUpdate}\n===");
    Contact updatedContact = Contact(id: widget.contactToUpdate.id, firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print("[AFTER UPDATE]\n====\n${widget.contactToUpdate}\n===");
    BlocProvider.of<ContactListBloc>(context).add(ContactListContactUpdated(contact: updatedContact));

    Navigator.of(context).pop();
    //TODO : change to ContactListContactAdding. in short, emit an adding event before added event
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
    return card;
  }
  
  void fillInputFieldsWithContactData(Contact contactToUpdate) {
    firstnameTextEditingController.text = contactToUpdate.firstname;
    lastnameTextEditingController.text = contactToUpdate.lastname;
    emailAddressTextEditingController.text = contactToUpdate.emailAddress;
  }
    
  String getFirstname() => firstnameTextEditingController.text;

  String getLastname() => lastnameTextEditingController.text;

  String getEmailAddress() => emailAddressTextEditingController.text;
}