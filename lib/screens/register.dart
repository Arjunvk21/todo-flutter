import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/models/addTaskModel.dart';
import 'package:provider/models/usermodel.dart';
import 'package:provider/services/userService.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  UserModel _userModel = UserModel();
  UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
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
              'Register Here',
              style: GoogleFonts.aBeeZee(fontSize: 28),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 210, 248, 211),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the Username';
                                }
                              },
                              controller: _nameController,
                              style: GoogleFonts.aBeeZee(),
                              decoration:
                                  const InputDecoration(hintText: 'Username'),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
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
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value != _passwordController.text) {
                                  return "Password doesn't match";
                                }
                                return null;
                              },
                              controller: _confirmpasswordController,
                              style: GoogleFonts.aBeeZee(),
                              decoration: const InputDecoration(
                                  hintText: 'Confirm Password'),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isloading = true;
                                  });
                                  _userModel = UserModel(
                                      username: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  // _registerUser();
                                }
                                final user =
                                    await _userService.registerUser(_userModel);
                                if (user != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    'Registration Succesfull',
                                  )));
                                  Navigator.pushNamed(context, '/home');
                                  setState(() {
                                    _isloading = false;
                                  });
                                }
                              },
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * .05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 166, 219, 168),
                                ),
                                child: Center(
                                    child: Text(
                                  'Register',
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
                                  'Already have an account?',
                                  style: GoogleFonts.aBeeZee(),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/login'),
                                  child: Text(
                                    'Login here',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _isloading,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 150, 193, 152),
                          ),
                        ))
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
