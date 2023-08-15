import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/pages/routing/app_routs.dart';
import 'package:my_app/services/services.dart';

class ShouldDelete {
  ShouldDelete.showDialog(BuildContext context, DatabaseUser activeuser) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete User',
          style: TextStyle(
            fontSize: 18,
            color: Colors.redAccent,
          ),
        ),
        content: const Text('Are You Sure Want To Delete Account?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancle'),
          ),
          TextButton(
            onPressed: () {
              // Deleting Current Active User
              final userId = activeuser.id;
              context.read<NodeBloc>().add(NodeEventDeleteUser(userId));
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.homepage,
                (route) => route.settings.name == AppRouts.homepage,
              );
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
