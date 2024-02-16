import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, String>> _chatMessages = [];

  static const String user = "User";
  static const String bot = "Bot";

  @override
  void initState() {
    super.initState();
    _chatMessages.add({
      "sender": bot,
      "message": "Hi there! I'm here to assist you. Feel free to ask me anything!",
    });
  }

  void _handleMessageSend(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _chatMessages.add({"sender": user, "message": message});

        // Respond to specific questions
        _respondToQuestion(message);

        _textController.clear(); // Clear the input field
      });
    }
  }

  void _respondToQuestion(String question) {
    String response = "";

    // Check for specific questions and provide appropriate responses
    switch (question.toLowerCase()) {
      case 'how do i request a service?':
        response =
        "To request a service, follow these steps:\n1. Go to the home page.\n2. Click on the service you want.\n3. Fill up the form.\n4. Submit your request.";
        break;
      case 'what services do you offer?':
        response =
        "We offer a variety of services including house repair, personal services, and more. You can explore them on our home page.";
        break;
      case 'how can i contact support?':
        response =
        "If you need support, you can reach us through our social media channels or via email. Visit our home page and click on the support option to find our contact details.";
        break;
      case 'how do i make a payment?':
        response =
        "You can make payments securely through our app. Simply go to the payment section and follow the instructions to complete your transaction.";
        break;
      case 'is there a warranty for your services?':
        response =
        "Yes, we provide warranty for our services. The duration and coverage vary depending on the type of service. Please refer to our terms and conditions for more details.";
        break;
      default:
        response =
        "I'm sorry, I don't understand that question. You can ask me about our services, how to request a service, how to make a payment, or how to contact support.";
    }

    // Add bot's response to the chat
    _chatMessages.add({"sender": bot, "message": response});
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
              reverse: true, // Scroll to bottom initially
              itemCount: _chatMessages.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, String> message = _chatMessages.reversed.toList()[index]; // Reverse the list
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: MessageWidget(message: message),
                );
              },
            ),
          ),
          // Your message input field and buttons

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 8.0,
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleMessageSend('How do I request a service?'),
                      child: Text('How to request a service?'),
                    ),
                    ElevatedButton(
                      onPressed: () => _handleMessageSend('What services do you offer?'),
                      child: Text('What services do you offer?'),
                    ),
                    ElevatedButton(
                      onPressed: () => _handleMessageSend('How can I contact support?'),
                      child: Text('How to contact support?'),
                    ),
                    ElevatedButton(
                      onPressed: () => _handleMessageSend('How do I make a payment?'),
                      child: Text('How to make a payment?'),
                    ),
                    ElevatedButton(
                      onPressed: () => _handleMessageSend('Is there a warranty for your services?'),
                      child: Text('Warranty for services?'),
                    ),
                  ],
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
