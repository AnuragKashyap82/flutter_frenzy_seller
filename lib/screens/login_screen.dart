import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/home.dart';
import 'package:frenzy_seller/screens/responsive_layout/responsive_layout_screens.dart';
import 'package:frenzy_seller/screens/sign_up_screen.dart';
import 'package:frenzy_seller/screens/web_screen/WebHomeScreen.dart';

import '../animations/fade_animation.dart';
import '../resources/authentication.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  child: FadeAnimation(
                    1.1,
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Frenzy Seller Hub",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.only(top: 72),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                    1.3,
                    Text(
                      "Login for best experience",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.4,
                    Text(
                      "Enter your Email and password to continue",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FadeAnimation(
                      1.5,
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: BorderSide.none),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  FadeAnimation(
                      1.6,
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: passwordController,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.fingerprint,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: BorderSide.none),
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: FadeAnimation(
                                1.7,
                                Text(
                                  "Don't have an account? signUp",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ForgotPasswordScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: FadeAnimation(
                              1.8,
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: FadeAnimation(
                          1.7,
                          FadeAnimation(
                            1.9,
                            ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String output = await AuthenticationMethods()
                                      .signInUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (output == "success") {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const ResponsiveLayout(
                                                webScreenLayout: WebHomeScreen(),
                                                mobileScreenLayout: HomeScreen())));
                                  } else {
                                    Utils().showSnackBar(context, output);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder()),
                                child: isLoading
                                    ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : Text("Sign In".toLowerCase())),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
