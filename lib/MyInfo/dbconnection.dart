import 'package:mysql1/mysql1.dart' as mysql;

class DbConnection {
  String host = '123.57.186.243';
  int port = 3306;
  String user = 'root';
  String password = '12345678';

  DbConnection() {}

  getMysqlConnection() async {
    mysql.MySqlConnection conn = await mysql.MySqlConnection.connect(
        mysql.ConnectionSettings(
            host: host,
            port: port,
            user: user,
            password: password,
            db: 'test'));
    return conn;
  }
}
