import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/HotelItemDetails.dart';



final hotelItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Grand Hotel",
      "location": "New York City",
      "price": "\$200.00",
      "image": "assets/images/hotel1.png",
    },
    {
      "name": "Sunset Resort",
      "location": "Miami",
      "price": "\$180.00",
      "image": "assets/images/hotel2.png",
    },
    {
      "name": "Mountain Lodge",
      "location": "Denver",
      "price": "\$220.00",
      "image": "assets/images/hotel3.png",
    },
    {
      "name": "Beachside Inn",
      "location": "California",
      "price": "\$150.00",
      "image": "assets/images/hotel4.png",
    },
    {
      "name": "City Center Hotel",
      "location": "Chicago",
      "price": "\$250.00",
      "image": "assets/images/hotel5.png",
    },
    {
      "name": "Desert Oasis",
      "location": "Las Vegas",
      "price": "\$300.00",
      "image": "assets/images/hotel6.png",
    },
    {
      "name": "Cozy Cottage",
      "location": "Aspen",
      "price": "\$280.00",
      "image": "assets/images/hotel7.png",
    },
  ];
});

final hotelSearchQueryProvider = StateProvider<String>((ref) => "");

class HotelScreen extends ConsumerWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotelItems = ref.watch(hotelItemsProvider);
    final searchQuery = ref.watch(hotelSearchQueryProvider);

    final filteredItems = hotelItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Hotel Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search hotels...',
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
                ref.read(hotelSearchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 243, 244, 225),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item["name"]!),
                      subtitle: Text("${item["location"]} - ${item["price"]}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelItemDetail(
                              name: item["name"]!,
                              location: item["location"]!,
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
