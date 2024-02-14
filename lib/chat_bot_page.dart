import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, String>> _chatMessages = [];
  List<String> _questionOptions = [
    'How do I request a service?',
    'What services do you offer?',
    'How can I contact support?',
  ];

  static const String user = "User";
  static const String bot = "Bot";

  void _handleMessageSend(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _chatMessages.add({"sender": user, "message": message});

        if (message.toLowerCase() == 'how do i request a service?') {
          _chatMessages.add({
            "sender": bot,
            "message":
            "To request a service, follow these steps:\n1. Go to the home page.\n2. Click on the service you want.\n3. Fill up the form.\n4. Submit your request."
          });
        } else if (message.toLowerCase() == 'what services do you offer?') {
          _chatMessages.add({
            "sender": bot,
            "message":
            "We offer a variety of services including house repair, personal services, and more. You can explore them on our home page."
          });
        } else if (message.toLowerCase() == 'how can i contact support?') {
          _chatMessages.add({
            "sender": bot,
            "message":
            "If you need support, you can reach us through our social media channels or via email. Visit our home page and click on the support option to find our contact details."
          });
        } else if (_questionOptions.contains(message)) {
          _chatMessages.add({"sender": bot, "message": "You asked: $message"});
        } else {
          _chatMessages.add({"sender": bot, "message": "Hi there! How can I assist you?"});
        }

        _textController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/12.png',
          height: 40,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, String> message = _chatMessages[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: MessageWidget(message: message),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 8.0,
                  children: _questionOptions
                      .map(
                        (option) => ElevatedButton(
                      onPressed: () => _handleMessageSend(option),
                      child: Text(option),
                    ),
                  )
                      .toList(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.paperPlane),
                      onPressed: () {
                        String message = _textController.text.trim();
                        _handleMessageSend(message);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Map<String, String> message;

  const MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message["sender"] == _ChatBotPageState.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: message["sender"] == _ChatBotPageState.user
              ? Colors.blue[200]
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(12.0),
        child: Text(
          message["message"]!,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
