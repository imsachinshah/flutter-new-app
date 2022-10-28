import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/model/Book.dart';


class AppState {


  AppState({
    required this.readBooks
  });

  final List<Book> readBooks;



  static AppState initState() {
    return new AppState(readBooks: []);
  }

}