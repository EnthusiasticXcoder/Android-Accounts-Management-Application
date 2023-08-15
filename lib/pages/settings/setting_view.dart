import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/helpers/messagebox.dart';

import 'package:my_app/pages/routing/app_routs.dart';
import 'package:my_app/services/services.dart';

import 'widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    final width = MediaQuery.sizeOf(context).width;
    return MultiBlocListener(
      listeners: [
        BlocListener<NodeBloc, NodeState>(
          listener: (context, state) {
            if (state is NodeStateUserExist) {
              final message = state.message;
              if (message != null) {
                MessageBox.showMessage(context, message);
              }
            }
          },
        ),
        BlocListener<MainBloc, MainState>(
          listener: (context, state) {
            if (state is MainStateHomePage) {
              final message = state.message;
              if (message != null) {
                MessageBox.showMessage(context, message);
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color.fromARGB(210, 213, 240, 251),
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // margin
              SizedBox(height: height * 0.04),
              // Profile settings
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.03,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child:
                    // profile
                    BlocBuilder<NodeBloc, NodeState>(
                  buildWhen: (previous, current) =>
                      current is NodeStateUserExist,
                  builder: (context, state) {
                    if (state is NodeStateUserExist) {
                      return Account(
                        active: state.currentUser,
                        accounts: state.allUsers,
                        addAccount: () {
                          Navigator.of(context)
                              .pushNamed(AppRouts.registerpage);
                        },
                        showProfile: () {
                          Navigator.of(context).pushNamed(
                            AppRouts.profilepage,
                            arguments: state.currentUser,
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),

              // other settings
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.04,
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Import Button
                    TileButton(
                        icon: Icons.drive_file_move_outline,
                        title: 'Import Data',
                        subtitle: const Text('Import Data From Storage'),
                        onPress: () {
                          context.read<MainBloc>().add(MainEventImport(() {
                            context
                                .read<NodeBloc>()
                                .add(const NodeEventInitialise());
                          }));
                        }),

                    // share button
                    TileButton(
                      icon: Icons.share,
                      title: 'Share Data',
                      onPress: () {
                        context.read<MainBloc>().add(const MainEventShare());
                      },
                    ),
                  ],
                ),
              ),
              // catagory config
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child:
                    // catagory
                    BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state is MainStateHomePage) {
                      return CatagoryBuild(filters: state.allfilters);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
