import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/newproduct.dart';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth;
  double screenHeight;
  List _productList;
  String _titlecenter = "Loading...";

  bool _isgridview = true;
  final df = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _loadproducts();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[900], Colors.purple[800]]),
            ),
          ),
          title: Text(
            "My Shop",
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                child: _productList == null
                    ? Flexible(
                        child: Center(
                            child: Container(
                          height: 20.0,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(_titlecenter,
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Colors.blue))
                            ],
                            isRepeatingAnimation: true,
                          ),
                        )),
                      )
                    : Flexible(
                        child: Center(
                            child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (screenWidth / screenHeight) / 0.75, //0.61,
                                children:
                                    List.generate(_productList.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: (_isgridview == true)
                                                  ? screenHeight / 5
                                                  : screenHeight / 2,
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://hubbuddies.com/270607/myshop/images/product/${_productList[index]['prid']}.png")),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                right: 8.0),
                                            child: Text(
                                              checkProductName(
                                                  _productList[index]
                                                      ['prname']),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              checkProductName(
                                                  _productList[index]
                                                      ['prtype']),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                right: 8.0),
                                            child: Row(
                                              children: [
                                                Text("RM ",
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                Text(
                                                  _productList[index]
                                                      ['prprice'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.amber[800],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Text("Qty:"),
                                                Text(
                                                  checkProductName(
                                                      _productList[index]
                                                          ['prqty']),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  df.format(DateTime.parse(
                                                      _productList[index]
                                                          ['datecreated'])),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }))))),
          ],
        ),
      ),
      floatingActionButton: Container(
          width: 220,
          child: FloatingActionButton(
            backgroundColor: Colors.indigo[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (content) => NewProductScreen()));
            },
            child: Text("Sell Something NOW", style: TextStyle(fontSize: 18)),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _loadproducts() {
    http.post(
        Uri.parse("https://hubbuddies.com/270607/myshop/php/loadProducts.php"),
        body: {}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No Product";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        setState(() {
          print(_productList);
        });
      }
    });
  }

  String checkProductName(String productName) {
    if (productName.length < 15) {
      return productName;
    } else {
      return productName.substring(0, 15) + "...";
    }
  }
}
