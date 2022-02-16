import 'package:flutter/material.dart';
import 'package:flutter_db/provider_t.dart';
import 'package:flutter_db/screen/screen.dart';
import 'screen/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TranProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, 
    child: Scaffold(
      backgroundColor: Colors.blue,
      body: TabBarView(
        children: [
          Homepage(),
          fscreen(),
        ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
          Tab(
            icon: Icon(Icons.list),
            text: "รายการทั้งหมด",
          ),
          Tab(
            icon: Icon(Icons.add),
            text: 'เพิ่มรายการ',
          )
        ]),
      )
    );
  }
}
