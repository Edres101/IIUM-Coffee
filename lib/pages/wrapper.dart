import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sign/models/user.dart';
import 'package:sign/pages/authentication/authentication.dart';
import 'package:sign/pages/home/home.dart';

class Warpper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId>(context);
    print(user);

    // retun the home and the authentication screens
    return user == null ? Authenticate() : Home();
  }
}
