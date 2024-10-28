import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tataneu_clone/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tataneu_clone/SearchScreens/search_screen.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});
  Future<void> _getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    // Retrieve and display location
    Position position = await Geolocator.getCurrentPosition();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Current location: ${position.latitude}, ${position.longitude}')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);

    final List<String> imagePaths = [
      "assets/images/medicine.jpg",
      "assets/images/phone.jpg",
      "assets/images/sneakers.jpg",
    ];

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 250, top: 20),
                child: SvgPicture.asset("assets/svg/account.svg"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Image.asset(
                  "assets/images/finance.jpg",
                  width: 100,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Search bar container
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Tata Neu',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _getCurrentLocation(context),
            child: const Text('Get Current Location'),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 300,
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
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/grocery.jpg",
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(height: 4),
                                const Text("Grocery"),
                              ],
                            ),
                            const SizedBox(
                                width:
                                    20), // Space between Grocery and Medicine
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/medicines.jpg",
                                  height: 50,
                                  width: 0,
                                ),
                                const SizedBox(height: 4),
                                const Text("Medicine"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                    width: 16), // Space between Left and Right Containers

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
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/grocery.jpg",
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(height: 4),
                                const Text("Grocery"),
                              ],
                            ),
                            const SizedBox(
                                width:
                                    20), // Space between Grocery and Medicine
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/medicines.jpg",
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(height: 4),
                                const Text("Medicine"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
