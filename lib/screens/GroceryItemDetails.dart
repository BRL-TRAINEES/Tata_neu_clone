import 'package:flutter/material.dart';

class GroceryItemDetail extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String image;

  const GroceryItemDetail({
    Key? key,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Category: $category', style: TextStyle(fontSize: 18)),
            Text('Price: $price', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
