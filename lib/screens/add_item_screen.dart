import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/cart.dart';
import '../models/boxes.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print('Form validated');
    } else {
      print('Form not validated');
      return;
    }
  }

  late List<List<String>> items = [];
  late String title;
  late String description;
  bool? _isFirstItemSelected = false;
  bool? _isSecondItemSelected = false;
  String titleItem1 = "First Item";
  String titleItem2 = "Second Item";
  String descItem1 = "Price : \$10 ";
  String descItem2 = "Price : \$15 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add item'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: Text(titleItem1),
                  subtitle: Text(descItem1),
                  value: _isFirstItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFirstItemSelected = value;
                    });
                  },
                  secondary: const FlutterLogo(
                    size: 54.0,
                  ),
                ),
                CheckboxListTile(
                  title: const Text('Second item'),
                  subtitle: Text('Price : \$15 '),
                  value: _isSecondItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSecondItemSelected = value;
                    });
                  },
                  secondary: const FlutterLogo(
                    size: 54.0,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      validated();
                    },
                    child: Text('Add todo'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Item> todobox = Hive.box<Item>(HiveBoxes.cart);
    if (_isFirstItemSelected == true) {
      items.add([titleItem1, descItem1]);
      _isFirstItemSelected = false;
    }
    if (_isSecondItemSelected == true) {
      items.add([titleItem2, descItem2]);
      _isSecondItemSelected = false;
    }
    items.forEach((item) {
      todobox.add(Item(title: item[0], description: item[1]));
    });
    SnackBar snackBar = SnackBar(content: Text("Add item to cart"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(todobox);
  }
}
