import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:operuit_flutter/api/auth.dart';
import 'package:operuit_flutter/login.dart';
import 'package:operuit_flutter/overlay/message.dart';
import 'package:operuit_flutter/register.dart';
import 'package:operuit_flutter/util/cryptoop.dart';
import 'package:operuit_flutter/util/localdata.dart';
import 'package:overlay_support/overlay_support.dart';

class MyPin extends StatefulWidget {
  const MyPin({Key? key}) : super(key: key);

  @override
  _MyPinState createState() => _MyPinState();
}

class _MyPinState extends State<MyPin> {
  String text = '';
  bool pinError = false;

  bool isRegister() {
    return MyRegister.registerData["username"]!.isNotEmpty;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  String getTitle() {
    return isRegister() ? "Your new\nPIN" : "Your\nPIN";
  }

  void _onKeyboardTap(String value) {
    setState(() {
      if (text.length == 6) {
        return;
      }
      text = text + value;
    });
  }

  // https://github.com/huextrat/TheGorgeousOtp/blob/master/lib/pages/otp_page.dart
  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: const TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: pinError ? const Color(0xffffc2c2) : Colors.grey.shade100,
            border: Border.all(
                color: pinError ? Colors.red : Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  bool isLogin() {
    return MyLogin.loginData["username"]!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/pin.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 50),
              child: Text(
                getTitle(),
                style: const TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(0),
                              otpNumberWidget(1),
                              otpNumberWidget(2),
                              otpNumberWidget(3),
                              otpNumberWidget(4),
                              otpNumberWidget(5),
                            ],
                          ),
                          const SizedBox(height: 40),
                          NumericKeyboard(
                            onKeyboardTap: _onKeyboardTap,
                            textColor: Colors.black,
                            rightIcon: const Icon(
                              Icons.backspace,
                              color: Colors.black,
                            ),
                            rightButtonFn: () {
                              setState(() {
                                if (text.isEmpty) {
                                  return;
                                }
                                text = text.substring(0, text.length - 1);
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      if (!isLogin()) {
                                        if (text.length != 6) {
                                          setState(() {
                                            pinError = true;
                                          });
                                          return;
                                        } else if (pinError) {
                                          setState(() {
                                            pinError = false;
                                          });
                                        }
                                        if (RegExp(r'\b(\w+)+\1(?:\1)*\b')
                                            .hasMatch(text)) {
                                          showSimpleNotification(
                                              const Text(
                                                  "Your PIN is too insecure."),
                                              background: Colors.red,
                                              position:
                                              NotificationPosition.bottom);
                                          return;
                                        }
                                        var plaintextUsername =
                                        MyRegister.registerData["username"];
                                        var plaintextPassword =
                                        MyRegister.registerData["password"];
                                        var plaintextDisplayName = MyRegister
                                            .registerData["displayName"];
                                        var plaintextSalt = Auth.getRandom(16);
                                        var password = CryptoOP.hash(
                                            "$plaintextUsername$plaintextPassword$plaintextSalt");
                                        var pin = CryptoOP.hash(
                                            "$text$plaintextUsername$password$plaintextSalt");
                                        String encryptedSalt = await CryptoOP.encrypt(plaintextUsername!, plaintextUsername, plaintextSalt);
                                        var remotePassword =
                                            "${CryptoOP.hash("$plaintextPassword$pin")}:$encryptedSalt";
                                        var username =
                                        CryptoOP.hash(plaintextUsername);
                                        var displayName = await CryptoOP.encrypt(
                                            pin,
                                            plaintextSalt,
                                            plaintextDisplayName!);
                                        LocalData.writeUserdata("$plaintextUsername;$password;$plaintextSalt");
                                        var status = await const Auth()
                                            .register(username, displayName,
                                            remotePassword);
                                        if (status == 200) {
                                          showOverlayNotification(
                                                  (context) {
                                                return MessageNotification(
                                                  onClick: () {},
                                                  icon: Icons.send,
                                                  title: "Response",
                                                  message:
                                                  "Code: $status - new username: ${MyRegister.registerData["username"]}",
                                                );
                                              },
                                              duration: const Duration(
                                                  seconds: 5));
                                        } else if (status == 101) { // User already exists
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        if (text.length != 6) {
                                          setState(() {
                                            pinError = true;
                                          });
                                          return;
                                        } else if (pinError) {
                                          setState(() {
                                            pinError = false;
                                          });
                                        }
                                        final bool fileExists = await LocalData.fileExists();
                                        var plaintextUsername =
                                        MyLogin.loginData["username"];
                                        var username =
                                        CryptoOP.hash('$plaintextUsername');
                                        String salt;
                                        if (fileExists) {
                                          salt = await LocalData.readUserdata();
                                          salt = salt.split(";")[2];
                                        } else {
                                          salt = await const Auth().salt(username);
                                          salt = salt.substring(0, salt.length - 1);
                                          salt = await CryptoOP.decrypt(plaintextUsername!, plaintextUsername, salt);
                                        }
                                        if (salt.isEmpty) {
                                          showSimpleNotification(
                                              const Text(
                                                  "User has not been found."),
                                              background: Colors.red,
                                              position:
                                              NotificationPosition.bottom);
                                          Navigator.pop(context);
                                          return;
                                        }
                                        var plaintextPassword =
                                        MyLogin.loginData["password"];
                                        var password = CryptoOP.hash(
                                            "$plaintextUsername$plaintextPassword$salt");
                                        var pin = CryptoOP.hash(
                                            "$text$plaintextUsername$password$salt");
                                        String encryptedSalt = await CryptoOP.encrypt(plaintextUsername!, plaintextUsername, salt);
                                        var remotePassword =
                                            "${CryptoOP.hash("$plaintextPassword$pin")}:$encryptedSalt";
                                        bool success = await const Auth()
                                            .login(username,
                                            remotePassword);
                                        if (success) {
                                          LocalData.writeUserdata("$plaintextUsername;$password;$salt");
                                          showOverlayNotification(
                                                  (context) {
                                                return MessageNotification(
                                                  onClick: () {},
                                                  icon: Icons.send,
                                                  title: "Response",
                                                  message:
                                                  "Success: $success",
                                                );
                                              },
                                              duration: const Duration(
                                                  seconds: 5));
                                        } else {
                                          showSimpleNotification(
                                              const Text(
                                                  "Login failed."),
                                              background: Colors.red,
                                              position:
                                              NotificationPosition.bottom);
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 20),
                                ),
                                style: const ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
