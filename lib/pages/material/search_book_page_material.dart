import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/pages/abstract/search_book_page_abstract.dart';
import 'package:flutter_urshelf/pages/universal/book_notes_page.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/utils/utils.dart';
import 'package:flutter_urshelf/widgets/BookCard.dart';
import 'package:flutter_urshelf/widgets/book_card_compact.dart';
import 'package:flutter_urshelf/widgets/book_card_minimalistic.dart';


class SearchBookPage extends StatefulWidget {
  const SearchBookPage({Key? key}) : super(key: key);


  @override
  _SearchBookState createState() => _SearchBookState();
}

class _SearchBookState extends AbstractSearchBookState<SearchBookPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Book Search"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: 'Choose a book',
              ),
              onChanged: (string) => (subject.add(string)),
            ),
            isLoading? const CircularProgressIndicator(): Container(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return BookCard(
                    book: items[index],
                    onCardClick: (){
                      Navigator.of(context).push(
                          FadeRoute(
                            builder: (BuildContext context) => BookNotesPage(items[index]),
                            settings: const RouteSettings(name: '/notes'),
                          ));
                    },
                    onStarClick: (){
                      setState(() {
                        items[index].starred = !items[index].starred;
                      });
                      Repository.get().updateBook(items[index]);
                    },
                  );
               //  return new BookCardMinimalistic(_items[index]);
                },
              ),
            ),
        /*  new Expanded(
            child: new GridView.builder(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.65), itemBuilder: (BuildContext context, int index) {
              return new BookCardMinimalistic(_items[index]);
            }, itemCount: _items.length,),
          )*/
          ],
        ),
      ),
    );
  }
}

