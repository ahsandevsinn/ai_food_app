import 'package:ai_food/Practice/list_management_provider.dart';
import 'package:ai_food/Practice/task_ui.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListManagement extends StatefulWidget {
  const ListManagement({Key? key}) : super(key: key);

  @override
  State<ListManagement> createState() => _ListManagementState();
}

class _ListManagementState extends State<ListManagement> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final practiceProvider =
        Provider.of<ListManagementProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("List Management ${practiceProvider.usrName}"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const TasksUI()));
              },
              icon: const Icon(Icons.navigate_next_sharp))
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: practiceProvider.namesList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Center(
              child: AppText(practiceProvider.namesList[index]),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     practiceProvider.namesListManagement("Zain");
      //     print("list_management is this");
      //   },
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 30),
            width: 310,
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: "Type Name", border: OutlineInputBorder()),
            ),
          ),
          IconButton(
              onPressed: () {
                practiceProvider.namesListManagement(_controller.text.trim());
                _controller.clear();
              },
              icon: const Icon(Icons.send)),
          IconButton(
              onPressed: () {
                practiceProvider.searchName(_controller.text.trim());
                _controller.clear();
              },
              icon: const Icon(Icons.search)),
        ],
      ),
    );
  }
}
