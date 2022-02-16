import 'package:flutter/material.dart';
import 'package:flutter_db/main.dart';
import 'package:flutter_db/provider_t.dart';
import 'package:flutter_db/screen/home.dart';
import 'package:flutter_db/tran.dart';
import 'package:provider/provider.dart';

class fscreen extends StatelessWidget {
  fscreen({Key? key}) : super(key: key);

  final fKey = GlobalKey<FormState>();
  //Controller
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: fKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: nameController,
                validator: (str) {
                  if (str!.isEmpty) {
                    return 'Please Enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                keyboardType: TextInputType.number,
                controller: priceController,
                validator: (str) {
                  if (str!.isEmpty) {
                    return 'Please Enter some price';
                  }
                  if (double.parse(str) <= 0) {
                    return 'ป้อนค่ามากกว่า 0';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (fKey.currentState!.validate()) {
                    var nameC = nameController.text;
                    var priceC = priceController.text;

                    //เตรียม ข้อมูล
                    Transactions statment = Transactions(
                        name: nameC,
                        price: double.parse(priceC),
                        date: DateTime.now());

                    //= Call Provider
                    var provider =
                        Provider.of<TranProvider>(context, listen: false);
                    provider.addTransaction(statment);

                    Navigator.push(context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) {
                      return MyHomePage();
                    }));
                  }
                },
                child: Text('Insert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
