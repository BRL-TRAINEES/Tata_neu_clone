import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/cardItemdetails.dart';

final cardItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "type": "Visa Card",
      "category": "Credit Card",
      "price": "\$52.00",
      "image": "assets/images/visa.png",
    },
    {
      "type": "MasterCard",
      "category": "Credit Card",
      "price": "\$43.50",
      "image": "assets/images/mastercard.png",
    },
    {
      "type": "Debit Card",
      "category": "Bank Card",
      "price": "\$34.00",
      "image": "assets/images/debitcard.png",
    },
    {
      "type": "American Express",
      "category": "Credit Card",
      "price": "\$46.02",
      "image": "assets/images/amex.png",
    },
    {
      "type": "Discover Card",
      "category": "Credit Card",
      "price": "\$32.10",
      "image": "assets/images/discover.png",
    },
    {
      "type": "JCB Card",
      "category": "Credit Card",
      "price": "\$50.00",
      "image": "assets/images/jcb.png",
    },
    {
      "type": "UnionPay",
      "category": "Credit Card",
      "price": "\$27.40",
      "image": "assets/images/unionpay.png",
    },
  ];
});

final cardSearchQueryProvider = StateProvider<String>((ref) => "");

class CardScreen extends ConsumerWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardItems = ref.watch(cardItemsProvider);
    final searchQuery = ref.watch(cardSearchQueryProvider);

    final filteredItems = cardItems
        .where((item) =>
            item["type"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Payment Cards', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search cards...',
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
                ref.read(cardSearchQueryProvider.notifier).state = query;
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
                    color: const Color.fromARGB(255, 244, 245, 244),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardItemDetail(
                              type: item["type"]!,
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
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item["type"]!,
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
