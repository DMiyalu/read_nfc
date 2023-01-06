import 'package:hive/hive.dart';

class AuthenticationRepository {
  static Future<bool> checkData() async {
    final authenticationBox = await Hive.openBox("authenticationBox");
    var result = await authenticationBox.get("userAuth");
    if (result == null) return false;
    return true;
  }

  // static Future<Map> checkUserAuth() async {
  //   Map _result = {};
  //   try {
  //     bool data = await checkData();
  //     final authenticationBox = await Hive.openBox("authenticationBox");
  //     if (data) {
  //       String _userAuth = authenticationBox.get('userAuth');
  //       Map _data = jsonDecode(_userAuth);
  //       _result['status'] = 200;
  //       _result['data'] = _data;
  //       return _result;
  //     }
  //     _result['status'] = 404;
  //     return _result;
  //   } catch (error) {
  //     _result['status'] = 500;
  //     _result['message'] = "Error on check userAuth: ${error.toString()}";
  //     return _result;
  //   }
  // }

  // static Future<Map> loginUser({required Map userField}) async {
  //   Map _result = {};
  //   Map _user = {
  //     'username': userField['email'],
  //     'password': userField['password'],
  //     'client_secret': 'NKzhZpZ1qrs41UCwG8xEFu6oY3XcOa1J',
  //     'grant_type': userField['password'],
  //     'client_id': 'mobile-app',
  //   };

  //   try {
  //     Response? _response = await AuthenticationProvider.loginUser(user: _user);
  //     if (_response!.statusCode == 200 ||
  //         _response.statusCode == 201 ||
  //         _response.statusCode == 204) {
  //       Map _data = jsonDecode(_response.body);
  //       _result['status'] = 200;
  //       _result['data'] = _data;
  //       return _result;
  //     }
  //     _result['status'] = _response.statusCode;
  //     _result['message'] = 'Error on login';
  //     return _result;
  //   } catch (error) {
  //     _result['status'] = 500;
  //     _result['message'] = "Error on login: ${error.toString()}";
  //     return _result;
  //   }
  // }
}
