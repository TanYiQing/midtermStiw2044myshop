import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midtermstiw2044myshop/main.dart';

class NewProductScreen extends StatefulWidget {
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  TextEditingController _prnameController = new TextEditingController();
  TextEditingController _prtypeController = new TextEditingController();
  TextEditingController _prpriceController = new TextEditingController();
  TextEditingController _prqtyController = new TextEditingController();
  String pathAsset = "assets/images/addimg.png";
  String _prtype;
  File _image;
  int _categoryValue = 0;
  bool _enableOtherType = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (content) => MyApp()));
                setState(() {});
              }),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[900], Colors.purple[800]]),
            ),
          ),
          title: Text(
            "Add Item",
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _choosePhoto();
            },
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: _image == null
                            ? AssetImage("assets/images/additem.png")
                            : FileImage(_image))),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 8.0),
            child: Text("Product Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Container(
                height: 40,
                width: double.infinity,
                child: TextField(
                    controller: _prnameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    style: TextStyle(fontSize: 18))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
            child: Row(
              
              children: [
                Text("Product Type",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          groupValue: _categoryValue,
                          value: 0,
                          onChanged: _handleRadioButton,
                        ),
                        Text("Women's Clothing"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: _categoryValue,
                          value: 1,
                          onChanged: _handleRadioButton,
                        ),
                        Text("Men's Clothing"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: _categoryValue,
                          value: 2,
                          onChanged: _handleRadioButton,
                        ),
                        Text("Healthy and Beauty"),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          groupValue: _categoryValue,
                          value: 3,
                          onChanged: _handleRadioButton,
                        ),
                        Text("Mobile and Gadget"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: _categoryValue,
                          value: 4,
                          onChanged: _handleRadioButton,
                        ),
                        Text("Baby and Toy"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: _categoryValue,
                          value: 5,
                          onChanged: _handleRadioButton,
                        ),
                        Text("Watches"),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Radio(
                  groupValue: _categoryValue,
                  value: 6,
                  onChanged: _handleRadioButton,
                ),
                Text("Others"),
                SizedBox(width: 10),
                Container(
                    width: 250,
                    height: 30,
                    color: (_enableOtherType == true)
                        ? Colors.white
                        : Colors.grey[200],
                    child: TextField(
                        enabled: _enableOtherType,
                        controller: _prtypeController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text("RM  ", style: TextStyle(fontSize: 18)),
                          Container(
                              width: 150,
                              height: 30,
                              child: TextField(
                                  controller: _prpriceController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quantity",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          width: 150,
                          height: 30,
                          child: TextField(
                              controller: _prqtyController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              style: TextStyle(fontSize: 18))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 8.0, right: 8.0, bottom: 20),
            child: Center(
              child: Container(
                  height: 50,
                  width: 200,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.blue[900],
                    onPressed: () {
                      _publishProduct();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Item",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.add_business_rounded, color: Colors.white)
                        ]),
                  )),
            ),
          ),
        ],
      )),
    );
  }

  void _choosePhoto() {
    final snackBar = SnackBar(
        backgroundColor: Colors.grey[200],
        content: Container(
          height: 110,
          child: Column(
            children: [
              Text("Product Photo",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          _chooseRemove();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            Text(
                              "Remove",
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          _chooseGallery();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.image_rounded, color: Colors.purple),
                            Text(
                              "Gallery",
                              style: TextStyle(color: Colors.purple),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          _chooseCamera();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt_rounded, color: Colors.blue),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.blue),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.undo,
                            ),
                            Text(
                              "Undo",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleRadioButton(int value) {
    setState(() {
      _categoryValue = value;
      switch (_categoryValue) {
        case 0:
          _prtype = "Women's Clothing";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 1:
          _prtype = "Men's Clothing";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 2:
          _prtype = "Healthy and Beauty";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 3:
          _prtype = "Mobile and Gadget";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 4:
          _prtype = "Baby and Toy";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 5:
          _prtype = "Watches";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 6:
          _prtype = "Others";
          _enableOtherType = true;
          print(_enableOtherType);
          break;
        case 7:
          _prtype = "Home and Living";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 8:
          _prtype = "Home Appliances";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 9:
          _prtype = "Women's bag";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 10:
          _prtype = "Men's Bag and Wallet";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 11:
          _prtype = "Muslim Fashion";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
        case 12:
          _prtype = "Computer and Accessories";
          _enableOtherType = false;
          _prtypeController.text = "";
          break;
      }
    });
  }

  void _chooseRemove() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Photo"),
            content: Container(
              height: 25,
              child: Text("Are you confirm to delete photo?"),
            ),
            actions: [
              TextButton(
                  child: Text("Cancel", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }),
              TextButton(
                  child: Text("Ok", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      _image = null;
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }),
            ],
          );
        });
  }

  Future<void> _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
    _cropImage();
  }

  Future<void> _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Imgae Selected");
    }
    _cropImage();
  }

  Future<void> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).accentColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _publishProduct() {
    String prname = _prnameController.text.toString();
    String prtype = (_prtypeController.text == "")
        ? _prtype
        : _prtypeController.text.toString();
    String prprice = _prpriceController.text.toString();
    String prqty = _prqtyController.text.toString();
    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post(
        Uri.parse("https://hubbuddies.com/270607/myshop/php/newproduct.php"),
        body: {
          "prname": prname,
          "prtype": prtype,
          "prprice": prprice,
          "prqty": prqty,
          "encoded_string": base64Image,
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Item added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);

        setState(() {
          _prnameController.text = "";
          _prpriceController.text = "";
          _prqtyController.text = "";
          _prtypeController.text = "";
          _categoryValue = 0;
          _enableOtherType = false;
          _image = null;
        });
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Item add failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        return;
      }
    });
  }
}
