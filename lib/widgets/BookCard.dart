// ignore: file_names
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_urshelf/model/Book.dart';


class BookCard extends StatefulWidget {


  const BookCard({
    required this.book,
    required this.onCardClick,
    required this.onStarClick,
  });

  final Book book;


  final VoidCallback onCardClick;
  final VoidCallback onStarClick;

  @override
  State<StatefulWidget> createState() => BookCardState();

}

class BookCardState extends State<BookCard> {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardClick,
      child: Card(
          child: Container(
            height: 200.0,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    widget.book.url != null?
                    Hero(
                      child: Image.network(widget.book.url),
                      tag: widget.book.id,
                    ):
                    Container(),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Padding(
                              child: Text(widget.book.title + "    " + widget.book.notes, maxLines: 10),
                              padding: const EdgeInsets.all(8.0),
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            child: IconButton(
                              icon: widget.book.starred? const Icon(Icons.star): const Icon(Icons.star_border),
                              color: Colors.black,
                              onPressed: widget.onStarClick,
                            ),
                            alignment: Alignment.topRight,
                          ),

                        ],
                      ),
                    ),

                  ],
                )
            ),
          )
      ),
    );
  }

}

