import 'package:flutter/material.dart';
import 'package:sign/pages/services/auth.dart';
import 'package:sign/shared/constants.dart';
import 'package:sign/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Sign in to IIUM Coffee'),
              actions: [
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Register'),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter your email' : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (value) => value.length < 6
                              ? 'Enter a passwrod 6+ chars long'
                              : null,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          color: Colors.brown[400],
                          child: Text(
                            'sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            setState(() => loading = true);
                            if (_formKey.currentState.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'could not sign in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ))),
          );
  }
}
