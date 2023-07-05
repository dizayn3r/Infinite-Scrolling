import 'package:flutter/material.dart';

class NoMoreProduct extends StatelessWidget {
  final bool show;
  const NoMoreProduct({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
            ]),
        child: const Center(
          child: Text(
            'You have fetched all of the content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
