import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  var responseData;
  List<dynamic> addQuestionData = [];
  List<String> question = [];
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
                                    question[addQuestionData.length - 1 - index],
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
                          addQuestionData[addQuestionData.length - 1 - index]
                                      ['answer'] ==
                                  null
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
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                "${addQuestionData[addQuestionData.length - 1 - index]['answer']}",
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
                                          imageUrl:
                                              "${addQuestionData[addQuestionData.length - 1 - index]['image']}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                        child: Text(
                                          "${addQuestionData[addQuestionData.length - 1 - index]['type']}",
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
                      quickAnswers();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void quickAnswers() async {
    // String question = _messageController.text;
    // final recipesParameterProvider =
    //     Provider.of<RecipesParameterProvider>(context, listen: false);
    // recipesParameterProvider.loading();
    final apiKey = 'c8006bcb5d99435bada05e67f3db55cc';
    // const apiKey = '50c97694758d413ba8021361c1a6aff8';
    final apiUrl =
        'https://api.spoonacular.com/recipes/quickAnswer?q=${_messageController.text}';
    final queryParams = {
      'q': _messageController.text, // (Required) The nutrition related question.
      'apiKey': apiKey,
    };
    final response =
        await AppDio(context).get(queryParameters: queryParams, path: apiUrl);
    if (response.statusCode == 200) {
      final resData = response.data;
      print("data_length ${resData.length}");
      if (resData != null) {
        setState(() {
          responseData = resData;
          addQuestionData.add(responseData);
          question.add(_messageController.text);
          _messageController.clear();
          print("getting_response ${resData}");
        });
        // recipesParameterProvider.loading();
      }
      print("jkdbkvbjdb${resData}");
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }
}
