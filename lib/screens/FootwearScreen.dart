import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/FootwearItemDetail.dart'; // Import the item details screen

final footwearItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Sneakers",
      "category": "Footwear",
      "price": "\$60.00",
      "image": "assets/images/sneakers.png",
    },
    {
      "name": "Sandals",
      "category": "Footwear",
      "price": "\$25.00",
      "image": "assets/images/sandels.png",
    },
    {
      "name": "Boots",
      "category": "Footwear",
      "price": "\$80.00",
      "image": "assets/images/boots.png",
    },
    {
      "name": "Loafers",
      "category": "Footwear",
      "price": "\$45.00",
      "image": "assets/images/loafers.png",
    },
    {
      "name": "",
      "category": "Footwear",
      "price": "\$15.00",
      "image": "assets/images/flipflops.png",
    },
    {
      "name": "Heels",
      "category": "Footwear",
      "price": "\$70.00",
      "image": "assets/images/heels.png",
    },
    {
      "name": "Brogues",
      "category": "Footwear",
      "price": "\$55.00",
      "image": "assets/images/broques.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class FootwearScreen extends ConsumerWidget {
  const FootwearScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final footwearItems = ref.watch(footwearItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = footwearItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Footwear Store', style: TextStyle(color: Colors.black)),
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7, // Aspect ratio for the grid items
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 223, 225, 223),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FootwearItemDetail(
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
