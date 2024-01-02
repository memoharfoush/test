// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/jasonModel/userStu.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'quizy line');
    Database mydb1 = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return mydb1;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onuuuu==========");
  }

  Future<void> _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE "user"(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT, s_phone TEXT, rolee_id INTEGER ,FOREIGN KEY (rolee_id) REFERENCES rolle(rolle_id))');
    await db.execute(
        'CREATE TABLE "rolle"(rolle_id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT)');
    await db.execute(
        'CREATE TABLE "question"(ques_id INTEGER PRIMARY KEY AUTOINCREMENT ,questext TEXT ,markques TEXT, quiz_id INTEGER ,FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id))');
    await db.execute(
        'CREATE TABLE "quiz"(quiz_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT )');
    await db.execute(
        'CREATE TABLE "option"(op_id INTEGER PRIMARY KEY AUTOINCREMENT , op_value TEXT ,correct_option TEXT , question_id INTEGER,FOREIGN KEY (question_id) REFERENCES question(ques_id))');
    await db.execute('''CREATE TABLE result (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    qui_id INTEGER NOT NULL,
    mark TEXT,
    duration TEXT,
    dateResult TEXT CURRENT_TIMESTAMP,
    student_answer TEXT,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (qui_id) REFERENCES quiz(quiz_id)
)''');

    print("onCreat DATABASE============================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.rawQuery(sql);
    return result;
  }

  readD(String question) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.query(question);
    return result;
  }

  readO(String option) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.query(option);
    return result;
  }

  // Future<int> saveUser(Map<String, dynamic> user) async {
  // Database db = await initDb();
  // return await db.insert("user", user);
  // }
  Future<dynamic> insertUser(
      String name, String email, String password, String s_phone) async {
    Database? mydb = await db;
    String sql = '''Insert INTO "user" ("name", "email", "password" ,"s_phone" )
    VALUES ('$name','$email' ,'$password','$s_phone' );
    ''';
    int result = await mydb!.rawInsert(sql);
    return result;
  }

  Future<bool> getUser(User user) async {
    Database? mydb1 = await db;
    var result = await mydb1!.query(
        'SELECT * FROM user where email = "${user.userEmail} AND password="${user.userPassword}"');
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  insertQuiz(String sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawInsert(sql);
    return result;
  }

  insertQues(String question, Map<String, Object?> values) async {
    Database? mydb = await db;
    int result = await mydb!.insert(question, values);
    return result;
  }

  insertO(String option, Map<String, Object?> values) async {
    Database? mydb = await db;
    int result = await mydb!.insert(option, values);
    return result;
  }

  updateQuiz(String sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawUpdate(sql);
    return result;
  }

  updateQues(String table, Map<String, Object?> values, String? mywhere) async {
    Database? mydb = await db;
    int result = await mydb!.update(table, values, where: mywhere);
    return result;
  }

  updateO(String table, Map<String, Object?> values, String? mywhere) async {
    Database? mydb = await db;
    int result = await mydb!.update(table, values, where: mywhere);
    return result;
  }

  deletetQuiz(String sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawDelete(sql);
    return result;
  }

  deletetQu(String table, String? mywhere) async {
    Database? mydb = await db;
    int result = await mydb!.delete(table, where: mywhere);
    return result;
  }

  deletetO(String table, String? mywhere) async {
    Database? mydb = await db;
    int result = await mydb!.delete(table, where: mywhere);
    return result;
  }

  read(String user) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.query(user);
    return result;
  }

  insert(String User, Map<String, Object?> user) async {
    Database? mydb = await db;
    int result = await mydb!.insert(User, user);
    return result;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'quizy_line');
    await deleteDatabase(path);
  }
}
