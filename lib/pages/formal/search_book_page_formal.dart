import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/pages/abstract/search_book_page_abstract.dart';
import 'package:flutter_urshelf/pages/universal/book_notes_page.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/pages/formal/book_details_page_formal.dart';
import 'package:flutter_urshelf/utils/utils.dart';
import 'package:flutter_urshelf/widgets/BookCard.dart';
import 'package:flutter_urshelf/widgets/book_card_compact.dart';
import 'package:flutter_urshelf/widgets/book_card_minimalistic.dart';


class SearchBookPageNew extends StatefulWidget {

  @override
  _SearchBookStateNew createState() => _SearchBookStateNew();
}

class _SearchBookStateNew extends AbstractSearchBookState<SearchBookPageNew> {

  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(
      fontSize: 35.0,
      fontFamily: 'Butler',
      fontWeight: FontWeight.w400
    );
    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            forceElevated: true,
            backgroundColor: Colors.white,
            elevation: 1.0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 8.0,),
                  Text("Search for Books", style: textStyle,),
                  SizedBox(height: 16.0),
                  Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "What books did your read?",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none
                          ),
                          onChanged: (string) => (subject.add(string)),
                        ),
                      )
                  ),
                  SizedBox(height: 16.0,),
                ],
              ),
            ),
          ),
          isLoading? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()),): SliverToBoxAdapter(),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
            return BookCardCompact(items[index], onClick: (){
              Navigator.of(context).push(
                  FadeRoute(
                    builder: (BuildContext context) => BookDetailsPageFormal(items[index]),
                    settings: RouteSettings(name: '/book_detais_formal'),
                  ));
            },);
          },
          childCount: items.length)
          )
        ],
      ),
    );
  }
}

