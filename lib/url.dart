class Api {
  static int userid;
  static var monthlyline =
      'http://192.168.1.103:8081/tracker/register/TotalExpenseTotalIncomeLine_month?userId=$userid';
  static var listexpense =
      'http://192.168.1.103:8081/tracker/register/liscategoryexpense';
  static var listincome =
      'http://192.168.1.103:8081/tracker/register/liscategoryincome';
  static var generalurl = 'http://192.168.1.103:8081/tracker/register';
}
