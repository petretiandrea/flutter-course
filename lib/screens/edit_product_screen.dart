import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/product.dart';
import 'package:flutter_course_1/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product.empty();
  var _isInit = false;

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(_updateImageUrl);
    _isInit = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  void _updateImageUrl() {
    // update the image preview when the focus of edittext url change
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    // Navigator.of(context).pop();
    if (_form.currentState.validate()) {
      _form.currentState.save();
      Provider.of<ProductsProvider>(context, listen: false)
          .addOrUpdateProduct(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  String Function(String) _emptyValidator(String message) {
    return (String value) => value.isEmpty ? message : null;
  }

  String Function(String) _priceValidator(String message) {
    return (String value) {
      final empty = _emptyValidator(message)(value);
      if (empty != null) return empty;
      if (double.tryParse(value.trim()) == null) return 'Invalid Number';
      if (double.parse(value.trim()) <= 0)
        return 'Insert a value greather than 0';
      return null;
    };
  }

  String Function(String) _descriptionValidator() {
    return (String value) {
      if (_emptyValidator('Please enter a description') != null) {
        if (value.length < 10) {
          return 'Please provide a description more longer';
        }
      }
      return null;
    };
  }

  final _imageUrlRegex = r'(https?:\/\/.*\.(?:png|jpg))';
  String Function(String) _imageUrlValidator(String message) {
    return (String value) {
      final empty = _emptyValidator(message)(value);
      if (empty != null) return empty;

      if (RegExp(_imageUrlRegex, caseSensitive: false).firstMatch(value) ==
          null) return 'Invalid image url';

      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                initialValue: _editedProduct.title,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: _emptyValidator('Please provide a value'),
                onSaved: (value) =>
                    _editedProduct = _editedProduct.copyWith(title: value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                initialValue: _editedProduct.price.toString(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: _priceValidator('Please provide a price'),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                onSaved: (value) => _editedProduct =
                    _editedProduct.copyWith(price: double.parse(value)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                initialValue: _editedProduct.description.toString(),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: _descriptionValidator(),
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_imageUrlFocusNode),
                onSaved: (value) => _editedProduct =
                    _editedProduct.copyWith(description: value),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      validator: _imageUrlValidator('Provide valid URL'),
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) => _editedProduct =
                          _editedProduct.copyWith(imageUrl: value),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
