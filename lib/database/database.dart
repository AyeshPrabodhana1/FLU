import 'package:med_reminder/models/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*

  Database Handler class

*/
class _DatabaseHandler {
  // Database details
  static final _dbName = 'med_reminder.db';
  static final _databaseVersion = 1;

  // Table details
  static final tableName = 'reminder';

  // Table Column details
  String _column_Id = '_id';
  String _column_medicineName = 'medicine_name';
  String _column_medicineType = 'medicine_type';
  String _column_medicineDosage = 'medicine_dosage';
  String _column_intervalDays = 'interval_days';
  String _column_intervalHours = 'interval_hours';
  String _column_startDate = 'start_date';
  String _column_startTime = 'start_time';

  // Make the class Singleton
  static final _DatabaseHandler _databaseHandler = _DatabaseHandler._internal();
  factory _DatabaseHandler() {
    return _databaseHandler;
  }
  _DatabaseHandler._internal();

  // Database object
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  // Open the database and create the table
  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($_column_Id INTEGER PRIMARY KEY, $_column_medicineName TEXT NOT NULL, $_column_medicineType TEXT NOT NULL, $_column_medicineDosage REAL NOT NULL, $_column_intervalDays INTEGER NOT NULL, $_column_intervalHours INTEGER NOT NULL, $_column_startDate TEXT NOT NULL, $_column_startTime TEXT NOT NULL)');
  }

  // Insert a new reminder
  Future<int> insertReminder(Map<String, Object?> record) async {
    Database db = await _databaseHandler.database;
    return await db.insert(tableName, record);
  }

  // Get all reminders
  Future<List<Reminder>> getAllReminders() async {
    List<Reminder> test = [];
    Database database = await _databaseHandler.database;
    // get all rows
    List<Map> result = await database.query(tableName);

    // print the results
    result.forEach((row) => {
          test.add(new Reminder(
              row['_id'],
              row['medicineName'],
              row['type'],
              row['dosage'],
              row['intervalDays'],
              row['intervalHours'],
              row['startDate'],
              row['startTime']))
        });
    // return await database.query(tableName);
    return test;
  }

  // Update a reminder
  Future<int> updateReminder(Map<String, Object?> record) async {
    Database database = await _databaseHandler.database;
    int id = record[_column_Id] as int;
    return database
        .update(tableName, record, where: '$_column_Id = ?', whereArgs: [id]);
  }

  // Delete a reminder
  Future<int> deleteReminder(int id) async {
    Database database = await _databaseHandler.database;
    return database
        .delete(tableName, where: '$_column_Id = ?', whereArgs: [id]);
  }
}

/*

  Controller class

*/
class DatabaseController {
  // Database handler object
  static final _DatabaseHandler _databaseHandler = new _DatabaseHandler();

  // Singleton databaseController object
  static final DatabaseController _databaseController =
      DatabaseController._internal();
  factory DatabaseController() {
    return _databaseController;
  }
  DatabaseController._internal();

  /*
    Insert function
  */
  Future<bool> insertNewReminder(Reminder reminder) async {
    // Create the Map object to pass the data
    Map<String, Object?> record = {
      _databaseHandler._column_medicineName: reminder.medicineName,
      _databaseHandler._column_medicineType: reminder.type,
      _databaseHandler._column_medicineDosage: reminder.dosage,
      _databaseHandler._column_intervalDays: reminder.intervalDays,
      _databaseHandler._column_intervalHours: reminder.intervalHours,
      _databaseHandler._column_startDate: reminder.startDate,
      _databaseHandler._column_startTime: reminder.startTime,
    };

    // Pass the Map object to the DatabaseHandler
    final result = await _databaseHandler.insertReminder(record);

    // Validate database operation
    if (result == 0) {
      return false;
    } else {
      return true;
    }
  }

  /*
    Delete function
  */
  Future<bool> deleteReminder(int id) async {
    // Pass the Map object to the DatabaseHandler
    final result = await _databaseHandler.deleteReminder(id);

    // Validate database operation
    if (result == 0) {
      return false;
    } else {
      return true;
    }
  }

  /*
    Update function
  */
  Future<bool> updateReminder(Reminder reminder) async {
    // Create the Map object to pass the data
    Map<String, Object?> record = {
      _databaseHandler._column_Id: reminder.id,
      _databaseHandler._column_medicineName: reminder.medicineName,
      _databaseHandler._column_medicineType: reminder.type,
      _databaseHandler._column_medicineDosage: reminder.dosage,
      _databaseHandler._column_intervalDays: reminder.intervalDays,
      _databaseHandler._column_intervalHours: reminder.intervalHours,
      _databaseHandler._column_startDate: reminder.startDate,
      _databaseHandler._column_startTime: reminder.startTime,
    };

    // Pass the Map object to the DatabaseHandler
    final result = await _databaseHandler.updateReminder(record);

    // Validate database operation
    if (result == 0) {
      return false;
    } else {
      return true;
    }
  }

  // Get all reminders
  Future<List<Reminder>> getReminders() async {
    return await _databaseHandler.getAllReminders();
  }
}
