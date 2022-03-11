import 'package:dept_alert_beta/logic/bloc/contact_list_bloc.dart';
import 'package:dept_alert_beta/logic/bloc/contact_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dept_alert_beta/events/contact_list_event.dart';
import 'package:dept_alert_beta/model/contact.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SingleChildScrollView(
      padding : const EdgeInsets.all(14),
      clipBehavior: Clip.hardEdge,
      child: BlocConsumer<ContactListBloc, ContactListState>(
      builder: (context, state) {//state is a List<Contact> 
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(14),
          itemCount: state.contacts.length,
          itemBuilder: (context, index) {
            return Card (
              child: ListTile(
                  title: Text('${state.contacts[index].firstname} ${state.contacts[index].lastname}'),
                  subtitle: Text('${state.contacts[index].emailAddress} (${state.contacts[index].id}'),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pushNamed(context, '/update', arguments: state.contacts[index]),
                        //() => Navigator.of(context).pushNamed('/update', arguments: state.contacts[index]),
                        //context.read<ContactListBloc>().add(ContactListContactUpdating(contact: state.contacts[index])),
                        icon: const Icon(Icons.update),
                      ),
                      IconButton(
                        onPressed: () => context.read<ContactListBloc>().add(ContactListContactDeleted(contactId: state.contacts[index].id)),
                        icon: const Icon(Icons.cancel),
                      ),
                    ],
                  )
                ),
            );
          },
        );
      },
      listener: (context, state) { 
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Action performed !"),
          duration: Duration(milliseconds: 450),
          ));
        }
      )
    );
  }
}