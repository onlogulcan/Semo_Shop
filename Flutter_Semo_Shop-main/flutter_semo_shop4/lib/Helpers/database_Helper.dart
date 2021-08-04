import 'dart:async';
import 'dart:io';
import 'package:flutter_semo_shop4/models/Urun.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String _urunTablo = "urun";
  String _columnID = "id";
  String _columnName = "name";
  String _columnPrice = "price";
  String _columnStock = "stock";
  String _columnBarcode = "barcode";
  String _columnPictureUrl = "pictureUrl";
  String _columnWeight = "weight";
  String _columnCategoryId = "categoryid";

  factory DatabaseHelper(){
    if(_databaseHelper == null ) {
      _databaseHelper = DatabaseHelper.internal();
      //print("DBHelper nulldi oluşturuldu");
      return _databaseHelper;
    }
    else{
      //print("DBHelper null değildi var olan kullanılacak");
      return _databaseHelper;
    }
  }
   DatabaseHelper.internal();


  Future<Database> _getDatabase() async {
    if(_database == null){
      //print("DB nulldi oluşturulacak");
      _database = await _initializeDatabase();

      return _database;
    }else{
      //print("DB null değildi var olan kullanılacak");
      return _database;
    }
  }

  _initializeDatabase() async{
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbPath = join(klasor.path,"urun.db");
    //print("DB Pathi:"+dbPath);
    var urunDB = openDatabase(dbPath,version: 1 , onCreate: _createDb);
    return urunDB;
  }

  Future<FutureOr<void>> _createDb(Database db, int version) async {
    //print("create db metotu calıstı tablo olusturulacak");
    await db.execute("CREATE TABLE $_urunTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnName TEXT, $_columnPrice INTEGER, $_columnCategoryId INTEGER,$_columnStock INTEGER, $_columnBarcode INTEGER,  $_columnWeight INTEGER,  $_columnPictureUrl TEXT )");
  }

  Future<int>Urunekle(Urun urun) async {
    var db  = await _getDatabase() ;
    var sonuc = await db.insert(_urunTablo, urun.dbyeYazmakIcinMapeDonustur(), nullColumnHack: "$_columnID");
  }
  Future<List<Map<String, dynamic>>>  tumUrunler() async{
    //print("**************");
    var db= await _getDatabase();
    var sonuc = await db.query(_urunTablo, orderBy: '$_columnID DESC');
    return sonuc;
  }
 }