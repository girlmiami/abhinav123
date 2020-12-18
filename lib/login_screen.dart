import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

enum TypeOfLogin {
  Login,
  SignUp,
}

class Login extends StatefulWidget {
  static const routeName = '/login';
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TypeOfLogin userLogin = TypeOfLogin.SignUp;
  final _form = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 80,
                    top: 100,
                  ),
                  child: Text(
                    userLogin == TypeOfLogin.SignUp ? "Sign Up" : "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                formWidget(),
                RaisedButton(
                  color: Colors.indigo[800],
                  onPressed: () async {
                    userLogin == TypeOfLogin.SignUp
                        ? await signup()
                        : await login();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                typeOfLoginRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formWidget() {
    return Form(
      key: _form,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              height: 70,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Email",
                  helperText: "eg. Abhi123@gmail.com,....",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onFieldSubmitted: (_) {
                  if (_passwordFocusNode != null) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  }
                },
                validator: (value) {
                  if (!value.contains("@")) {
                    return "Enter Valid Email";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              height: 70,
              child: TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Password",
                  helperText: "Atleast 8 Charaters",
                  // labelText: "Password",

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty || value.length < 8) {
                    return "Wrong Password";
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  typeOfLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
          onPressed: () {
            setState(() {
              userLogin = TypeOfLogin.Login;
            });
          },
          child: Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: userLogin == TypeOfLogin.Login
                  ? Colors.indigo[800]
                  : Colors.blue,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              userLogin = TypeOfLogin.SignUp;
            });
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: userLogin == TypeOfLogin.SignUp
                  ? Colors.indigo[800]
                  : Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> login() async {
    bool isValid = false;
    if (_form.currentState != null) {
      isValid = _form.currentState.validate();
      _form.currentState.save();
    }
    if (!isValid) {
      return;
    } else {
      try {
        await auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } catch (loginError) {
        if (loginError is FirebaseAuthException) {
          error(loginError.code);
        }
      }
    }
  }

  showPopUpDialog(String text, context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  error(value) {
    if (value == "invalid-email") {
      showPopUpDialog("Invalid Email", context);
    } else if (value == "user-not-found") {
      showPopUpDialog("User Not Found", context);
    } else if (value == "wrong-password") {
      showPopUpDialog("Wrong Password", context);
    } else if (value == "email-already-in-use") {
      showPopUpDialog("Email Already in Use", context);
    } else {
      showPopUpDialog("Something went Wrong", context);
    }
  }

  Future<void> signInAnonymous() async {
    try {
      await auth.signInAnonymously();
    } catch (loginError) {
      if (loginError is FirebaseAuthException) {
        error("none");
      }
    }
  }

  Future<void> signup() async {
    bool isValid = false;
    if (_form.currentState != null) {
      isValid = _form.currentState.validate();
      _form.currentState.save();
    }
    if (!isValid) {
      return;
    } else {
      try {
        print('Error to solve');
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } catch (loginError) {
        print(loginError.code);
        if (loginError is FirebaseAuthException) {
          print(loginError.code);
          error(loginError.code);
        }
      }
    }
  }
}
