import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FittedBox(
        child: Text('An error occurred, please try reloading'),
      ),
    );
  }
}
