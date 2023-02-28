import 'package:exam_and_viva/Screens/TodoScreen/Model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void createShared({required String email, required String pass}) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setString('Email', email);
  preferences.setString('Pass', pass);

}

Future<LoginModel> readShared() async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();

  LoginModel loginModel = LoginModel(email: preferences.getString('Email'), pass: preferences.getString('Pass'));

  return loginModel;
}



void IsLogin({required bool login}) async
{
  print("======== $login");
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setBool('Login', login);

}

Future<bool?> ReadIsLogin() async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool? value = preferences.getBool('Login');

  return value;
}