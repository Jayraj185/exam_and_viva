import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DoneDatabase
{

  static DoneDatabase doneDatabase = DoneDatabase._();

  DoneDatabase._();

  Database? database;

  Future<Database?> CheckDatabase() async
  {
    if(database != null)
    {
      return database;
    }
    else
    {
      return await CreateDatabase();
    }
  }


  Future<Database> CreateDatabase() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'donedata.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE done (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, category TEXT)";
        db.execute(query);
      },
    );
  }

  void InsertData({required String task, required String category}) async
  {
    database = await CheckDatabase();

    database!.insert(
        'done',
        {
          'task' : task,
          'category' : category
        }
    );
  }

  Future<List<Map>> ReadData() async
  {
    database = await CheckDatabase();

    String query = "SELECT * FROM done";

    List<Map> DataList = await database!.rawQuery(query);

    return DataList;
  }

  void UpadateData({required String task, required String category, required int id}) async
  {
    database = await CheckDatabase();

    database!.update(
        'done',
        {
          'task' : task,
          'category' : category
        },
        where: "id = ?",
        whereArgs: [id]
    );
  }

  void DeleteData({required int id}) async
  {
    database = await CheckDatabase();

    database!.delete('done',where: "id = ?",whereArgs: [id]);
  }
}