import 'package:tataneu_clone/models/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemDataProvider = Provider<List<Item>>((ref) => [
      Item(name: 'Grocery', imagePath: 'assets/images/grocery.jpg'),
      Item(name: 'Medicine', imagePath: 'assets/images/medicines.jpg'),
      Item(name: 'Appliances', imagePath: 'assets/images/appliances.jpg'),
      Item(name: 'Flights', imagePath: 'assets/images/flight.webp'),
      Item(name: 'Hotels', imagePath: 'assets/images/hotel.jpeg'),
      Item(name: 'Insurances', imagePath: 'assets/images/insurance.jpeg'),
      Item(name: 'Mobiles', imagePath: 'assets/images/oneplus.png'),
      Item(name: 'Fashion', imagePath: 'assets/images/tshirt.png'),
      Item(name: 'Watches', imagePath: 'assets/images/watches.jpeg'),
      Item(name: 'Footwears', imagePath: 'assets/images/sandels.png'),
      Item(name: 'Jewellery', imagePath: 'assets/images/platinumPendant.png'),
      Item(name: 'Eyewear', imagePath: 'assets/images/sunglasses.png'),
      Item(name: 'Cards', imagePath: 'assets/images/visa.png'),
    ]);
