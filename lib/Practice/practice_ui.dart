import 'package:ai_food/Practice/list_management.dart';
import 'package:ai_food/Practice/provider_practice.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PracticeUI extends StatefulWidget {
  const PracticeUI({Key? key}) : super(key: key);

  @override
  State<PracticeUI> createState() => _PracticeUIState();
}

class _PracticeUIState extends State<PracticeUI> {
  @override
  Widget build(BuildContext context) {
    final practiceProvider = Provider.of<PracticeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice UI"),
      ),
      body: Builder(
        builder: (context) {
          return practiceProvider.isLoading
              ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AppText(practiceProvider.userName, size: 36),
                practiceProvider.responseData['data'] != null ? const SizedBox.shrink() : const AppText("Press Button to show Data", size: 20),
                const SizedBox(height: 20),
                practiceProvider.responseData['data'] == null ? const Text("") : AppText("User Email : "+ practiceProvider.responseData["data"]['user']['email'],size: 18),
                const SizedBox(height: 20),
                practiceProvider.responseData['data'] == null ? const Text("") : AppText("User Name : "+ practiceProvider.responseData["data"]['user']['name'],size: 20),
                const SizedBox(height: 20),
                AppText(
                  'List Management Screen',
                  size: 20,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => const ListManagement()));
                  },
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          practiceProvider.showPrints("Good");
          await practiceProvider.login(context,
              email: "vendor1122@gmail.com", password: "123456");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
