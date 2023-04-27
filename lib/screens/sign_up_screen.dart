import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/screens/gst_details_screen.dart';

import '../animations/fade_animation.dart';
import '../utils/utils.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isCodeSent = false;
  bool _isOtpVerified = false;
  String btnText = "Send Otp";
  String verify = "";
  var phone = "";
  var code = "";
  bool emailEnabled = false;
  TextEditingController countryController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double height = 720;
    double width = 300;

    if (screenSize.width > 500) {
      setState(() {
        height = 720;
        width = 450;
      });
    } else {
      setState(() {
        height = 720;
        width = screenSize.width;
      });
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Center(
                    child: PhysicalModel(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(26),
                      shadowColor: Colors.blue,
                      elevation: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const  SizedBox(
                            height: 16,
                          ),
                          FadeAnimation(
                            1.3,
                           const Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                     EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  "Create Your Seller Account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                         const SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Your Phone No."),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    code = value;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Your OTP"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                "*We have sent an One Time Password(OTP) to this Number",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: _emailController,
                                  enabled: emailEnabled,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Your Email"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                  enabled: emailEnabled,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Your Full Name"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  controller: _passwordController,
                                  enabled: emailEnabled,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter your password"),
                                    suffixIcon: Icon(
                                      Icons.remove_red_eye,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  controller: _cPasswordController,
                                  enabled: emailEnabled,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Confirm Your Password"),
                                    suffixIcon: Icon(
                                      Icons.remove_red_eye,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                "By filling this form, I agree to Term of Use",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: FadeAnimation(
                                1.5,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (phone.length < 10) {
                                          Utils().showSnackBar(context,
                                              "Phone No. should contain 10 digits!!!");
                                        } else if (!_isCodeSent &&
                                            !_isOtpVerified) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            await FirebaseAuth.instance
                                                .verifyPhoneNumber(
                                              phoneNumber:
                                                  '${countryController.text + phone}',
                                              verificationCompleted:
                                                  (PhoneAuthCredential
                                                      credential) {},
                                              verificationFailed:
                                                  (FirebaseAuthException e) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              },
                                              codeSent: (String verificationId,
                                                  int? resendToken) async {
                                                setState(() {
                                                  _isLoading = false;
                                                  _isCodeSent = true;
                                                  verify = verificationId;
                                                  btnText = "Verify Otp";
                                                });
                                                // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyVerify()));
                                              },
                                              codeAutoRetrievalTimeout:
                                                  (String verificationId) {},
                                            );
                                          } catch (e) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Utils().showSnackBar(
                                                context, "Otp send failed!!!");
                                          }
                                        } else if (_isCodeSent &&
                                            !_isOtpVerified) {
                                          try {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            PhoneAuthCredential credential =
                                                PhoneAuthProvider.credential(
                                                    verificationId: verify,
                                                    smsCode: code);

                                            // Sign the user in (or link) with the credential
                                            await auth
                                                .signInWithCredential(
                                                    credential)
                                                .then((value) {
                                              setState(() {
                                                _isOtpVerified = true;
                                                btnText = "Continue";
                                                emailEnabled = true;
                                                _isLoading = false;
                                                auth.signOut();
                                                Utils().showSnackBar(
                                                    context, "Otp Verified!!");
                                              });
                                            });
                                          } catch (e) {
                                            Utils().showSnackBar(
                                                context, "Wrong Otp");
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        } else if (_isOtpVerified) {
                                          if (_emailController.text.isEmpty) {
                                            Utils().showSnackBar(
                                                context, "Enter your Email!!");
                                          } else if (_nameController
                                              .text.isEmpty) {
                                            Utils().showSnackBar(
                                                context, "Enter your Name!!");
                                          } else if (_passwordController
                                                  .text.length <
                                              8) {
                                            Utils().showSnackBar(context,
                                                "Password should contain 8 characters!!!");
                                          } else if (_cPasswordController
                                                  .text !=
                                              _passwordController.text) {
                                            Utils().showSnackBar(context,
                                                "Password Doesn't matches!!!");
                                          } else {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            String output =
                                                await FireStoreMethods()
                                                    .signUpUser(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              phoneNo: _phoneNoController.text,
                                              password:
                                                  _passwordController.text,
                                              cPassword:
                                                  _cPasswordController.text,
                                            );
                                            if (output == "success") {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          GSTDetailsScreen()));
                                            } else {
                                              Utils().showSnackBar(
                                                  context, output);
                                            }
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            )
                                          : Text(btnText)),
                                ),
                              )),
                          SizedBox(
                            height: 32,
                          ),
                          FadeAnimation(
                            1.3,
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  "Already a seller? Sign In",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
