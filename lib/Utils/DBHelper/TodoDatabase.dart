import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase
{

  static TodoDatabase todoDatabase = TodoDatabase._();

  TodoDatabase._();

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
    String path = join(directory.path,'tododata.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, category TEXT)";
        db.execute(query);
      },
    );
  }

  void InsertData({required String task, required String category}) async
  {
    database = await CheckDatabase();

    database!.insert(
        'todo',
        {
          'task' : task,
          'category' : category
        }
    );
  }

  Future<List<Map>> ReadData() async
  {
    database = await CheckDatabase();

    String query = "SELECT * FROM todo";

    List<Map> DataList = await database!.rawQuery(query);

    return DataList;
  }

  void UpadateData({required String task, required String category, required int id}) async
  {
    database = await CheckDatabase();

    database!.update(
      'todo',
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

    database!.delete('todo',where: "id = ?",whereArgs: [id]);
  }
}