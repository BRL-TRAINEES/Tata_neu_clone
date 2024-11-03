import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/EyewearItemDetails.dart'; // Import the item details screen

final eyewearItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Sunglasses",
      "category": "Fashion",
      "price": "\$50.00",
      "image": "assets/images/sunglasses.png",
    },
    {
      "name": "Reading Glasses",
      "category": "Prescription",
      "price": "\$30.00",
      "image": "assets/images/readingGlass.png",
    },
    {
      "name": "Blue Light Glasses",
      "category": "Protective",
      "price": "\$45.00",
      "image": "assets/images/bluelight.png",
    },
    {
      "name": "Aviator Sunglasses",
      "category": "Fashion",
      "price": "\$70.00",
      "image": "assets/images/aviatorSunglass.png",
    },
    {
      "name": "Cat Eye Glasses",
      "category": "Fashion",
      "price": "\$60.00",
      "image": "assets/images/catEyeGlass.png",
    },
    {
      "name": "Round Glasses",
      "category": "Fashion",
      "price": "\$55.00",
      "image": "assets/images/roundGlass.png",
    },
    {
      "name": "Sports Goggles",
      "category": "Sport",
      "price": "\$40.00",
      "image": "assets/images/sportsGoggles.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class EyewearScreen extends ConsumerWidget {
  const EyewearScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eyewearItems = ref.watch(eyewearItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = eyewearItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Eyewear Store', style: TextStyle(color: Colors.black)),
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
                    color: const Color.fromARGB(255, 226, 222, 231),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EyewearItemDetail(
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
                            width: 130,
                            height: 130,
                            fit: BoxFit
                                .contain, // Ensures the entire image is visible
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item["name"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
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
