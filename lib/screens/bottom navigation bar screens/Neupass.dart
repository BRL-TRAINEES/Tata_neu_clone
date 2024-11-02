import 'package:flutter/material.dart';
import 'package:tataneu_clone/screens/login_screen.dart';

class Neupass extends StatelessWidget {
  const Neupass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:  
      SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset("assets/images/neupass logo.png",
                  height: 90,
                  width: 140,
                  ),
                   const SizedBox(width: 100), 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninScreen()));
                      },
                      child: const Text("Login / Signup",
                      style: TextStyle(color: Colors.white),
                      ),
                    ),
                  
                ],
              ),
              
            ),
            Row(
              children: [
                
                Image.asset("assets/images/neupass-wallet.png",
                height: 90,
                width: 100,),
                SizedBox(width: 10,),
                
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check your Neucoins balance now!",
                        style: TextStyle(color: Colors.purple),
                      ),
                      const SizedBox(height: 8), 
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        ),
                        onPressed: () {
                          
                        },
                        child: const Text(
                          "View Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset('assets/images/neupass-img1.jpg'),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "Get exclusive access to special offers and discounts with NeuPass. Check out the latest benefits now!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset('assets/images/neupass-img2.jpg'),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "Get exclusive access to special offers and discounts with NeuPass. Check out the latest benefits now!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 40,),
              Text('Shop and Win',
              style: TextStyle(color: Colors.grey),),
              SizedBox(height: 5,),
              Text('Tata Neu Rewards League',
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset('assets/images/neupass-img3.jpg'),),
              SizedBox(height: 10,),
            ],
          ),
        ),

              

            )
          
          
        
      );
  
  }
}