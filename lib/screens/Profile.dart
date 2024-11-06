import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tataneu_clone/screens/login_screen.dart';

class UserAccountScreen extends StatefulWidget {
  @override
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  File? _profileImage;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  User? _user;
  bool _isLoading = false;
  bool _isNewUser = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _getUserProfileData();
    } else {
      setState(() {
        _usernameController.text = 'Guest';
        _emailController.text = 'guest@example.com';
      });
    }
  }

  Future<void> _getUserProfileData() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user!.uid).get();
      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _usernameController.text =
              data['username'] ?? _user?.displayName ?? 'Guest';
          _emailController.text =
              data['email'] ?? _user?.email ?? 'guest@example.com';
        });
      } else {
        setState(() {
          _isNewUser = true;
          _usernameController.text = 'Guest';
          _emailController.text = 'guest@example.com';
        });
      }
    } catch (e) {
      setState(() {
        _isNewUser = true;
      });
      print('Error getting user data: $e');
    }
  }

  Future<void> _updateProfile() async {
    if (_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('You need to be logged in to update your profile')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;

      if (_profileImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${_user!.uid}');
        await storageRef.putFile(_profileImage!);
        imageUrl = await storageRef.getDownloadURL();
      }

      await _firestore.collection('users').doc(_user!.uid).set({
        'username': _usernameController.text,
        'email': _emailController.text,
        'profile_image': imageUrl,
      }, SetOptions(merge: true));

      await _user!.updateDisplayName(_usernameController.text);
      await _user!.updateEmail(_emailController.text);
      await _user!.reload();
      _user = _auth.currentUser;

      setState(() {
        _isLoading = false;
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    setState(() {
      _user = null;
    });
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _goToLoginScreen() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Account'),
        backgroundColor: const Color(0xFF003366),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : NetworkImage(_user?.photoURL ??
                                    'https://www.w3schools.com/howto/img_avatar.png')
                                as ImageProvider,
                        child: _profileImage == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        enabled: _isEditing),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isEditing ? _updateProfile : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003366),
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save Profile'),
                    ),
                    const SizedBox(height: 30),
                    _user != null
                        ? Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditing =
                                        !_isEditing; // Toggle edit mode
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(_isEditing
                                    ? 'Cancel Edit'
                                    : 'Edit Profile'),
                              ),
                              ElevatedButton(
                                onPressed: _logout,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Log Out'),
                              ),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: _goToLoginScreen,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Log In'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
