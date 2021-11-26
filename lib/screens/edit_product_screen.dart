import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final form = GlobalKey<FormState>();
  var testProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  var _inInit = true;
  var _initValue = {
    'title': "",
    'description': "",
    'price': "",
    'imageUrl': '',
  };
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_inInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        testProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        print("trong didi");
        print(testProduct.id);
        _initValue = {
          'title': testProduct.title!,
          'description': testProduct.description!,
          'price': testProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = testProduct.imageUrl!;
      }
    }
    _inInit = false;
    super.didChangeDependencies();
  }

  void saveForm() {
    final isValid = form.currentState!.validate();
    if (!isValid) {
      return;
    }
    form.currentState!.save();
    if (testProduct.id == null) {
      Provider.of<Products>(context, listen: false).addProduct(testProduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(testProduct.id!, testProduct);
    }

    ///print("Test Product!!!!!");
    ///print(testProduct.id);
    //print(testProduct.title);
    /// print(testProduct.imageUrl);
    var he = ModalRoute.of(context)!.settings.arguments as String;
    //  print(he);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            onPressed: saveForm,
            icon: Icon(
              Icons.save,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText2,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Chưa nhập tên sản phẩm";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  testProduct = Product(
                    title: val,
                    price: testProduct.price,
                    description: testProduct.description,
                    imageUrl: testProduct.imageUrl,
                    id: testProduct.id,
                    isFavorite: testProduct.isFavorite,
                  );

                  ///print("val1");
                  // print(testProduct.id);
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.bodyText2,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Chưa nhập giá sản phẩm";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  testProduct = Product(
                    title: testProduct.title,
                    price: double.parse(val!),
                    description: testProduct.description,
                    imageUrl: testProduct.imageUrl,
                    id: testProduct.id,
                    isFavorite: testProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['description'],
                decoration: InputDecoration(labelText: 'Decription'),
                //   maxLines: 3,
                keyboardType: TextInputType.multiline,
                style: Theme.of(context).textTheme.bodyText2,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Chưa nhập mô tả sản phẩm";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  testProduct = Product(
                    title: testProduct.title,
                    price: testProduct.price,
                    description: val!,
                    imageUrl: testProduct.imageUrl,
                    id: testProduct.id,
                    isFavorite: testProduct.isFavorite,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 20,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text("No image")
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      //.    initialValue: _initValue['imageUrl'],
                      decoration: InputDecoration(labelText: "Image URL"),
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Chưa nhập link ảnh của sản phẩm";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        //    print("val save");
                        //  print(val);
                        testProduct = Product(
                          title: testProduct.title,
                          price: testProduct.price,
                          description: testProduct.description,
                          imageUrl: val,
                          id: testProduct.id,
                          isFavorite: testProduct.isFavorite,
                        );
                      },
                      onFieldSubmitted: (_) {
                        saveForm();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
