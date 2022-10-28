import 'package:flutter/material.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/pages/universal/book_notes_page.dart';
import 'package:flutter_urshelf/utils/utils.dart';
import 'package:flutter_urshelf/widgets/BookCard.dart';


class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionPageState();

}


class _CollectionPageState extends State<CollectionPage> {


  // ignore: deprecated_member_use
  List<Book> _items = [];

  bool _isLoading = false;


  @override
  void initState() {
    super.initState();

    Repository.get().getFavoriteBooks()
      .then((books) {
      setState(() {
        _items = books;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            _isLoading? CircularProgressIndicator(): Container(),
             ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(
                  book: _items[index],
                  onCardClick: (){
                    Navigator.of(context).push(
                        FadeRoute(
                          builder: (BuildContext context) => BookNotesPage(_items[index]),
                          settings: RouteSettings(name: '/notes'),
                        ));
                  },
                  onStarClick: (){
                    setState(() {
                      _items[index].starred = !_items[index].starred;
                    });
                    Repository.get().updateBook(_items[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),

    );
  }

}