import 'dart:convert';
import 'package:pupscan/utils/models.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatMessage {
  final String text;
  final bool isBot;

  ChatMessage({required this.text, required this.isBot});
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'system': String text,
      } =>
        ChatMessage(
          text: text,
          isBot: true,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class ChatBot extends StatefulWidget {
  const ChatBot({super.key, required this.breed});
  final BreedSelect breed;

  @override
  // ignore: library_private_types_in_public_api
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final _textController = TextEditingController();
  List<ChatMessage> _message = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    delayed();
    _message = [
      (ChatMessage(
          text: "Hello there. How can I assist you today?", isBot: true))
    ];
  }

  Future<void> delayed() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void passMessage(String message) {
    setState(() {
      _message.add(ChatMessage(text: message, isBot: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 157, 105),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Doggo Chatbot",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white))),
            const SizedBox(
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ClipOval(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.breed.avatar),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[200],
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _message[index].isBot
                        ? const CircleAvatar(
                            backgroundImage:
                                // AssetImage('assets/images/dog_bot.jpg')
                                NetworkImage(
                                    'https://miro.medium.com/v2/resize:fit:828/format:webp/1*rIkmavUeqyRySwlQdA9kKg.jpeg'),
                          )
                        //https://static.displate.com/324x454/displate/2023-07-07/36564f7949ef83fec3743ccd3bbcabc2_20665b5530dd3d5737abad41cda98d27.avif
                        //https://miro.medium.com/v2/resize:fit:828/format:webp/1*rIkmavUeqyRySwlQdA9kKg.jpeg
                        : null,
                    subtitle: Container(
                        decoration: BoxDecoration(
                            color: _message[index].isBot
                                ? Colors.blueGrey
                                : Colors.lightGreen,
                            borderRadius: BorderRadius.circular(4.5)),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          _message[index].text,
                          style: const TextStyle(color: Colors.white),
                        )),

                    //isThreeLine: true,
                    trailing: !_message[index].isBot
                        ? const CircleAvatar(
                            child: Text('You'),
                          )
                        : null,
                  );
                },
              ),
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Talk with DoggoBot...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      String message = _textController.text;
                      if (message.isNotEmpty) {
                        _message.add(ChatMessage(text: message, isBot: false));
                        botMessage(message, widget.breed.breed);
                        //passMessage(message);
                        _textController.clear();
                      }

                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent * 2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    });
                  },
                ),
              ],
            ).px16(),
          ),
        ],
      ),
    );
  }

  Future<void> botMessage(String inputstring, String breed) async {
    final response = await http.post(
        Uri.parse('http://192.168.254.198:8000/chatbot/get_message/'),
        body: {'input_string': inputstring, 'breed': breed});

    setState(() {
      _message.add(ChatMessage.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>));
    });
  }
}
