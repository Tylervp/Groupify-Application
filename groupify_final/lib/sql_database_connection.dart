import 'package:mysql1/mysql1.dart';


class SQLDatabaseHelper {
  late MySqlConnection _connection;

  Future<void> connectToDatabase() async {
    _connection = await MySqlConnection.connect(ConnectionSettings(
      host: "127.0.0.1",
      port: 3306,
      user: "root",
      password: "root",
      db: "groupify",
    ));
  }

  MySqlConnection get connection => _connection;

  Future<void> closeConnection() async {
    await _connection.close();
  }
}
