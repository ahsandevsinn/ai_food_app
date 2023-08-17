import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBotTalkScreen extends StatefulWidget {
  const ChatBotTalkScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotTalkScreen> createState() => _ChatBotTalkScreenState();
}

class _ChatBotTalkScreenState extends State<ChatBotTalkScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatBotProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask Maida"),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatProvider.displayChatsWidget.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.fastfood,
                          size: 105,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            "Please ask questions to Maida.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Consumer<ChatBotProvider>(
                    builder: (context, chatProvider, _) {
                    return ListView(
                      children: chatProvider.displayChatsWidget,
                    );
                  }),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText: "Type your question...",
                        border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        chatBotTalk();
                      } else {
                        showSnackBar(
                            context, "Please ask a question to maida!");
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void chatBotTalk() async {
    final chatsProvider = Provider.of<ChatBotProvider>(context, listen: false);
    // const apiKey = '50c97694758d413ba8021361c1a6aff8';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';
    final apiUrl =
        'https://api.spoonacular.com/food/converse?text=${_messageController.text}&contextId=654321&apiKey=$apiKey';
    final response = await AppDio(context).get(path: apiUrl);
    if (response.statusCode == 200) {
      final resData = response.data;
      if (resData != null) {
        chatsProvider.displayChatWidgets(
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(_messageController.text),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      child: Icon(
                        Icons.rocket_launch,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(resData['answerText']),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              resData['media'] == null || resData['media'].isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: resData['media']
                          .map<Widget>(
                            (item) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 300,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: "${item['image']}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Center(
                                      child: AppText(
                                        item['title'],
                                        alignText: true,
                                        justifyText: true,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final webUrl = "${item['link']}";
                                      if (await canLaunch(webUrl)) {
                                        await launch(webUrl);
                                      } else {
                                        throw 'Could not launch $webUrl';
                                      }
                                    },
                                    child: SizedBox(
                                      width: 300,
                                      child: Center(
                                        child: AppText(
                                          item['link'],
                                          alignText: true,
                                          justifyText: true,
                                          color: Colors.blue,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
              const Divider(),
            ],
          ),
        );
        _messageController.clear();
      }
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }
}
