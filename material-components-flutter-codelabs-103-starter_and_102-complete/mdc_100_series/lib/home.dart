// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'detail.dart';
import 'favorite.dart';
import 'ranking.dart';
import 'mypage.dart';
//import 'package:flutter_rating/flutter_rating.dart';

class HomePage extends StatelessWidget {
  bool animate = false;
  int productId;
  Set<int> saved = new Set<int>();

//  Product product = Product();
  // TODO: Add a variable for Category (104)
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }
    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Hero(
                tag: 'mainImage${product.assetName}',
                child: Image.asset(
                  'assets/hotels/${product.assetName}',
                  fit: BoxFit.fitWidth,
                  height: 150,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 7, 0.0),
                child: Column(
//                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(product.price,
                              (index) => _buildStar(context, index),
                              growable: false)),
                    ),
                    SizedBox(height: 2),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Row(children: [
                        SizedBox(width: 17),
                        Text(
                          product.name,
                          style: TextStyle(color: Colors.black, fontSize: 11),
                          maxLines: 1,
                        ),
                      ]),
                    ]),
                    SizedBox(height: 3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.lightBlue[100],
                              size: 15,
                            ),
                          ]),
                          SizedBox(width: 4),
                          Flexible(
                              child: Text(
                            product.location,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 9),
                          )),
                        ]),
                    SizedBox(width: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 100, height: 10),
                          Container(
                            height: 15,
                            width: 38,
                            child: ButtonTheme.bar(
                              child: FlatButton(
                                child: const Text(
                                  'more',
                                  style: TextStyle(fontSize: 9),
                                ),
                                onPressed: () {
                                  _navigateAndReceiveData(context, product.id);
                                },
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  _navigateAndReceiveData(BuildContext context, int productid) async {
//    _navigateAndReceiveData(BuildContext context, Product product, Set<int> saved) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(productId: productid),
//        builder: (context) => DetailPage(product: product, saved: saved),
      ),
    );
//    if (result) {
//      saved.remove(result);
//    } else {
//      saved.add(result);
//    }
    saved = result;
    print(saved);
    print(result);
  }

  _navigateToFavorite(BuildContext context, Set<int> saved) async {
//    _navigateAndReceiveData(BuildContext context, Product product, Set<int> saved) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritePage(saved: saved),
//        builder: (context) => DetailPage(product: product, saved: saved),
      ),
    );
//    if (result) {
//      saved.remove(result);
//    } else {
//      saved.add(result);
//    }
    saved = result;
    print(saved);
    print(result);
  }

  _navigateToRanking(BuildContext context, Set<int> saved) {
//    _navigateAndReceiveData(BuildContext context, Product product, Set<int> saved) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RankingPage(saved: saved),
//        builder: (context) => DetailPage(product: product, saved: saved),
      ),
    );
  }

  _navigateToMyPage(BuildContext context, Set<int> saved) {
//    _navigateAndReceiveData(BuildContext context, Product product, Set<int> saved) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyPage(saved: saved),
//        builder: (context) => DetailPage(product: product, saved: saved),
      ),
    );
  }

  Widget _buildStar(BuildContext context, int index) {
    Icon icon;

    icon = Icon(
      Icons.star,
      color: Colors.yellow,
      size: 12,
    );

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)

    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Pages',
                  style: TextStyle(color: Colors.white70, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
//              margin: EdgeInsets.fromLTRB(0, , right, bottom),
              padding: EdgeInsets.fromLTRB(30, 110, 0, 0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                title: Text("Home",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                leading: Icon(
                  // Add the lines from here...
                  Icons.home,
                  color: Colors.lightBlue[100],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                title: Text("Search",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                leading: Icon(
                  // Add the lines from here...
                  Icons.search,
                  color: Colors.lightBlue[100],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                title: Text("Favorite Hotel",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                leading: Icon(
                  // Add the lines from here...
                  Icons.location_city,
                  color: Colors.lightBlue[100],
                ),
                onTap: () {
                  _navigateToFavorite(context, saved);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                title: Text("Ranking",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                leading: Icon(
                  // Add the lines from here...
                  Icons.insert_chart,
                  color: Colors.lightBlue[100],
                ),
                onTap: () {
                  _navigateToRanking(context, saved);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                title: Text("My Page",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                leading: Icon(
                  // Add the lines from here...
                  Icons.person,
                  color: Colors.lightBlue[100],
                ),
                onTap: () {
                  _navigateToMyPage(context, saved);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                title: Text("Login Page",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                leading: Icon(
                  // Add the lines from here...
                  Icons.settings,
                  color: Colors.lightBlue[100],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or 3 columns in
            // landscape mode.
            padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            // Generate 100 Widgets that display their index in the List
            childAspectRatio: 8.3 / 9.0,
            children: _buildGridCards(context),
          );
        },
      ),
    );
  }
}
