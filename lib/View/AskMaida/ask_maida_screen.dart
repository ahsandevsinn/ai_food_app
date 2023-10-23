import 'dart:convert';

import 'package:ai_food/Constants/apikey.dart';
import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/logout.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/errordialogue.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/chat_bot_provider.dart';
import 'package:ai_food/View/recipe_info/recipe_info.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/dio/spoonacular_app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:ai_food/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'result_container_askMaida.dart';
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AskMaidaScreen extends StatefulWidget {
  const AskMaidaScreen({Key? key}) : super(key: key);

  @override
  State<AskMaidaScreen> createState() => _AskMaidaScreenState();
}

class _AskMaidaScreenState extends State<AskMaidaScreen> with AutomaticKeepAliveClientMixin{
 bool get wantKeepAlive => true;
  final TextEditingController _messageController = TextEditingController();
  late ScrollController _scrollController;
  late AppDio dio;
  late SpoonAcularAppDio spoonDio;
  AppLogger logger = AppLogger();
  var queryText;
  var savePreviousQuery;
  //new api data adding
  @override
  void initState() {

    dio = AppDio(context);
    spoonDio = SpoonAcularAppDio(context);
    logger.init();
    changeCondition();
    //clearChatProvider.displayChatsWidget;

    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    // Future.microtask(() {
    //   clearChatProvider.clearDisplayChatsWidget();
    // });
    super.dispose();
  }
  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final loadingProvider = Provider.of<ChatBotProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        key: scaffoldMessengerKey,
        backgroundColor: Colors.black.withOpacity(0.1),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   getRecipeInformation(id:);
        // }),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Ask Maida",
            style: TextStyle(
                color: AppTheme.appColor,
                fontWeight: FontWeight.w600,
                fontSize: 24),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  scale: 0.5,
                  opacity: 0.25)),
          child: Column(
            children: [
              Visibility(
                visible: loadingProvider.iscontainer,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.appColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AppText.appText(
                        textAlign: TextAlign.center,
                        "There are instances where errors may be generated by the AI.",
                        textColor: AppTheme.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              // customChat(),
              Expanded(
                child: Consumer<ChatBotProvider>(
                  builder: (context, chatProvider, _) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollToBottom();
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: chatProvider.displayChatsWidget.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppTheme.appColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: AppText.appText(
                                      textAlign: TextAlign.center,
                                      "There are instances where errors may be generated by the AI.",
                                      textColor: AppTheme.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              chatProvider.displayChatsWidget[index],
                            ],
                          );
                        } else {
                          return chatProvider.displayChatsWidget[index];
                        }
                      },
                      addAutomaticKeepAlives: true,
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          loadingProvider.isLoading
                              ? Image.asset(
                                  "assets/images/loader.gif",
                                  // width: 100,
                                  height: 50,
                                  color: AppTheme.appColor,
                                )
                              : const SizedBox.shrink(),
                          Align(
                            alignment: Alignment.center,
                            child: Visibility(
                              visible: loadingProvider.regenerateLoader,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    queryText = "more ${savePreviousQuery}";
                                  });
                                  chatBotTalk();
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppTheme.whiteColor,
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(color: AppTheme.appColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.autorenew,
                                          color: AppTheme.appColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        AppText.appText(
                                          "Regenerate result",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          textColor: AppTheme.appColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            onSubmitted: (value) {
                              queryText = null;
                              if (_messageController.text.isNotEmpty) {
                                savePreviousQuery = _messageController.text;

                                chatBotTalk();
                              }
                            },
                            onChanged: (value) {
                              loadingProvider.regenerateLoaderLoading(false);
                            },
                            controller: _messageController,
                            cursorColor: AppTheme.whiteColor,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            maxLines: 3,
                            style: TextStyle(color: AppTheme.whiteColor),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 30.0, top: 4, bottom: 4),
                              fillColor: AppTheme.appColor,
                              filled: true,
                              hintText: "Enter query...",
                              hintStyle: const TextStyle(
                                color: Color(0x80FFFFFF),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      queryText = null;
                                      savePreviousQuery =
                                          _messageController.text;
                                    });

                                    if (_messageController.text.isNotEmpty) {
                                      chatBotTalk();
                                    }
                                  },
                                  child: Icon(
                                    Icons.send_outlined,
                                    color: AppTheme.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chatBotTalk() async {
    final width = MediaQuery.of(context).size.width;
    final pref = await SharedPreferences.getInstance();
    var response;
    final chatsProvider = Provider.of<ChatBotProvider>(context, listen: false);
    chatsProvider.messageLoading(true);
    final apiUrlTwo =
        'https://api.spoonacular.com/food/converse?text=${queryText == null ? savePreviousQuery : queryText}&apiKey=$apiKey2';
    final apiUrl =
        'https://api.spoonacular.com/food/converse?text=${queryText == null ? savePreviousQuery : queryText}&apiKey=$apiKey';
    response = await spoonDio.get(path: apiUrl);
    if (response.statusCode == 200) {
      final resData = response.data;
      searchRecipeChatBot(resData, queryText ?? _messageController.text);
      if (resData != null) {
        // setState(() {
        //   visibilityContainer = false;
        // });
        chatsProvider.containerLoading(false);
        chatsProvider.displayChatWidgets(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.appColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: AppText.appText(
                            "${queryText == null ? savePreviousQuery : queryText}",
                            textColor: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: AppText.appText(
                    resData['answerText'],
                    textColor: AppTheme.appColor,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              resData['media'] == null || resData['media'].isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: resData['media']
                          .map<Widget>(
                            (item) => resultContainer(data: item,)
                          )
                          .toList(),
                    ),
            ],
          ),
        );

        chatsProvider.regenerateLoaderLoading(true);
        _messageController.clear();
        chatsProvider.messageLoading(false);
      }
    } else if (response.statusCode == 402) {
      response = await spoonDio.get(path: apiUrlTwo);
      if (response.statusCode == 402) {
        chatsProvider.messageLoading(false);
        showSnackBar(context, 'Payment required');
      } else {
        final resData = response.data;
        searchRecipeChatBot(resData, queryText ?? _messageController.text);
        if (resData != null) {
          // setState(() {
          //   visibilityContainer = false;
          // });
          chatsProvider.containerLoading(false);
          chatsProvider.displayChatWidgets(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 14),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.appColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: AppText.appText(
                              "${queryText == null ? savePreviousQuery : queryText}",
                              textColor: AppTheme.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: AppText.appText(
                      resData['answerText'],
                      textColor: AppTheme.appColor,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                resData['media'] == null || resData['media'].isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        children: resData['media']
                            .map<Widget>(
                              (item) => resultContainer(data: item),).toList(),
                      ),
              ],
            ),
          );
          chatsProvider.regenerateLoaderLoading(true);
          _messageController.clear();
          chatsProvider.messageLoading(false);
        } else {
          showSnackBar(context, '${response.statusCode}');
          chatsProvider.messageLoading(false);
        }
      }
    }
  }

  void searchRecipeChatBot(chatBotResponseData, query) async {
    Map<String, dynamic> params = {};
    try {
      if (chatBotResponseData['media'] != null &&
          chatBotResponseData['media'].isNotEmpty) {
        params = {
          "search": query,
          "recipes": [],
        };

        for (int i = 0; i < chatBotResponseData['media'].length; i++) {
          params['recipes'].add({
            "url": chatBotResponseData['media'][i]['link'] ?? 'link not found',
            "recipe_id": chatBotResponseData['media'][i]['link']
                .toString()
                .split("-")
                .last,
            "title": chatBotResponseData['media'] == null
                ? chatBotResponseData['answerText']
                : chatBotResponseData['media'][i]['title'],
            "image":
                chatBotResponseData['media'][i]['image'] ?? 'image not found',
          });
        }
      } else {
        params = {
          "search": query,
          // "recipes[1][url]": 'link not found',
          // "recipes[1][recipe_id]": '1234',
          "recipes[1][title]": chatBotResponseData['answerText'],
          // "recipes[1][image]": 'image not found',
        };
      }

      var responseChatBot =
          await dio.post(path: AppUrls.searchRecipe, data: params);
      print("api_response $responseChatBot");
    } catch (e) {
      print(e);
    }
  }

  void changeCondition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PrefKey.conditiontoLoad, 0);
  }


}
