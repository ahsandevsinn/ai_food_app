import 'package:ai_food/Practice/books_class.dart';
import 'package:ai_food/Practice/books_provider.dart';
import 'package:ai_food/Practice/category_screen.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortingBooksScreen extends StatefulWidget {
  const SortingBooksScreen({Key? key}) : super(key: key);

  @override
  State<SortingBooksScreen> createState() => _SortingBooksScreenState();
}

class _SortingBooksScreenState extends State<SortingBooksScreen> {
  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sortBooksProvider = Provider.of<Books>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sort the Books"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
                CupertinoPageRoute(builder: (_) => const CategoryScreen()));
          }, icon: const Icon(Icons.navigate_next_sharp)),
        ],
      ),
      body: ListView.builder(
        itemCount: sortBooksProvider.booksSorting.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final sortBooks = sortBooksProvider.booksSorting[index];
          return sortBooks == null
              ? const SizedBox.shrink()
              : ListTile(
                  title: Text(sortBooks.bookTitle),
                  subtitle: Text(
                    sortBooks.author,
                  ),
                  trailing: Text(
                    "${sortBooks.publicationYear}",
                  ),
                );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Center(
                            child: AppText(
                              "Sort List According to",
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              sortBooksProvider.sortBooksTitle();
                              Navigator.of(context).pop();
                            },
                            child: const AppText(
                              "Books Title",
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              sortBooksProvider.sortBooksAuthor();
                              Navigator.of(context).pop();
                            },
                            child: const AppText(
                              "Author",
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              sortBooksProvider.sortBooksPublicationYear();
                              Navigator.of(context).pop();
                            },
                            child: const AppText(
                              "Publication Year",
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.sort),
            ),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              addPopUp();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  addPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final sortBooksProvider = Provider.of<Books>(context, listen: true);
        return AlertDialog(
            content: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableField(bName: "Book Name", controller: nameController),
              ReuseableField(
                  bName: "Author Name", controller: authorController),
              ReuseableField(
                  bName: "Publish Year",
                  keyboardtype: TextInputType.number,
                  controller: yearController),
              Button(
                  butText: "Save",
                  function: () {
                    sortBooksProvider.addBooks(
                      BooksSorting(
                        bookTitle: nameController.text,
                        author: authorController.text,
                        publicationYear: yearController.text,
                      ),
                    );
                    nameController.clear();
                    authorController.clear();
                    yearController.clear();
                    Navigator.of(context).pop();
                  })
            ],
          ),
        ));
      },
    );
  }

  Widget ReuseableField(
      {bName, keyboardtype, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$bName"),
        TextField(
          controller: controller,
          keyboardType: keyboardtype,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }

  Widget Button({butText, required Function() function}) {
    return ElevatedButton(
      onPressed: function,
      child: Text("$butText"),
    );
  }
}
