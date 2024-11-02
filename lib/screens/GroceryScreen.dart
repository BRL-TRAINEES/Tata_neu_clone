import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/GroceryItemDetails.dart';

final groceryItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Apple",
      "category": "Fruit",
      "price": "\$1.00",
      "image": "assets/images/apple.png",
    },
    {
      "name": "Banana",
      "category": "Fruit",
      "price": "\$0.50",
      "image": "assets/images/banana.png",
    },
    {
      "name": "Carrot",
      "category": "Vegetable",
      "price": "\$0.30",
      "image": "assets/images/carrot.png",
    },
    {
      "name": "Bread",
      "category": "Bakery",
      "price": "\$2.50",
      "image": "assets/images/bread.png",
    },
    {
      "name": "Milk",
      "category": "Dairy",
      "price": "\$1.20",
      "image": "assets/images/milk.png",
    },
    {
      "name": "Eggs",
      "category": "Dairy",
      "price": "\$2.00",
      "image": "assets/images/eggs.png",
    },
    {
      "name": "Tomato",
      "category": "Vegetable",
      "price": "\$0.40",
      "image": "assets/images/tomato.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class GroceryScreen extends ConsumerWidget {
  const GroceryScreen({super.key});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.watch(groceryItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = groceryItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Grocery Store'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search items...',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 219, 230, 219),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item["name"]!),
                      subtitle: Text("${item["category"]} - ${item["price"]}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroceryItemDetail(
                              name: item["name"]!,
                              category: item["category"]!,
                              price: item["price"]!,
                              image: item["image"]!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
