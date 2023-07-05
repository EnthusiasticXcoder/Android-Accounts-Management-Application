import 'package:flutter/material.dart';
import 'package:my_app/services/get_shared_value.dart';
import 'package:my_app/utilities/generics/get_argument.dart';

class Headwidget extends StatefulWidget {
  const Headwidget({super.key});

  @override
  State<Headwidget> createState() => _HeadwidgetState();
}

class _HeadwidgetState extends State<Headwidget>
    with SingleTickerProviderStateMixin {
  int toggle = 0;
  late AnimationController _con;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Name Widget
          FutureBuilder(
            future: GetSharedValue().setinstance(),
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Hi, ${GetSharedValue().userName}!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Settings widget
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 1,
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  duration: const Duration(milliseconds: 375),
                  height: 48.0,
                  width: (toggle == 0) ? 48.0 : (context.width - 41),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: -10.0,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 375),
                        left: (toggle == 0) ? 20.0 : 40.0,
                        curve: Curves.easeOut,
                        top: 11.0,
                        child: AnimatedOpacity(
                          opacity: (toggle == 0) ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            height: 23.0,
                            width: context.height,
                            child: TextField(
                              controller: _textEditingController,
                              cursorRadius: const Radius.circular(10.0),
                              cursorWidth: 2.0,
                              cursorColor: Colors.black,
                              enableSuggestions: false,
                              onEditingComplete: () {
                                final value = _textEditingController.text;
                                GetSharedValue()
                                    .setvalue(value: value.toString());
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  if (toggle == 0) {
                                    toggle = 1;
                                    _con.forward();
                                  } else {
                                    toggle = 0;
                                    _textEditingController.clear();
                                    _con.reverse();
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: 'Enter Name...',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                        ),
                        child: IconButton(
                          splashRadius: 19.0,
                          color: Colors.white,
                          icon: Icon(
                            (toggle == 0)
                                ? Icons.settings
                                : Icons.arrow_forward_ios_rounded,
                            size: 25,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (toggle == 0) {
                                  toggle = 1;
                                  _con.forward();
                                } else {
                                  toggle = 0;
                                  _textEditingController.clear();
                                  _con.reverse();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
