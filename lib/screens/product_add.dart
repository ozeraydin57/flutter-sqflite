import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni ürün ekle"),
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[buildNameField(), buildDescriptionField(), buildUnitPriceField(), buildSaveButton()],
          ),
        ));
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(hintText: "Ürün adı"),
      controller: txtName,
    );
  }
  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(hintText: "Ürün açıklaması"),
      controller: txtDescription,
    );
  }
  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(hintText: "Ürün fiyatı"),
      controller: txtUnitPrice,
    );
  }
  buildSaveButton() {
    return FlatButton(
      child: Text("Kaydet"),
      onPressed: () {
        addProduct();
      },
    );
  }

  void addProduct() async {
    var result = await dbHelper.add(Product(name: txtName.text, description: txtDescription.text, unitPrice: double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, true);
  }
}
