import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/models/usermodel.dart';
import 'package:provider/services/userService.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserModel _userModel = UserModel();
  UserService _userService = UserService();
  bool _isloading = false;

  _login()async {
    setState(() {
      _isloading = true;
    });
    try{
      _userModel = UserModel(email: _emailController.text,password: _passwordController.text);
      final data = await _userService.loginUser(_userModel);
    }on FirebaseAuthException catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Login Here',
              style: GoogleFonts.aBeeZee(fontSize: 28),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 210, 248, 211),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter the Email';
                                  }
                                },
                                controller: _emailController,
                                style: GoogleFonts.aBeeZee(),
                                decoration:
                                    const InputDecoration(hintText: 'Email'),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter the Password';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                style: GoogleFonts.aBeeZee(),
                                decoration:
                                    const InputDecoration(hintText: 'Password'),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {}
                                },
                                child: Container(
                                  height: MediaQuery.sizeOf(context).height * .05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(255, 166, 219, 168),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Login',
                                    style: GoogleFonts.aBeeZee(fontSize: 20),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: GoogleFonts.aBeeZee(),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    'Register here',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  Visibility(visible: _isloading,child: Center(child: CircularProgressIndicator(),))
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
