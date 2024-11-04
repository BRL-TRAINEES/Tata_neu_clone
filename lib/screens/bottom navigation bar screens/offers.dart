import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths and captions
    final List<Map<String, String>> offers = [
      {'image': 'assets/images/appliances.jpg', 'caption': 'Electronics'},
      {'image': 'assets/images/grocery.jpg', 'caption': 'Groceries'},
      {'image': 'assets/images/fashion.jpeg', 'caption': 'Fashion'},
      {'image': 'assets/images/card.png', 'caption': 'Loans &C...'},
      {'image': 'assets/images/hotel.jpeg', 'caption': 'Hotels'},
      {'image': 'assets/images/flight.webp', 'caption': 'Flight'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
      ),
      body:SingleChildScrollView(child: 
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontally scrollable row of offers
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: offers.map((offer) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            offer['image']!, // Path to each specific image
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          offer['caption']!, // Caption for each image
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 50), // Spacing between sections

            // Two lines of text
            const Text(
              "Shop now ,save more",
              
            ),
          
            const Text(
              "Pay Day Bonus Neucoins",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16), // Spacing before the final image

            // Image below the text
            Center(
              child: Image.asset(
                'assets/images/moving5.jpg', // Replace with your specific image path
                height: 200,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40,),
              Text('Shop and Win',
            ),
              SizedBox(height: 5,),
              Text('Tata Neu Rewards League',
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              
                 Image.asset('assets/images/neupass-img3.jpg'),
              SizedBox(height: 20,),
              Text('Get a Personal Loan in just 10 minutes!'),
              SizedBox(height: 8,),
              Text('Get Credit, do more',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Image.asset("assets/images/moving1.jpg"),
              SizedBox(height: 20,),
              Text('Big brands, bigger discounts'),
              const SizedBox(height: 4,),
              Text('Our top brands for you',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Padding(
              padding: EdgeInsets.all(1),
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
            ],
          ),
        ),
      ),
    );
  }
}
