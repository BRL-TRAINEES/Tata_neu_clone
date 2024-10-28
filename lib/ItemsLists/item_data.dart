// item_data.dart
import 'package:tataneu_clone/models/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemDataProvider = Provider<List<Item>>((ref) => [
      Item(name: 'Grocery', imagePath: 'assets/images/grocery.jpg'),
      Item(name: 'Medicine', imagePath: 'assets/images/medicines.jpg'),
      Item(name: 'Appliances', imagePath: 'assets/images/appliances.jpg'),
      Item(name: 'Flights', imagePath: 'assets/images/flight.webp'),
      Item(name: 'Hotels', imagePath: 'assets/images/hotel.jpeg'),
      Item(name: 'Insurances', imagePath: 'assets/images/insurance.jpeg'),
    ]);
