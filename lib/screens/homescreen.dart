import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tataneu_clone/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tataneu_clone/SearchScreens/search_screen.dart';
import 'package:tataneu_clone/screens/EyewearScreen.dart';
import 'package:tataneu_clone/screens/FashionScreen.dart';
import 'package:tataneu_clone/screens/FootwearScreen.dart';
import 'package:tataneu_clone/screens/GroceryScreen.dart';
import 'package:tataneu_clone/screens/HotelScreen.dart';
import 'package:tataneu_clone/screens/InsuranceScreen.dart';
import 'package:tataneu_clone/screens/MedicineScreen.dart';
import 'package:tataneu_clone/screens/MobileScreen.dart';
import 'package:tataneu_clone/screens/Profile.dart';
import 'package:tataneu_clone/screens/bottom%20navigation%20bar%20screens/Neupass.dart';
import 'package:tataneu_clone/screens/bottom%20navigation%20bar%20screens/categories.dart';
import 'package:tataneu_clone/screens/bottom%20navigation%20bar%20screens/offers.dart';
import 'package:tataneu_clone/screens/cardscreen.dart';
import 'package:tataneu_clone/screens/flightsScreen.dart';
import 'package:tataneu_clone/screens/ApplianceScreen.dart';
import 'package:tataneu_clone/screens/jwelleryScreen.dart';
import 'package:tataneu_clone/screens/watchesScreen.dart';
import 'package:tataneu_clone/screens/chat_screen.dart';
import 'package:geocoding/geocoding.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  Future<Map<String, dynamic>> _getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled.')),
      );
      return {};
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return {};
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return {};
    }

    // Retrieve current location
    Position position = await Geolocator.getCurrentPosition();

    try {
      // Use geocoding to get the place name and pincode from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String locationName = place.locality ?? 'Unknown';
        String pincode = place.postalCode ?? 'No pincode available';

        return {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'locationName': locationName,
          'pincode': pincode,
        };
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to retrieve address: $e')),
      );
    }

    return {};
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    // final List<Widget> screens = [
    //   Homescreen(),
    //   Neupass(),
    //   Categories(),
    //   OfferScreen(),
    //   ProfilePage(),
    // ];

    final List<String> imagePaths = [
      "assets/images/moving1.jpg",
      "assets/images/moving2.jpg",
      "assets/images/moving3.jpg",
      "assets/images/moving4.jpg",
      "assets/images/moving5.jpg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 250, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserAccountScreen()),
                      );
                    },
                    child: SvgPicture.asset("assets/svg/account.svg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: GestureDetector(
                    child: Image.asset(
                      "assets/images/finance.jpg",
                      width: 100,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CardScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Search bar container
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.all(10),
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Search Tata Neu',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),

          
         const SizedBox(height: 5),
FutureBuilder<Map<String, dynamic>>(
  future: _getCurrentLocation(context),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError || (snapshot.data?.isEmpty ?? true)) {
      return ElevatedButton(
        onPressed: () => _getCurrentLocation(context),
        child: const Text('Retry Getting Location'),
      );
    } else {
      final data = snapshot.data!;
      return Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue), 
              const SizedBox(width: 5), 
              Text(
                '${data['locationName']}: ',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                data['pincode'],
                style: TextStyle(color: const Color.fromARGB(255, 12, 123, 213)),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      );
    }
  },
),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: imagePaths.length,
                controller: PageController(
                  initialPage: navigationState.pageIndex,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePaths[(navigationState.pageIndex + index) %
                            imagePaths.length],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/qr.jpeg",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("QR Code"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/gift card.jpeg",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("Gift Card"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/bill.webp",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("Bill"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/loan.png",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("Loan"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/insurance.jpeg",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("Insurance"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Left Container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Daily",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/grocery.jpg",
                                      height: 60,
                                      width: 60,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GroceryScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 2),
                                  const Text("Grocery"),
                                ],
                              ),
                              const SizedBox(width: 20), //
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/medicines.jpg",
                                      height: 60,
                                      width: 60,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MedicineScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 2),
                                  const Text("Medicine"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Right Container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Electronics",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/mobile.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MobileScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Mobile"),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/appliances.jpg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ApplianceScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Appliances"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Left Container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Finance",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/insurance.jpeg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InsuranceScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Insurance"),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/card.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CardScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Card"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Right Container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Travel",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/hotel.jpeg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HotelScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Hotels"),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/images/flight.webp",
                                      height: 50,
                                      width: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FlightScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  const Text("Flights"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Fashion & Lifestyle",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(children: [
                            GestureDetector(
                              child: Image.asset(
                                "assets/images/fashion.jpeg",
                                height: 50,
                                width: 50,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FashionScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            Text('Fashion'),
                          ]),
                          SizedBox(width: 20),
                          Column(children: [
                            GestureDetector(
                              child: Image.asset(
                                "assets/images/footwear.jpeg",
                                height: 50,
                                width: 50,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FootwearScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            Text('Footwear'),
                          ]),
                          SizedBox(width: 20),
                          Column(children: [
                            GestureDetector(
                              child: Image.asset(
                                "assets/images/watches.jpeg",
                                height: 50,
                                width: 50,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WatchesScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            Text('Watches'),
                          ]),
                          SizedBox(width: 20),
                          Column(children: [
                            GestureDetector(
                              child: Image.asset(
                                "assets/images/jewellery.png",
                                height: 50,
                                width: 50,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JewelryScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            Text('Jewellery'),
                          ]),
                          SizedBox(width: 20),
                          Column(children: [
                            GestureDetector(
                              child: Image.asset(
                                "assets/images/eyewear.jpeg",
                                height: 50,
                                width: 50,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EyewearScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            Text('Eyewear')
                          ]),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 2,
          ),
          SizedBox(height: 30),

          Text('Unbeaten deals & discounts'),
          Text(
            'In spotlight',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset("assets/images/spotlight image 1.png")),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/spotlight image 0.png.jpg",
                            width: 200,
                          ),
                          Image.asset("assets/images/spotlight image 2.png.jpg",
                              width: 200),
                          Image.asset("assets/images/spotlight image 3.png.jpg",
                              width: 200),
                          Image.asset("assets/images/spotlight image 4.png.jpg",
                              width: 200),
                          Image.asset("assets/images/spotlight image 5.png.jpg",
                              width: 200),
                          Image.asset("assets/images/spotlight image 6.jpg",
                              width: 200),
                        ],
                      )))),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text('Brands you will love'),
          Text(
            'Featured brands',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        Image.asset(
                          "assets/images/featured brands 1.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/featured brands 2.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/featured brands 3.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/featured brands 4.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/featured brands 5.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/featured brands 6.jpg",
                          width: 200,
                        ),
                      ])))),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text('Choose the best luxury brands'),
          Text(
            'Neu premium corner',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/premium corner0.jpg",
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        Image.asset(
                          "assets/images/premium corner1.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/premium corner2.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/premium corner3.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/premium corner4.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/premium corner5.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/premium corner6.jpg",
                          width: 200,
                        ),
                      ])))),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Text('Explore further for our hidden gems'),
          Text(
            'Discover more',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        Image.asset(
                          "assets/images/discover more 1.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 2.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 3.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 4.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 5.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 6.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 7.jpg",
                          width: 200,
                        ),
                        Image.asset(
                          "assets/images/discover more 8.jpg",
                          width: 200,
                        ),
                      ]))))
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            // case 0:
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => Homescreen()),
            //   );
            //   break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Neupass()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categories()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfferScreen()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserAccountScreen()),
              );
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                ImageIcon(AssetImage("assets/images/home.png"), size: 24),
                Text("Home", style: TextStyle(fontSize: 12)),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                ImageIcon(AssetImage("assets/images/neupass.png"), size: 24),
                Text("Neupass", style: TextStyle(fontSize: 12)),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                ImageIcon(AssetImage("assets/images/categories.webp"),
                    size: 24),
                Text("Categories", style: TextStyle(fontSize: 12)),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                ImageIcon(AssetImage("assets/images/offer.png"), size: 24),
                Text("Offer", style: TextStyle(fontSize: 12)),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Image.asset("assets/images/profile-bottom.jpg", height: 24),
                Text("Profile", style: TextStyle(fontSize: 12)),
              ],
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ChatScreen(),
              );
            },
          );
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
