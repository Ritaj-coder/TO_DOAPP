import 'package:flutter/foundation.dart';
import 'package:to_do_app1/model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentuser;

  void updateuser(MyUser newuser) {
    currentuser = newuser;
    notifyListeners();
  }
}
