import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/cart.dart';
import '../models/boxes.dart';
import 'add_item_screen.dart';

class ItemListScreen extends StatefulWidget {
  final String title;
  const ItemListScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _openBox();
  // }

  // Future _openBox() async {
  //   await Hive.openBox<Item>(HiveBoxes.cart);
  //   return;
  // }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Hive.openBox<Item>(HiveBoxes.cart);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Item>(HiveBoxes.cart).listenable(),
        builder: (context, Box<Item> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('Items is Empty'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Item? res = box.getAt(index);
              return Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  res!.delete();
                },
                child: ListTile(
                  title: Text(res!.title),
                  subtitle: Text(res.description),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItem()))
        },
      ),
    );
  }
}
