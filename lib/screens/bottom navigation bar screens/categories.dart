import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // List of names for each button
    final List<String> buttonNames = [
      'Daily',
      'Electronics',
      'Fashion and Lifestyle',
      'Cards and Loans',
      'Travel'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: SingleChildScrollView(child: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal list of buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: buttonNames.map((name) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0), // Space between buttons
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality for each button here
                      },
                      child: Text(name),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20.0), // Space between buttons and "Daily" text

            // "Daily" text
            const Text(
              'Daily',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10.0), // Space between "Daily" text and images

            // Row of three images with text below each
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // First image and text
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/grocery.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between image and text
                    const Text('Grocery'),
                  ],
                ),
                const SizedBox(width: 20), // Space between images
                // Second image and text
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/grocery.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between image and text
                    Column(
                      children: const [
                        Text('Instant Grocery'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 20), // Space between images
                // Third image and text
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/medicines.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between image and text
                    const Text('Medicines'),
                  ],
                ),
              ],
            ),
            Divider(),

            const SizedBox(height: 20.0), // Space between "Daily" images and "Electronics" text

            // "Electronics" text
            const Text(
              'Electronics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20.0), // Space between "Electronics" text and images

            // Row of four images with text below each
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // First image and text for Electronics
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/mobile.png', // Update with correct image path
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between image and text
                    const Text('Mobile'),
                  ],
                ),
                const SizedBox(width: 20), // Space between images
                // Second image and text for Electronics
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/headphone.jpeg', // Update with correct image path
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between image and text
                    const Text('Gadgets'),
                  ],
                ),
                const SizedBox(width: 20), // Space between images
                // Third image and text for Electronics
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/appliances.jpg', // Update with correct image path
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between image and text
                    const Text('TV & Appliances'),
                  ],
                ),
              ],
            ),
            Divider(),

            SizedBox(height: 20),
            const Text(
              "Fashion & Lifestyle",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(children: [
                    Image.asset(
                      "assets/images/fashion.jpeg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Fashion'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/footwear.jpeg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Footwear'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/watches.jpeg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Watches'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/jewellery.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Jewellery'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/eyewear.jpeg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Eyewear')
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(),

            // "Cards & Loans" text
            const Text(
              "Cards & Loans",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16), // Space between text and images

            // Row of four images with text below each
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(children: [
                    Image.asset(
                      "assets/images/card.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Credit Cards'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/coin.jpg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Personal Loan'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/Tata pay later.jpg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Tata Pay Later'),
                  ]),
                  SizedBox(width: 20),
                  Column(children: [
                    Image.asset(
                      "assets/images/Free Credit Score.jpg",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 4),
                    Text('Free Credit Score'),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(),

            // "Travel" text
            const Text(
              "Travel",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16), // Space between text and images

            // Row of two images with text below each
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(children: [
                  Image.asset(
                    
                    "assets/images/hotel.jpeg",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(height: 4),
                  Text('Hotels'),
                ]),
                SizedBox(width: 20),
                Column(children: [
                  Image.asset(
                    "assets/images/flight.webp",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(height: 4),
                  Text('Flights'),
                ]),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
