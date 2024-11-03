import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/WatchItemdetails.dart'; // Import the item details screen

final watchesItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Classic Leather Watch",
      "category": "Wrist Watch",
      "price": "\$120.00",
      "image": "assets/images/leatherwatch.png",
    },
    {
      "name": "steel",
      "category": "Wrist Watch",
      "price": "\$180.00",
      "image": "assets/images/steelwatch.png",
    },
    {
      "name": "Ceramic Watch",
      "category": "Wrist Watch",
      "price": "\$220.00",
      "image": "assets/images/ceramicwatch.png",
    },
    {
      "name": "Smart Fitness Watch",
      "category": "Wrist Watch",
      "price": "\$250.00",
      "image": "assets/images/fitnesswatch.png",
    },
    {
      "name": "Fashion Wrist Watch",
      "category": "Wrist Watch",
      "price": "\$70.00",
      "image": "assets/images/fashionwatch.png",
    },
    {
      "name": "Luxury Diamond Watch",
      "category": "Wrist Watch",
      "price": "\$1000.00",
      "image": "assets/images/diamondwatch.png",
    },
    {
      "name": "Diving Watch",
      "category": "Wrist Watch",
      "price": "\$300.00",
      "image": "assets/images/divingwatch.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class WatchesScreen extends ConsumerWidget {
  const WatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchesItems = ref.watch(watchesItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = watchesItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Wrist Watches Store',
            style: TextStyle(color: Colors.black)),
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
                    color: const Color.fromARGB(255, 239, 241, 230),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WatchesItemDetail(
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
