import 'package:flutter/material.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'package:charts_flutter/flutter.dart' as charts;

Set<int> saved = new Set<int>();

class DetailPage extends StatelessWidget {
  Product product;
  String phoneNum;
  String location;
  int price;
  String name;
  int productId;
  final List<charts.Series> seriesList;

  DetailPage({Key key, this.productId, this.seriesList}) : super(key: key);

  static List<Product> products = ProductsRepository.loadProducts(Category.all);

//  Product product = products.singleWhere((products) => products[id] == ${this.productId}, orElse: () => null);
//this.productId,
//this.phoneNum,
//this.location,
//this.name,
//this.price
  @override
  Widget build(BuildContext context) {
    print("this is first product${products[productId]}");
    print(productId);
    Widget titleSection = Container(
      padding: const EdgeInsets.fromLTRB(24, 13, 24, 15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(products[productId].price,
                          (index) => _buildStar(context, index),
                          growable: false)),
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(children: [
                    SizedBox(width: 4),
                    Text(
                      products[productId].name,
                      style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      maxLines: 1,
                    ),
                  ]),
                ]),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.lightBlue[100],
                      size: 20,
                    ),
                  ]),
                  SizedBox(width: 10),
                  Flexible(
                      child: Text(
                    products[productId].location,
                    style:
                        TextStyle(color: Colors.blueAccent[100], fontSize: 14),
                  )),
                ]),
                SizedBox(height: 6),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(children: [
                    Icon(
                      Icons.phone_android,
                      color: Colors.lightBlue[100],
                      size: 20,
                    ),
                  ]),
                  SizedBox(width: 10),
                  Flexible(
                      child: Text(
                    products[productId].phoneNum,
                    style:
                        TextStyle(color: Colors.blueAccent[100], fontSize: 14),
                  )),
                ]),
              ],
            ),
          ),
//          FavoriteWidget(),
        ],
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(saved);
            },
          ),
          centerTitle: true,
          title: Text('Detail'),
        ),
        body: ListView(
          children: [
            Stack(
              children: <Widget>[
                Hero(
                  tag: 'mainImage${products[productId].assetName}',
                  child: Image.asset(
                    'assets/hotels/${products[productId].assetName}',
                    width: 600,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 20.0,
                  top: 20.0,
//                  child: FavoriteWidget(saved, product.id),
                  child: FavoriteWidget(products[productId].id),
                ),
              ],
            ),
            titleSection,
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Divider(height: 0, color: Colors.black45),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Text(
                "${products[productId].detail}",
                style: TextStyle(color: Colors.blueAccent[100], height: 1.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// #docregion FavoriteWidget
class FavoriteWidget extends StatefulWidget {
  Product product;
  bool favorited = false;
  Set<int> saved2;
  int productID;

  FavoriteWidget(
    this.productID,
  );

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
// #enddocregion FavoriteWidget

// #docregion _FavoriteWidgetState, _FavoriteWidgetState-fields, _FavoriteWidgetState-build
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // #enddocregion _FavoriteWidgetState-build

  // #enddocregion _FavoriteWidgetState-fields

  // #docregion _toggleFavorite
  void _toggleFavorite() {
    setState(() {
      if (saved.contains(widget.productID)) {
        widget.favorited = true;
      } else {
        widget.favorited = false;
      }

      if (widget.favorited) {
        widget.favorited = false;
        saved.remove(widget.productID);
      } else {
        saved.add(widget.productID);
        widget.favorited = true;
      }
    });
  }

  // #enddocregion _toggleFavorite

  // #docregion _FavoriteWidgetState-build
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (saved.contains(widget.productID)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
            color: Colors.red,
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }
// #docregion _FavoriteWidgetState-fields
}

Widget _buildStar(BuildContext context, int index) {
  Icon icon;

  icon = Icon(
    Icons.star,
    color: Colors.yellow,
    size: 30,
  );

  return icon;
}
