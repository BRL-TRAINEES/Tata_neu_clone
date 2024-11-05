import 'package:flutter/material.dart';
import 'package:tataneu_clone/Chatbot/chat2_screen.dart';
import 'package:tataneu_clone/Chatbot/chat_history_Screen.dart';
import 'package:tataneu_clone/Chatbot/profile_screen_chat.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  //page view controller
  final PageController _pageController = PageController();

  //list of screens
  final List<Widget> _screens = [
    Chat2Screen(),
    ChatHistoryScreen(),
    ProfileScreenChat(),
  ];

  //index of current screen
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 0,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Chat History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        ),
    );
  }
}
