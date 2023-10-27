import 'package:ai_food/View/HomeScreen/widgets/providers/chat_bot_provider.dart';
import 'package:ai_food/View/auth/GoogleSignIn/authentication.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtil {
  static Future<void> logout(BuildContext context) async {
    final clearChatProvider = Provider.of<ChatBotProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefKey.dataonBoardScreenAllergies);
    await prefs.remove(PrefKey.dataonBoardScreenDietryRestriction);
    await prefs.remove(PrefKey.dateOfBirth);
    await prefs.remove(PrefKey.userName);
    await prefs.remove(PrefKey.unit);
    await prefs.remove(PrefKey.authorization);
    await prefs.remove(PrefKey.socialId);
    clearChatProvider.clearDisplayChatsWidget();
    clearChatProvider.containerLoading(true);
    clearChatProvider.regenerateLoaderLoading(false);
    await Authentication.signOut(context: context);
  }
}