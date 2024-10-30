import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final usernameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final profileImageProvider = StateProvider<File?>((ref) => null);

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final email = ref.watch(emailProvider);
    final profileImage = ref.watch(profileImageProvider);

    // Func to pick an image & update profile photo
    Future<void> _pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        ref.read(profileImageProvider.notifier).state = File(image.path);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage)
                    : AssetImage('assets/default_avatar.png') as ImageProvider,
                child: profileImage == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white.withOpacity(0.8),
                      )
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) =>
                  ref.read(usernameProvider.notifier).state = value,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: TextEditingController(text: username),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) =>
                  ref.read(emailProvider.notifier).state = value,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: TextEditingController(text: email),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                final usernameValue = ref.read(usernameProvider);
                final emailValue = ref.read(emailProvider);
                print('Username: $usernameValue, Email: $emailValue');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
