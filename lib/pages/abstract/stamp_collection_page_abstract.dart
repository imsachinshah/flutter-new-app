import 'package:flutter/material.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/widgets/book_card_compact.dart';


abstract class StampCollectionPageAbstractState<T extends StatefulWidget> extends State<T> {


  // ignore: deprecated_member_use
  List<Book> items = List();


  @override
  void initState() {
    super.initState();
    Repository.get().getFavoriteBooks()
        .then((books) {
      setState(() {
        items = books;
      });
    });
  }


}