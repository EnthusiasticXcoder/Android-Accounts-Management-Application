import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/helpers/loading_screen.dart';
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
    return BlocConsumer<NodeBloc, NodeState>(
      listenWhen: (previous, current) => current is NodeLoadingState,
      listener: (context, state) {
        if (state is NodeLoadingState) {
          if (state.isLoading == true) {
            LoadingScreen.showLoadingScreen(context);
          } else {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) navigator.pop();
          }
        }
      },
      buildWhen: (previous, current) =>
          //!(previous is NodeStateUserExist && current is NodeStateUserExist) ||
          current is! NodeLoadingState,
      builder: (context, state) {
        if (state is NodeStateCreateUser) {
          return const RegisterView();
        } else if (state is NodeStateUserExist) {
          return const MainView();
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
