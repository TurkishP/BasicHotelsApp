import 'package:flutter/material.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RankingPage extends StatefulWidget {
  Set<int> saved = new Set<int>();
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  RankingPage({Key key, this.saved}) : super(key: key);

  @override
  RankingPageState createState() => new RankingPageState();
}

class HotelCount {
  final String type;
  final int count;

  HotelCount(this.type, this.count);
}

class RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    var data = [
      new HotelCount('Favorite', widget.saved.length),
      new HotelCount('All', widget.products.length),
    ];

    var series = [
      new charts.Series(
        id: "ranks",
        domainFn: (HotelCount hoteldata, _) => hoteldata.type,
        measureFn: (HotelCount hoteldata, _) => hoteldata.count,
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text('Ranking Page'),
        ),
        body: Container(
          child: chartWidget,
        ),
      ),
    );
  }
}
