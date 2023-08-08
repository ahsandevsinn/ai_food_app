import 'package:ai_food/Practice/books_class.dart';
import 'package:flutter/foundation.dart';

class Books extends ChangeNotifier {
  final List<BooksSorting> _booksSorting = [];

  List<BooksSorting> get booksSorting => _booksSorting;

  List<BooksSorting> addBooks(BooksSorting booksAdd) {
    _booksSorting.add(booksAdd);
    notifyListeners();
    return booksSorting;
  }

  void sortBooksTitle() {
    _booksSorting.sort((a, b) => a.bookTitle.compareTo(b.bookTitle));
    notifyListeners();
  }

  void sortBooksAuthor() {
    _booksSorting.sort((a, b) => a.author.compareTo(b.author));
    notifyListeners();
  }

  void sortBooksPublicationYear() {
    _booksSorting.sort((a, b) => a.publicationYear.compareTo(b.publicationYear));
    notifyListeners();
  }
}
