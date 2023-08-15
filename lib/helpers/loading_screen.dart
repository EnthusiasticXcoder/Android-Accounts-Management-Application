import 'package:flutter/material.dart';

class LoadingScreen {
  LoadingScreen.showLoadingScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.sizeOf(context);
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: size.height * 0.15,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Loading, Please Wait!'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
