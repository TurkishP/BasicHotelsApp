import 'package:flutter/material.dart';
import 'model/products_repository.dart';
import 'model/product.dart';

//Set<int> saved = new Set<int>();

class FavoritePage extends StatefulWidget {
  final List<Product> products2 = new List<Product>();
  final List<Product> products = ProductsRepository.loadProducts(Category.all);
  Set<int> saved = new Set<int>();
  bool firstTime = true;

  FavoritePage({
    Key key,
    @required this.saved,
  }) : super(key: key);

  @override
  FavoritePageState createState() {
    return FavoritePageState();
  }
}

class FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    //this creates a new products list that are favorited
    if (widget.firstTime)
      for (int x = 0; x < widget.products.length; x++) {
        if (widget.saved.contains(widget.products[x].id)) {
          widget.products2.add(widget.products[x]);
        }
        widget.firstTime = false;
      }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(widget.saved);
            },
          ),
          centerTitle: true,
          title: Text('Favorite Hotels'),
        ),
        body: ListView.builder(
          itemCount: widget.products2.length,
          itemBuilder: (context, index) {
            final product = widget.products2[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify Widgets.
              key: Key(product.name),
              // We also need to provide a function that tells our app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from our data source.
                setState(() {
                  widget.saved.remove(widget.products2[index].id);
                  widget.products2.removeAt(index);
                  print(widget.saved);
                  print(widget.products2);
                });

                // Then show a snackbar!
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("$product dismissed")));
              },
              background: Container(color: Colors.red),
              child: ListTile(title: Text('${widget.products2[index].name}')),
            );
          },
        ),
      ),
    );
  }
}
