import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/provider.dart';
import 'package:tataneu_clone/ItemsLists/item_data.dart';
import 'package:tataneu_clone/models/item_model.dart';
import 'package:tataneu_clone/screens/ApplianceScreen.dart';
import 'package:tataneu_clone/screens/GroceryScreen.dart';
import 'package:tataneu_clone/screens/InsuranceScreen.dart';
import 'package:tataneu_clone/screens/MedicineScreen.dart';
import 'package:tataneu_clone/screens/flightsScreen.dart';
import 'package:tataneu_clone/screens/HotelScreen.dart';

class SearchScreen extends ConsumerWidget {

  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = ref.watch(filteredItemsProvider);
    final searchTextController = ref.read(searchTextProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Search Tata Neu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                onChanged: (value) {
                  searchTextController.state = value;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Category of an item',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                ),
              ),
            ),
          ),
          const Text(
            'What do you want today?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(item.imagePath),
                      backgroundColor: Colors.grey[300],
                    ),
                    title: Text(item.name),
                    onTap: () {
                      if (item.name == 'Grocery') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroceryScreen()),
                        );
                      } else if (item.name == 'Medicine') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicineScreen()),
                        );
                      } else if (item.name == 'Appliances') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplianceScreen()),
                        );
                      } else if (item.name == 'Flights') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightScreen()),
                        );
                      } else if (item.name == 'Hotels') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HotelScreen()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InsuranceScreen()),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
