import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/MobileItemdetails.dart';

final mobileItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "model": "iPhone 14 Pro",
      "brand": "Apple",
      "price": "\$999.00",
      "image": "assets/images/iphone14.png",
    },
    {
      "model": "Galaxy S22 Ultra",
      "brand": "Samsung",
      "price": "\$1199.00",
      "image": "assets/images/samsungS22.png",
    },
    {
      "model": "Pixel 7 Pro",
      "brand": "Google",
      "price": "\$899.00",
      "image": "assets/images/pixel7.png",
    },
    {
      "model": "OnePlus 11",
      "brand": "OnePlus",
      "price": "\$699.00",
      "image": "assets/images/oneplus.png",
    },
    {
      "model": "Xperia 1 IV",
      "brand": "Sony",
      "price": "\$1299.00",
      "image": "assets/images/xperia.png",
    },
    {
      "model": "Xiaomi 12 Pro",
      "brand": "Xiaomi",
      "price": "\$799.00",
      "image": "assets/images/xiaomi.png",
    },
    {
      "model": "Moto Edge Plus",
      "brand": "Motorola",
      "price": "\$799.00",
      "image": "assets/images/moto.png",
    },
  ];
});

final mobileSearchQueryProvider = StateProvider<String>((ref) => "");

class MobileScreen extends ConsumerWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mobileItems = ref.watch(mobileItemsProvider);
    final searchQuery = ref.watch(mobileSearchQueryProvider);

    // Filter mobile items based on the search query
    final filteredItems = mobileItems
        .where((item) =>
            item["model"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Mobile Store', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search text field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search mobile...',
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
                ref.read(mobileSearchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 229, 231, 233),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MobileItemDetail(
                              model: item["model"]!,
                              brand: item["brand"]!,
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
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(item["model"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(item["brand"]!),
                          Text(item["price"]!),
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
