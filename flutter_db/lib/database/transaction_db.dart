import 'package:flutter_db/provider_t.dart';
import 'package:flutter_db/tran.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //Crate DB
  String dbName;

  //ถ้ายังไม่ถูกสร้าง => สร้าง
  //ถ้าสร้างแล้ว => เปิด
  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    // หาตำแหน่งที่จัดเก็บข้อมูล
    var appDirectory = await getApplicationDocumentsDirectory();
    var dbLocation = join(appDirectory.path, dbName);
    // Create Db
    DatabaseFactory dbfactory = await databaseFactoryIo;
    Database db = await dbfactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    //ลง DB => Store
    //transaction.db => expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');

    //Json
    var keyId = store.add(db, {
      "name": statement.name,
      "price": statement.price,
      "date": statement.date.toIso8601String(),
    });
    db.close();
    return keyId;
  }

  Future<List<Transactions>> loadAlldata() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('expense');
    // เรียงลำดับจากใหม่ไป อิง Date  ,false
    // เรียงจากเก่า ,ture
    var snap = await store.find(db,finder: Finder(sortOrders: [SortOrder(Field.key,false)]));
    List<Transactions> snapItem = [];

    for (var i in snap) {
      var a = i["name"];
      var b = i["price"];
      var c = i["date"];
      snapItem.add(Transactions
      (
      name: a.toString(), 
      price: double.parse(b.toString()), 
      date: DateTime.parse(c.toString()))
      );
    }

    return snapItem;
  }
}
