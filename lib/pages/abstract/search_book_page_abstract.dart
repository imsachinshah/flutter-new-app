import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/pages/universal/book_notes_page.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/utils/utils.dart';
import 'package:flutter_urshelf/widgets/BookCard.dart';
import 'package:flutter_urshelf/widgets/book_card_compact.dart';
import 'package:flutter_urshelf/widgets/book_card_minimalistic.dart';


abstract class AbstractSearchBookState<T extends StatefulWidget> extends State<T> {
  // ignore: deprecated_member_use
  List<Book> items = List();

  final subject = PublishSubject<String>();

  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  void _textChanged(String text) {
    if(text.isEmpty) {
      setState((){isLoading = false;});
      _clearList();
      return;
    }
    setState((){isLoading = true;});
    _clearList();
    Repository.get().getBooks(text)
    .then((books){
      setState(() {
        isLoading = false;
        if(books.isOk()) {
          items = books.body;
        } else {
          // ignore: deprecated_member_use
          scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Something went wrong, check your internet connection")));
        }
      });
    });
  }


  void _clearList() {
    setState(() {
      items.clear();
    });
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subject.stream.debounceTime(Duration(milliseconds: 600)).listen(_textChanged);
  }

}

