import 'package:prueba_task_manager/fetures/tasks/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._();
  static Database? _database;
  TaskDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), 'task.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, completed INTEGER)',
        );
      },
    );
    return _database!;
  }

  Future<void> insertTasks(List<TaskModel> tasks) async {
    final db = await database;
    final batch = db.batch();
    for (var task in tasks) {
      batch.insert(
        'tasks',
        task.toJsonDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final data = await db.query('tasks');
    return data.map((e) => TaskModel.fromDb(e)).toList();
  }

  Future<void> updateCompleteTask(int id, bool completed) async {
    final db = await database;
    await db.update(
      'tasks',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> createTask(TaskModel task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toJsonDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
