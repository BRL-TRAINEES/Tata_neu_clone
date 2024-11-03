import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/provider.dart';
import 'package:tataneu_clone/screens/ApplianceScreen.dart';
import 'package:tataneu_clone/screens/EyewearScreen.dart';
import 'package:tataneu_clone/screens/FashionScreen.dart';
import 'package:tataneu_clone/screens/FootwearScreen.dart';
import 'package:tataneu_clone/screens/GroceryScreen.dart';
import 'package:tataneu_clone/screens/InsuranceScreen.dart';
import 'package:tataneu_clone/screens/MedicineScreen.dart';
import 'package:tataneu_clone/screens/cardscreen.dart';
import 'package:tataneu_clone/screens/flightsScreen.dart';
import 'package:tataneu_clone/screens/HotelScreen.dart';
import 'package:tataneu_clone/screens/MobileScreen.dart';
import 'package:tataneu_clone/screens/jwelleryScreen.dart';
import 'package:tataneu_clone/screens/watchesScreen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
                      } else if (item.name == 'Fashion') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FashionScreen()),
                        );
                      } else if (item.name == 'Cards') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CardScreen()),
                        );
                      } else if (item.name == 'Footwears') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FootwearScreen()),
                        );
                      } else if (item.name == 'Watches') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WatchesScreen()),
                        );
                      } else if (item.name == 'Jewellary') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JewelryScreen()),
                        );
                      } else if (item.name == 'Eye Wear') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EyewearScreen()),
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
                      } else if (item.name == 'Mobiles') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileScreen()),
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
