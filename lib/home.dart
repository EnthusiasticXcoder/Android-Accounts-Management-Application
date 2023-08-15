import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/bloc/node/node_event.dart';

import 'pages/main/main_view.dart';
import 'pages/regester/view/regester_view.dart';
import 'services/bloc/node/node_bloc.dart';
import 'services/bloc/node/node_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NodeBloc>().add(const NodeEventInitialise());
    return BlocBuilder<NodeBloc, NodeState>(
      buildWhen: (previous, current) =>
          !(previous is NodeStateUserExist && current is NodeStateUserExist),
      builder: (context, state) {
        if (state is NodeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NodeStateCreateUser) {
          return const RegisterView();
        } else if (state is NodeStateUserExist) {
          return const MainView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
