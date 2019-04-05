import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'model/products_repository.dart';
import 'model/product.dart';

class MyPage extends StatefulWidget {
  final List<Product> products2 = new List<Product>();
  final List<Product> products = ProductsRepository.loadProducts(Category.all);
  Set<int> saved = new Set<int>();

  MyPage({
    Key key,
    @required this.saved,
  }) : super(key: key);

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  List<Container> _buildGridCards(BuildContext context) {
    //this creates a new products list that are favorited
    for (int x = 0; x < widget.products.length; x++) {
      if (widget.saved.contains(widget.products[x].id)) {
        widget.products2.add(widget.products[x]);
      }
    }

    if (widget.products2 == null || widget.products2.isEmpty) {
      return const <Container>[];
    }

    return widget.products2.map((product) {
      return Container(
//        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 18 / 18,
                  child: Hero(
                    tag: 'mainImage${product.assetName}',
                    child: Image.asset(
                      'assets/hotels/${product.assetName}',
                      fit: BoxFit.fitWidth,
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 160.0,
              left: 15.0,
              child: Text(
                product.name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: new Container(
          margin: const EdgeInsets.only(top: 50, left: 30.0, right: 30.0),
          child: CarouselSlider(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              height: 600.0,
              items: _buildGridCards(context)),
        ),
      ),
    );
  }
}
