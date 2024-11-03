import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/InsuranceItemDetail.dart';

final insuranceItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Health Insurance",
      "company": "HealthCare Inc.",
      "premium": "\$300.00",
      "image": "assets/images/ins1.png",
    },
    {
      "name": "Car Insurance",
      "company": "AutoProtect",
      "premium": "\$120.00",
      "image": "assets/images/ins2.png",
    },
    {
      "name": "Home Insurance",
      "company": "SecureHome",
      "premium": "\$250.00",
      "image": "assets/images/ins3.png",
    },
    {
      "name": "Travel Insurance",
      "company": "TravelSafe",
      "premium": "\$75.00",
      "image": "assets/images/ins4.png",
    },
    {
      "name": "Life Insurance",
      "company": "LifeGuard",
      "premium": "\$400.00",
      "image": "assets/images/ins5.png",
    },
    {
      "name": "Business Insurance",
      "company": "BizSecure",
      "premium": "\$500.00",
      "image": "assets/images/ins6.png",
    },
    {
      "name": "Pet Insurance",
      "company": "PawProtect",
      "premium": "\$60.00",
      "image": "assets/images/ins7.png",
    },
  ];
});

final insuranceSearchQueryProvider = StateProvider<String>((ref) => "");

class InsuranceScreen extends ConsumerWidget {

  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insuranceItems = ref.watch(insuranceItemsProvider);
    final searchQuery = ref.watch(insuranceSearchQueryProvider);

    final filteredItems = insuranceItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Insurance Options',
            style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search insurances...',
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
                ref.read(insuranceSearchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7, // Adjust aspect ratio as needed
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 242, 235, 247),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InsuranceItemDetail(
                              name: item["name"]!,
                              company: item["company"]!,
                              premium: item["premium"]!,
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
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(item["name"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            "${item["company"]} - ${item["premium"]}",
                            textAlign: TextAlign.center,
                          ),
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
