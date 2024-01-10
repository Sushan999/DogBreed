import 'package:pupscan/Api/api.dart';
import 'package:pupscan/utils/models.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key, required this.breed});
  final ListBreed breed;

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
          text:
              "Hello there. How can I assist you today?. Any Queries about ${widget.breed.breed}?.",
          isBot: true))
    ];
  }

  Future<void> delayed() async {
    await Future.delayed(const Duration(milliseconds: 200));
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
                        _botMessage(message, widget.breed.breed);
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

  Future<void> _botMessage(String inputstring, String breed) async {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _message.add(ChatMessage(text: "...", isBot: true));
      });
    });

    ChatMessage message = await ApiCalls.botMessage(inputstring, breed);

    setState(() {
      _message.removeLast();
      _message.add(message);
    });
  }
}
