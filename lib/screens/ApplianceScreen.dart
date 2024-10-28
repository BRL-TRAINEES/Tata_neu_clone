import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your appliance provider
import 'package:tataneu_clone/screens/ApplianceItemDetails.dart'; // Import the details page

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Appliance items provider
final applianceItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Refrigerator",
      "category": "Kitchen Appliance",
      "price": "\$600.00",
      "image": "assets/images/refrigerator.png",
    },
    {
      "name": "Washing Machine",
      "category": "Laundry Appliance",
      "price": "\$400.00",
      "image": "assets/images/washingmachine.png",
    },
    {
      "name": "Microwave Oven",
      "category": "Kitchen Appliance",
      "price": "\$100.00",
      "image": "assets/images/microwave.png",
    },
    {
      "name": "Air Conditioner",
      "category": "Cooling Appliance",
      "price": "\$800.00",
      "image": "assets/images/airconditioner.png",
    },
    {
      "name": "Electric Kettle",
      "category": "Kitchen Appliance",
      "price": "\$30.00",
      "image": "assets/images/electrickettle.png",
    },
    {
      "name": "Dishwasher",
      "category": "Kitchen Appliance",
      "price": "\$500.00",
      "image": "assets/images/dishwasher.png",
    },
    {
      "name": "Blender",
      "category": "Kitchen Appliance",
      "price": "\$50.00",
      "image": "assets/images/blender.png",
    },
  ];
});

// Search query provider for appliances
final applianceSearchQueryProvider = StateProvider<String>((ref) => "");

class ApplianceScreen extends ConsumerWidget {
  const ApplianceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applianceItems = ref.watch(applianceItemsProvider);
    final searchQuery = ref.watch(applianceSearchQueryProvider);

    // Filter items based on the search query
    final filteredItems = applianceItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Appliance Store'),
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
                // Update the search query in the provider
                ref.read(applianceSearchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 215, 216, 215),
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
                        // Navigate to the details page on tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplianceItemDetail(
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
