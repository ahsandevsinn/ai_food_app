import 'package:ai_food/config/dio/app_dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBotTalkScreen extends StatefulWidget {
  const ChatBotTalkScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotTalkScreen> createState() => _ChatBotTalkScreenState();
}

class _ChatBotTalkScreenState extends State<ChatBotTalkScreen> {
  final TextEditingController _messageController = TextEditingController();
  var responseData;
  List<dynamic> addQuestionData = [];
  List<String> question = [];
  var res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask Maida"),
      ),
      body: Column(
        children: [
          Expanded(
            child: addQuestionData.isEmpty
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
                            "Please ask nutrition related question",
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
                : ListView.builder(
                    reverse: true,
                    itemCount: addQuestionData.length,
                    itemBuilder: (context, index) {
                      // var showData;
                      // for (var recipe in addQuestionData) {
                      //   showData = recipe[index];
                      // }
                      // print("ada_data ${addQuestionData[index]} ${addQuestionData.length}");
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.rocket_launch,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    res,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          addQuestionData.isEmpty
                              ? const Text(
                                  "Sorry! There is no data related to your question.",
                                  style: TextStyle(color: Colors.red),
                                )
                              : Container(
                                  color: Colors.blueGrey,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CircleAvatar(
                                              radius: 20,
                                              child: Icon(
                                                Icons.question_answer_outlined,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                "${addQuestionData[addQuestionData.length - 1 - index]['title']}",
                                                // "title",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        height: 200,
                                        child: CachedNetworkImage(
                                          imageUrl: "${addQuestionData[addQuestionData.length - 1 - index]['image']}",
                                          // "image",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 20.0),
                                        child: Text(
                                          "${addQuestionData[addQuestionData.length - 1 - index]['link']}",
                                          // "url",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
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
                        hintText: "Type your nutrition question...",
                        border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      chatBotTalk();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void chatBotTalk() async {
    // const apiKey = '50c97694758d413ba8021361c1a6aff8';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';
    final apiUrl =
        'https://api.spoonacular.com/food/converse?text=${_messageController.text}&contextId=654321';
    final queryParams = {
      'text': _messageController.text,
      'apiKey': apiKey,
      'contextId': 654321,
    };
    final response =
        await AppDio(context).get(queryParameters: queryParams, path: apiUrl);
    if (response.statusCode == 200) {
      final resData = response.data['media'];
      print("data_length ${resData.length}");
      if (resData != null) {
        responseData = resData;
        addQuestionData.addAll(responseData);
        question.add(_messageController.text);
        print("getting_response ${resData}");
        res = response.data['answerText'];
        setState(() {});
        _messageController.clear();
      }
      print("jkdbkvbjdb${addQuestionData}");
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }
}
