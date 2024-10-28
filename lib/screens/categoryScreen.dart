import 'package:flutter/material.dart';

class categoryScreen extends StatelessWidget {
  final String itemName;

  const categoryScreen({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$itemName Screen'),
      ),
      body: Center(
        child: Text('Welcome to the $itemName screen!'),
      ),
    );
  }
}
