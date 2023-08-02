import 'package:flutter/material.dart';
import 'package:my_app/pages/settings/view/profile.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final ExpansionTileController _controller;
  List accounts = [
    ['Anshul Verma', 'Personal'],
    ['Aayush pal', 'Family'],
    ['abu bakar', 'Professonal'],
    ['Ankit yadav', 'Friends']
  ];

  List active = ['Anshul Verma', 'Personal'];

  @override
  void initState() {
    _controller = ExpansionTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: _controller,
      // Profile photo
      leading: Hero(
        tag: 'Active User',
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ));
          },
          child: const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40.0,
              )),
        ),
      ),
      // Title and subtitle
      title: Text(
        active.elementAt(0),
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(active.elementAt(1)),
      // Edit button
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ));
        },
        icon: const Icon(
          Icons.edit_sharp,
          color: Colors.black87,
        ),
      ),
      // Available accounts
      children:
          // accounts
          accounts
              .where((item) => item.toString() != active.toString())
              .map(
                (item) => ListTile(
                  onTap: () {
                    active = item;
                    _controller.collapse();
                    setState(() {});
                  },
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(item[0]),
                  subtitle: Text(item[1]),
                ),
              )
              .followedBy(
        [
          // add acount
          const ListTile(
            leading: Icon(Icons.person_add_alt),
            title: Text('Add Another Account'),
          )
        ],
      ).toList(),
    );
  }
}
