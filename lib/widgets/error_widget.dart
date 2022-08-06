import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String? errorText;
  const ErrorWidget({Key? key,  this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: errorText != null && errorText!.isNotEmpty,
        child: Text(errorText!, style: const TextStyle(color: Colors.red, fontSize: 18.0),));
  }
}
