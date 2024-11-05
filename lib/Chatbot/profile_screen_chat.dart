import 'package:flutter/material.dart';

class ProfileScreenChat extends StatefulWidget {
  const ProfileScreenChat({super.key});

  @override
  State<ProfileScreenChat> createState() => _ProfileScreenChatState();
}

class _ProfileScreenChatState extends State<ProfileScreenChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile Screen Chat'),
      ),
    );
  }
}