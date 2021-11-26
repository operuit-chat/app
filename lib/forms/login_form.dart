import 'package:flutter/material.dart';
import 'package:operuit_flutter/login.dart';
import 'package:operuit_flutter/register.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.length < 3 || value.length > 22) {
                return 'A length between min. 3 and max. 22 characters is required.';
              }
              return null;
            },
            style: const TextStyle(color: Colors.black),
            onChanged: (value) => MyLogin.loginData["username"] = value,
            decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Cannot be empty.';
              }
              return null;
            },
            style: const TextStyle(),
            obscureText: true,
            onChanged: (value) => MyLogin.loginData["password"] = value,
            decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 27, fontWeight: FontWeight.w700),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xff4c505b),
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      MyRegister.registerData["username"] = "";
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, 'pin');
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
