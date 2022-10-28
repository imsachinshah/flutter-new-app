import 'package:flutter/material.dart';
import 'package:flutter_urshelf/data/repository.dart';
import 'package:flutter_urshelf/model/Book.dart';
import 'package:flutter_urshelf/pages/abstract/stamp_collection_page_abstract.dart';
import 'package:flutter_urshelf/widgets/book_card_compact.dart';


class StampCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StampCollectionPageState();

}


class _StampCollectionPageState extends StampCollectionPageAbstractState<StampCollectionPage> {

  @override
  Widget build(BuildContext context) {

    Matrix4 transform = Matrix4.skewX(10.0);
    transform.translate(-100.0);
    return Scaffold(
      appBar: AppBar(
        title: Text("Stamp Collection"),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index){
        return BookCardCompact(items[index], onClick: (){},);
      },
      itemCount: items.length,
      ),
    );
  }


}