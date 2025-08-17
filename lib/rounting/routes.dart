abstract class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String member = '/member';
  static const String visitorDetail = '/visitor_detail';
  static String visitorWithId(int id) => '$visitorDetail/$id';
  static const String registeredUserLogs = '/registered_user_logs';
  static String registeredUserLogsWithId(int id) => '$registeredUserLogs/$id';
}
