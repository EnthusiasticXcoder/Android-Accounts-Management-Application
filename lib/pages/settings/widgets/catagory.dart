import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';

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
            final name = await showTextPicker(context);

            if (name != null && name.isNotEmpty) {
              await createCatagory(name: name);
            }
            setState(() {});
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
                          await removeCatagory(filter.catagory.id)
                              .then((value) => setState(() {}));
                          setState(() {});
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
                          final name = await showTextPicker(context);

                          if (name != null && name.isNotEmpty) {
                            await createSubCatagory(
                                catagoryId: filter.catagory.id, name: name);
                          }
                          setState(() {});
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
                                onPressed: () async {
                                  await removeSubcatagory(
                                      catagoryId: filter.catagory.id,
                                      subCatagoryId: catagory.id);
                                  setState(() {});
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

  Future<String?> showTextPicker(BuildContext context) async {
    String? text;

    final controller = TextEditingController();
    await showDialog(
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Enter Catagory Name',
            style: TextStyle(fontSize: 18),
          ),
          contentPadding: const EdgeInsets.only(
              top: 50.0, left: 18.0, right: 18.0, bottom: 24.0),
          content: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              autofocus: true,
              controller: controller,
              validator: (value) => (value!.isEmpty) ? 'Required Field' : null,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  hintText: 'Catagory Name...',
                  border: OutlineInputBorder(
                      gapPadding: 0, borderRadius: BorderRadius.circular(12))),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    text = controller.text;
                    FocusScope.of(context).unfocus();
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Done'))
          ],
        );
      },
      context: context,
    );
    return text;
  }
}
