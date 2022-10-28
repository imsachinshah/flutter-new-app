import 'package:flutter/material.dart';
import 'package:flutter_urshelf/pages/universal/collection_page.dart';
import 'package:flutter_urshelf/pages/formal/stamp_collection_page_formal.dart';
import 'package:flutter_urshelf/pages/home_page.dart';
import 'package:flutter_urshelf/pages/material/search_book_page_material.dart';
import 'package:flutter_urshelf/pages/formal/search_book_page_formal.dart';
import 'package:flutter_urshelf/pages/material/stamp_collection_page_material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_urshelf/redux/app_state.dart';
import 'package:flutter_urshelf/redux/reducers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store =
      Store(readBookReducer, initialState: AppState.initState());

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Book search',
        theme: ThemeData(
          primaryColor: const Color(0xFF0F2533),
        ),
        routes: {
          '/': (BuildContext context) => HomePage(),
          '/search_material': (BuildContext context) => const SearchBookPage(),
          '/search_formal': (BuildContext context) => SearchBookPageNew(),
          '/collection': (BuildContext context) => CollectionPage(),
          '/stamp_collection_material': (BuildContext context) =>
              StampCollectionPage(),
          '/stamp_collection_formal': (BuildContext context) =>
              StampCollectionFormalPage(),
        },
      ),
    );
  }
}
