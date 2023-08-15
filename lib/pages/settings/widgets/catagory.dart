import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/services.dart';

import '../view/text_picker.dart';

class CatagoryBuild extends StatefulWidget {
  final List<Filters> filters;
  const CatagoryBuild({super.key, required this.filters});

  @override
  State<CatagoryBuild> createState() => _CatagoryBuildState();
}

class _CatagoryBuildState extends State<CatagoryBuild> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        shape: const ContinuousRectangleBorder(),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.sort,
            size: 30,
          ),
        ),
        title: const Text(
          'Catagory',
          style: TextStyle(fontSize: 16),
        ),

        // button to add a catagory
        trailing: IconButton(
          onPressed: () async {
            // Creating a new catagory
            await showTextPicker(context).then((name) {
              if (name != null && name.isNotEmpty) {
                context.read<MainBloc>().add(MainEventCreateCatagory(name));
              }
            });
          },
          icon: const Icon(
            Icons.add_rounded,
            size: 30,
          ),
        ),

        // catagory list
        children: widget.filters
            .map(
              (filter) => Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ExpansionTile(
                  shape: const ContinuousRectangleBorder(),
                  leading: const Icon(Icons.list_alt),
                  title: Text(filter.catagory.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // button to remove a catagory
                      IconButton(
                        onPressed: () async {
                          int id = filter.catagory.id;
                          context
                              .read<MainBloc>()
                              .add(MainEventRemoveCatagory(id));
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline_rounded,
                          color: Colors.red,
                        ),
                      ),

                      // button to add a Sub catagory
                      IconButton(
                        onPressed: () async {
                          // Creating a new catagory
                          await showTextPicker(context).then((name) {
                            if (name != null && name.isNotEmpty) {
                              int id = filter.catagory.id;
                              context
                                  .read<MainBloc>()
                                  .add(MainEventCreateSubCatagory(id, name));
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 30, 109, 148),
                        ),
                      ),
                    ],
                  ),
                  children: filter.subcatagory
                      .map((catagory) => Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: ListTile(
                              leading: const Icon(
                                  Icons.keyboard_arrow_right_rounded),
                              title: Text(catagory.name),

                              // button to remove a catagory
                              trailing: IconButton(
                                onPressed: () {
                                  int id = filter.catagory.id;
                                  int subId = catagory.id;
                                  context.read<MainBloc>().add(
                                      MainEventRemoveSubCatagory(id, subId));
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            )
            .toList());
  }
}
