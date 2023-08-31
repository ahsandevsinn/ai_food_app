import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ChatBotProvider extends ChangeNotifier {
  final List<String> _addChat = [];

  List<String> get addChat => _addChat;

  List<String> addChats (String chats){
    _addChat.add(chats);
    notifyListeners();
    return addChat;
  }

  final List<String> _addChatAnswer = [];

  List<String> get addChatAnswer => _addChatAnswer;

  List<String> addChatsAnswer (String chatsAnswer){
    _addChatAnswer.add(chatsAnswer);
    notifyListeners();
    return addChatAnswer;
  }

  final List<dynamic> _addChatMedia = [];

  List<dynamic> get addChatMedia => _addChatMedia;

  List<dynamic> addChatsMedia (dynamic chatsMedia){
    _addChatMedia.add(chatsMedia);
    notifyListeners();
    return addChatMedia;
  }

  final List<Widget> _displayChatsWidget = [];

  List<Widget> get displayChatsWidget => _displayChatsWidget;

  List<Widget> displayChatWidgets (Widget chatsWidget){
    _displayChatsWidget.add(chatsWidget);
    notifyListeners();
    return _displayChatsWidget;
  }
}