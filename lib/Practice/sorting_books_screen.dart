import 'package:flutter/material.dart';

class SortingBooksScreen extends StatefulWidget {
  const SortingBooksScreen({Key? key}) : super(key: key);

  @override
  State<SortingBooksScreen> createState() => _SortingBooksScreenState();
}

class _SortingBooksScreenState extends State<SortingBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sort the Books"),
      ),
      body: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // final articleGet = articleProvider.article[index];
          return
              // articleProvider.article == null
              //   ? const SizedBox.shrink()
              //   :
              const ListTile(
            title: Text("Urdu"),
            subtitle: Text(
              "Hamza",
            ),
            trailing: Text(
              "2008",
            ),
          );
        },
      ),
    );
  }
}
