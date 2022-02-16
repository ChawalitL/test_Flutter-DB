import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_db/provider_t.dart';
import 'package:flutter_db/screen/screen.dart';
import 'package:flutter_db/tran.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  __HomepageState createState() => __HomepageState();
}

class __HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TranProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test LocalDB'),
          actions: [
            IconButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                icon: Icon(Icons.exit_to_app)),
          ],
        ),
        body: Consumer(builder: (context, TranProvider provider, child) {
          var count = provider.transactions.length;
          if (count <= 0) {
            return const Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 34),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Card(
                    child: ListTile(
                      title: Text(data.name.toString()),
                      subtitle: Text(DateFormat("d/M/y").format(data.date)),
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text(data.price.toString()),
                        ),
                      ),
                    ),
                  );
                });
          }
        }));
  }
}
