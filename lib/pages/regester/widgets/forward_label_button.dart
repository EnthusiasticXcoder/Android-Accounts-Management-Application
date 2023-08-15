import 'package:flutter/material.dart';

class ForwardLabelButton extends StatelessWidget {
  final VoidCallback onPress;
  const ForwardLabelButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      // lable button
      leading: const Text(
        'Confirm',
        style: TextStyle(
            color: Colors.black, fontSize: 27, fontWeight: FontWeight.w700),
      ),
      // button to conform
      trailing: IconButton(
          color: Colors.white,
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xff4c505b)),
              fixedSize: MaterialStatePropertyAll(Size.fromRadius(27))),
          onPressed: onPress,
          icon: const Icon(
            Icons.arrow_forward,
          )),
    );
  }
}
