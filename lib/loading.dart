import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final bool showLoader;
  const CustomLoader({super.key, required this.showLoader});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showLoader,
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
