import 'package:flutter/material.dart';

class PageBox extends StatelessWidget {
  final Widget child;
  const PageBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(150, 3, 126, 214),
                Color.fromARGB(19, 7, 115, 255),
                Color.fromARGB(150, 3, 78, 208),
              ],
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: -1.0,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: child,
        ),

        // Lower Margin
        const SizedBox(height: 300),
      ],
    );
  }
}
