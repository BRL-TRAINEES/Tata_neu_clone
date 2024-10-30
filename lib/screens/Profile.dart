import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final usernameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final profileImageProvider = StateProvider<File?>((ref) => null);

final usernameControllerProvider = Provider((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final emailControllerProvider = Provider((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final email = ref.watch(emailProvider);
    final profileImage = ref.watch(profileImageProvider);

    final usernameController = ref.watch(usernameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);

    usernameController.text = username;
    emailController.text = email;

    Future<void> _pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        ref.read(profileImageProvider.notifier).state = File(image.path);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Color(0xFFFFD700))),
        backgroundColor: Color(0xFF001F3F),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFF001F3F).withOpacity(0.8),
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage)
                      : AssetImage('assets/default_avatar.png')
                          as ImageProvider,
                  child: profileImage == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Color(0xFFFFD700),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Edit Profile Picture',
                style: TextStyle(
                  color: Color(0xFF001F3F),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              _buildTextField(
                label: 'Username',
                controller: usernameController,
                onChanged: (value) =>
                    ref.read(usernameProvider.notifier).state = value,
              ),
              SizedBox(height: 20),
              _buildTextField(
                label: 'Email',
                controller: emailController,
                onChanged: (value) =>
                    ref.read(emailProvider.notifier).state = value,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  final usernameValue = ref.read(usernameProvider);
                  final emailValue = ref.read(emailProvider);
                  print('Username: $usernameValue, Email: $emailValue');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 60, 66),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Save Profile',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 248, 224, 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: Color(0xFF001F3F)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF001F3F)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Color(0xFF001F3F).withOpacity(0.3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF001F3F), width: 1.5),
        ),
      ),
    );
  }
}
