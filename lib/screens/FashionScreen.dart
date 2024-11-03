import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/FashionItemDetail.dart'; // Import the item details screen

final fashionItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "T-Shirt",
      "category": "Clothing",
      "price": "\$10.00",
      "image": "assets/images/tshirt.png",
    },
    {
      "name": "Jeans",
      "category": "Clothing",
      "price": "\$30.00",
      "image": "assets/images/jeans.png",
    },
    {
      "name": "Dress",
      "category": "Clothing",
      "price": "\$25.00",
      "image": "assets/images/dress.png",
    },
    {
      "name": "Jacket",
      "category": "Outerwear",
      "price": "\$50.00",
      "image": "assets/images/jacket.png",
    },
    {
      "name": "Shorts",
      "category": "Clothing",
      "price": "\$40.00",
      "image": "assets/images/shorts.png",
    },
    {
      "name": "Tops",
      "category": "Clothing",
      "price": "\$45.00",
      "image": "assets/images/tops.png",
    },
    {
      "name": "Shirts",
      "category": "Clothing",
      "price": "\$30.00",
      "image": "assets/images/shirts.png",
    },
    {
      "name": "Socks",
      "category": "Clothing",
      "price": "\$5.00",
      "image": "assets/images/socks.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class FashionScreen extends ConsumerWidget {
  const FashionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fashionItems = ref.watch(fashionItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = fashionItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Fashion Store', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search items...',
                filled: true,
                fillColor: const Color.fromARGB(255, 231, 229, 229),
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 223, 224, 223),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FashionItemDetail(
                              name: item["name"]!,
                              category: item["category"]!,
                              price: item["price"]!,
                              image: item["image"]!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            item["image"]!,
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(item["name"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("${item["category"]} - ${item["price"]}"),
                        ],
                      ),
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
