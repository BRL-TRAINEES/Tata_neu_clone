import 'package:flutter/material.dart';
import 'package:tataneu_clone/dialog_flow_services.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();
  DialogflowService? _dialogflowService;
  bool _isServiceInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeDialogflowService();
  }

  Future<void> _initializeDialogflowService() async {
    try {
      _dialogflowService = await DialogflowService.fromJson('assets/tataneuappclone2-f3f9cd4e5508.json');

      setState(() {
        _isServiceInitialized = true;
      });
    } catch (e) {
      setState(() {
        _isServiceInitialized = false;
      });
      print("Error initializing DialogflowService: $e");
    }
  }

  void _sendMessage() async {
    if (!_isServiceInitialized) {
      setState(() {
        _messages.add('Bot: Dialogflow is still initializing. Please wait a moment.');
      });
      return;
    }

    final userMessage = _controller.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add('Me: $userMessage');
        _controller.clear();
      });

      try {
        final responseText = await _dialogflowService!.sendMessage(userMessage);
        setState(() {
          _messages.add('Bot: $responseText');
        });
      } catch (e) {
        setState(() {
          _messages.add('Bot: Error: $e');
        });
      }
    } else {
      setState(() {
        _messages.add('Bot: Please enter a message before sending.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("Chat"),
          backgroundColor: Colors.blue,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Align(
                  alignment: _messages[index].startsWith('Me: ') ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: _messages[index].startsWith('Me: ') ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _messages[index],
                      style: TextStyle(
                        color: _messages[index].startsWith('Me: ') ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
