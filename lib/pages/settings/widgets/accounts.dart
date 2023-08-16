import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/services.dart';

class Account extends StatefulWidget {
  final Iterable<DatabaseUser> accounts;
  final DatabaseUser active;
  final VoidCallback showProfile;
  final VoidCallback addAccount;

  const Account({
    super.key,
    required this.accounts,
    required this.active,
    required this.showProfile,
    required this.addAccount,
  });

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final ExpansionTileController _controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const ContinuousRectangleBorder(),
      controller: _controller,
      // Profile photo
      leading: Hero(
        tag: 'Active User',
        child: GestureDetector(
          onTap: widget.showProfile,
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
        widget.active.name,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(widget.active.info),
      // Edit button
      trailing: IconButton(
        onPressed: widget.showProfile,
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
                  onTap: () {
                    context.read<NodeBloc>().add(
                          NodeEventChangeActiveUser(user),
                        );
                    context.read<MainBloc>().add(
                          const MainEventHideDialog(),
                        );
                    _controller.collapse();
                  },
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.name),
                  subtitle: Text(user.info),
                ),
              )
              .followedBy(
        [
          // add acount
          ListTile(
            onTap: widget.addAccount,
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Add Another Account'),
          )
        ],
      ).toList(),
    );
  }
}
