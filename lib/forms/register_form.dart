import 'dart:math';

import 'package:flutter/material.dart';
import 'package:operuit_flutter/login.dart';
import 'package:operuit_flutter/register.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length > 20) {
                  return 'Cannot be empty or longer than 20 characters.';
                }
                return null;
              },
              style: const TextStyle(color: Colors.black),
              onChanged: (value) =>
                  MyRegister.registerData["displayName"] = value,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Display name",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.length < 3 || value.length > 16) {
                  return 'A length between min. 3 and max. 16 characters is required.';
                }
                return null;
              },
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => MyRegister.registerData["username"] = value,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Username",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (value) {
                if (value == null ||
                    !RegExp(r'^(?=(.*[a-z]){3,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){2,})(?=(.*[!@#$%^&*()<>\\\-__+.,;]){1,}).{8,}$')
                        .hasMatch(value)) {
                  return 'Too weak.';
                }
                return null;
              },
              style: const TextStyle(color: Colors.black),
              onChanged: (value) => MyRegister.registerData["password"] = value,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.black),
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
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w700),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xff4c505b),
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        MyLogin.loginData["username"] = "";
                        if (_formKey.currentState!.validate()) {
                          var _random = Random();
                          MyRegister.registerData["username"] = "${MyRegister.registerData["username"]}${_random.nextInt(99999)}";
                          Navigator.pushNamed(context, 'pin');
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                      )),
                )
              ],
            )
          ],
        ));
  }
}
