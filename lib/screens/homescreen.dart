import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart'; 
import 'package:tataneu_clone/provider.dart';

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
      SnackBar(content: Text('Current location: ${position.latitude}, ${position.longitude}')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);

    final List<String> _imagePaths = [
      "assets/images/medicine.jpg",
      "assets/images/phone.jpg",
      "assets/images/sneakers.jpg",
    ];

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
            Container(
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
            const SizedBox(height: 10),

            // Button to get current location
            ElevatedButton(
              onPressed: () => _getCurrentLocation(context),
              child: const Text('Get Current Location'),
            ),

            const SizedBox(height: 20),
            // Carousel Section
            Padding(
              padding: const EdgeInsets.all(16.0), 
              child: Container(
                height: 300, 
                child: PageView.builder(
                  itemCount: _imagePaths.length,
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
                          _imagePaths[(navigationState.pageIndex + index) % _imagePaths.length],
                          fit: BoxFit.cover, 
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              // Scan and Pay row placeholder
            ),
          ],
        ),
      ),
    );
  }
}
