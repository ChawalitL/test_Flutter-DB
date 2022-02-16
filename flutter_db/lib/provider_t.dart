import 'package:flutter/foundation.dart';
import 'package:flutter_db/database/transaction_db.dart';
import 'package:flutter_db/tran.dart';

class TranProvider with ChangeNotifier {
  //name, price, date
    List<Transactions> transactions = [];

    List<Transactions> getTransaction() {
      return transactions;
    }

    void initData() async {
      var db = TransactionDB(dbName: "transactions.db");
      transactions = await db.loadAlldata();
      notifyListeners();
    }

    void addTransaction(Transactions statement) async {
      //var db = await TransactionDB(dbName: "transaction.db").openDatabase();
      //print(db);

      //บันทึกลง db
      var db = TransactionDB(dbName: "transactions.db");
      await db.InsertData(statement);

      transactions = await db.loadAlldata();

      // บอก Cotumer ให้อัพเดท;
      notifyListeners();
    }
}
