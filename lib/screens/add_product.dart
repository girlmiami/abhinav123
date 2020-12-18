import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/addproduct';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File _storedImage;
  _takePicture() async {
    // final picker = ImagePicker();
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _storedImage = imageFile;
    });
  }

  final _priceFocusNode = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add / Edit product',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber[900],
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: _storedImage != null
                    ? Image.file(
                        _storedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Text('Add Product Image'),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 6,
              ),
              RaisedButton.icon(
                onPressed: _takePicture,
                icon: Icon(Icons.add),
                label: Text('Add Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
