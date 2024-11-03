import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/jewelryItemDetails.dart'; // Import the item details screen

final jewelryItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Diamond Ring",
      "category": "Ring",
      "price": "\$500.00",
      "image": "assets/images/diamondRing.png",
    },
    {
      "name": "Gold Necklace",
      "category": "Necklace",
      "price": "\$300.00",
      "image": "assets/images/goldNecklace.png",
    },
    {
      "name": "Silver Bracelet",
      "category": "Bracelet",
      "price": "\$150.00",
      "image": "assets/images/silverBracelet.png",
    },
    {
      "name": "Pearl Earrings",
      "category": "Earrings",
      "price": "\$80.00",
      "image": "assets/images/PearlEarrings.png",
    },
    {
      "name": "silver Earing",
      "category": "Watch",
      "price": "\$200.00",
      "image": "assets/images/silverEaring.png",
    },
    {
      "name": "Platinum Pendant",
      "category": "Pendant",
      "price": "\$700.00",
      "image": "assets/images/platinumPendant.png",
    },
    {
      "name": "Gold Cufflinks",
      "category": "Cufflinks",
      "price": "\$250.00",
      "image": "assets/images/goldCuffinks.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class JewelryScreen extends ConsumerWidget {
  const JewelryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jewelryItems = ref.watch(jewelryItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = jewelryItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Jewelry Store', style: TextStyle(color: Colors.black)),
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
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 234, 226, 214),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JewelryItemDetail(
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
