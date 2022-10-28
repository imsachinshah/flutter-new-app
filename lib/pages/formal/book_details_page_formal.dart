import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/pages/abstract/book_details_page_abstract.dart';



class BookDetailsPageFormal extends StatefulWidget {


  BookDetailsPageFormal(this.book);

  final Book book;

  @override
  State<StatefulWidget> createState() => _BookDetailsPageFormalState();

}


class _BookDetailsPageFormalState extends AbstractBookDetailsPageState<BookDetailsPageFormal> {

  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Stamp Collection"),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Hero(
                    tag: widget.book.id,
                    child: Image.network(widget.book.url, fit: BoxFit.cover,),
                  ),
                ),
              ),
              SizedBox(height: 16.0,),
              Text(widget.book.title, style: const TextStyle(fontSize: 24.0, fontFamily: "CrimsonText"),),
              SizedBox(height: 8.0,),
              Text("${widget.book.author} - Sience Ficition", style: const TextStyle(fontSize: 16.0, fontFamily: "CrimsonText", fontWeight: FontWeight.w400),),
              Divider(height: 32.0, color: Colors.black38,),
              Row(
                children: <Widget>[
                  Expanded(
                      child: IconButtonText(
                        onClick: (){},
                        iconData: Icons.store,
                        text: "Search store",
                        selected: false,
                      ),
                  ),
                  Expanded(
                    child: IconButtonText(
                      onClick: (){
                        print("The id is: ${widget.book.id}");
                        Clipboard.setData(ClipboardData(text: widget.book.id));
                        // ignore: deprecated_member_use
                        key.currentState!.showSnackBar(SnackBar(content: Text("Copied: \"${widget.book.id}\" to clipboard")));
                      },
                      iconData: Icons.bookmark,
                      text: "Bookmark",
                      selected: false,
                    ),
                  ),
                  Expanded(
                    child: IconButtonText(
                      onClick: (){
                        setState(() {
                          widget.book.starred = !widget.book.starred;
                        });
                        Repository.get().updateBook(widget.book);
                      },
                      iconData: widget.book.starred? Icons.remove : Icons.add,
                      text: widget.book.starred? "Remove"  :"Mark as read",
                      selected: widget.book.starred,
                    ),
                  ),
                ],
              ),
              Divider(height: 32.0, color: Colors.black38,),
              Text("Description", style: const TextStyle(fontSize: 20.0, fontFamily: "CrimsonText"),),
              SizedBox(height: 8.0,),
              Text(widget.book.description, style: const TextStyle(fontSize: 16.0),),
            ],
          ),
        ),
      ),
    );
  }

}


// ignore: must_be_immutable
class IconButtonText extends StatelessWidget {



  IconButtonText({required this.onClick, required this.iconData, required this.text, required this.selected});


  final VoidCallback onClick;

  final IconData iconData;
  final String text;

  bool selected = false;

  final Color selectedColor = Color(0xff283593);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onClick,
      child: Column(
        children: <Widget>[
          Icon(iconData, color: selected? selectedColor: Colors.black,),
          Text(text, style: TextStyle(color: selected? selectedColor: Colors.black),)
        ],
      ),
    );
  }

}