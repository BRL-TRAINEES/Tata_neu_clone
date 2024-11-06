import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MobileItemDetail extends StatefulWidget {
  final String model;
  final String brand;
  final String price;
  final String image;

  const MobileItemDetail({
    super.key,
    required this.model,
    required this.brand,
    required this.price,
    required this.image,
  });

  @override
  _MobileItemDetailState createState() => _MobileItemDetailState();
}

class _MobileItemDetailState extends State<MobileItemDetail> {
  final TextEditingController _reviewController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _reviewsCollection =
      FirebaseFirestore.instance.collection('mobileReviews');

  Future<void> _addReview() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No internet connection. Review cannot be added.')),
      );
      return;
    }

    if (_reviewController.text.isNotEmpty) {
      final user = _auth.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You must be logged in to add a review.')),
        );
        return;
      }

      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final username = userDoc.data()?['username'] ?? 'Anonymous';

          await _reviewsCollection.add({
            'mobile': widget.model,
            'userId': user.uid,
            'username': username,
            'review': _reviewController.text,
          });

          setState(() {
            _reviewController.clear();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Review added successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data not found.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add review. Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a review.')),
      );
    }
  }

  Stream<QuerySnapshot> _getReviewsStream() {
    return _reviewsCollection
        .where('mobile', isEqualTo: widget.model)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        title: Text(widget.model),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: double
                      .infinity, // Allow the image container to take full width
                  height: 300, // Set a fixed height for the image
                  decoration: BoxDecoration(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit
                          .contain, // Change to BoxFit.contain to show the whole image
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.model,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Brand: ${widget.brand}",
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text("Price: ${widget.price}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Text(
                'Customer Reviews',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reviews',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _getReviewsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text("An error occurred"));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text("No reviews yet"));
                          }
                          final reviews = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              final reviewData = reviews[index];
                              final username =
                                  reviewData['username'] ?? 'Anonymous';
                              final review = reviewData['review'];
                              final avatarLetter =
                                  username.isNotEmpty ? username[0] : 'A';

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: Text(
                                    avatarLetter.toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  radius: 15,
                                ),
                                title: Text(
                                  review,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                subtitle: Text(
                                  '~ $username',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 16, 16, 16)),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Add a Review',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: 'Enter your review',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _addReview,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 50, 127, 119),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.teal),
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
