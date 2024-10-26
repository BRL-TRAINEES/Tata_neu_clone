import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [Padding(padding: const EdgeInsets.only(left: 250,top: 20),
             child:  SvgPicture.asset("assets/svg/account.svg"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,top: 20),
            child: Image.asset("assets/images/finance.jpg",
            width: 100,)),
          ],
        
          ),
          SizedBox(height: 10),
          //search bar container
          Container(
            padding: EdgeInsets.all(10),
            width: 400,
            height: 50,
             decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Tata Neu',
                      hintStyle: TextStyle(fontSize: 16,
                      color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
              ),  
          ),
        ],
      ),
    );
  }
}
  



