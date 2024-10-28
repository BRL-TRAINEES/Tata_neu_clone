import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/flightsItemDetails.dart';

final flightItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Flight 101",
      "departure": "New York",
      "destination": "Los Angeles",
      "price": "\$250.00",
      "image": "assets/images/f1.png",
    },
    {
      "name": "Flight 202",
      "departure": "San Francisco",
      "destination": "Miami",
      "price": "\$300.00",
      "image": "assets/images/f2.png",
    },
    {
      "name": "Flight 303",
      "departure": "Chicago",
      "destination": "Houston",
      "price": "\$150.00",
      "image": "assets/images/f3.png",
    },
    {
      "name": "Flight 404",
      "departure": "Seattle",
      "destination": "Denver",
      "price": "\$220.00",
      "image": "assets/images/f4.png",
    },
    {
      "name": "Flight 505",
      "departure": "Boston",
      "destination": "Atlanta",
      "price": "\$180.00",
      "image": "assets/images/f5.png",
    },
    {
      "name": "Flight 606",
      "departure": "Washington D.C.",
      "destination": "Las Vegas",
      "price": "\$350.00",
      "image": "assets/images/f6.png",
    },
    {
      "name": "Flight 707",
      "departure": "Dallas",
      "destination": "Orlando",
      "price": "\$200.00",
      "image": "assets/images/f7.png",
    },
  ];
});

final flightSearchQueryProvider = StateProvider<String>((ref) => "");

class FlightScreen extends ConsumerWidget {
  const FlightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightItems = ref.watch(flightItemsProvider);
    final searchQuery = ref.watch(flightSearchQueryProvider);

    final filteredItems = flightItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Flight Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search flights...',
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
                ref.read(flightSearchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 203, 231, 239),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item["name"]!),
                      subtitle: Text(
                          "${item["departure"]} to ${item["destination"]} - ${item["price"]}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightItemDetail(
                              name: item["name"]!,
                              departure: item["departure"]!,
                              destination: item["destination"]!,
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
