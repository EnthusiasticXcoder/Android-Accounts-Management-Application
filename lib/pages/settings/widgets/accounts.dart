import 'package:flutter/material.dart';

import 'package:my_app/pages/regester/view/regester_view.dart';
import 'package:my_app/pages/settings/view/profile.dart';
import 'package:my_app/utils/utils.dart';


class Account extends StatefulWidget {
  final Iterable<DatabaseUser> accounts;
  final DatabaseUser active;
  const Account({super.key, required this.accounts, required this.active});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final ExpansionTileController _controller;

  @override
  void initState() {
    _controller = ExpansionTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const ContinuousRectangleBorder(),
      controller: _controller,
      // Profile photo
      leading: Hero(
        tag: 'Active User',
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(
                activeuser: widget.active,
              ),
            ));
          },
          child: CircleAvatar(
              radius: 40,
              foregroundImage: (widget.active.imagePath == null)
                  ? null
                  : AssetImage(widget.active.imagePath!),
              child: const Icon(
                Icons.person,
                size: 40.0,
              )),
        ),
      ),
      // Title and subtitle
      title: Text(
        widget.active.name,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(widget.active.info),
      // Edit button
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(
              activeuser: widget.active,
            ),
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
          widget.accounts
              .where((user) => user.id != widget.active.id)
              .map(
                (user) => ListTile(
                  onTap: () async {
                    await changeActiveUser(user);
                    _controller.collapse();
                    setState(() {});
                  },
                  leading: CircleAvatar(
                      foregroundImage: (user.imagePath == null)
                          ? null
                          : AssetImage(user.imagePath!),
                      child: const Icon(Icons.person)),
                  title: Text(user.name),
                  subtitle: Text(user.info),
                ),
              )
              .followedBy(
        [
          // add acount
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegisterView(),
              ));
            },
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Add Another Account'),
          )
        ],
      ).toList(),
    );
  }
}
