import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/product.dart';
import 'package:sqflitedemo/screens/product_add.dart';
import 'package:sqflitedemo/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  Widget buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("Prod"),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {
                gotoDetail(this.products[position]);
              },
            ),
          );
        });
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        this.productCount = data.length;
      });
    });
  }

  void goToProductAdd() async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) if (result) getProducts();
  }

  void gotoDetail(Product product) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) if (result) getProducts();
  }
}
