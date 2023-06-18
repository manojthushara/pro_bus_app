import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// text editing contrillers
  final emailnameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final contactController = TextEditingController();
  final nameController = TextEditingController();



  @override
  void disponse() {
    nameController.dispose();
    contactController.dispose();
    emailnameController.dispose();
    super.dispose();
  }

  // sign user up mehtod
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (confirmPasswordController.text == passwordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailnameController.text,
          password: passwordController.text,
        );

        addUserDetails(
          nameController.text.trim(),
          emailnameController.text.trim(),
          int.parse(contactController.text.trim())
        );

        Navigator.pop(context);
        ;
      } else {
        Navigator.pop(context);
        showErrorMessagepassword();
      }
      ;
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  // add user details in firestroe
  Future addUserDetails(String name, String email, int contact) async {
    await FirebaseFirestore.instance.collection("passengers").add({
      'name': name,
      'contact': contact,
      'email': email,
    });
  }

//show error massage
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFe7dac7),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF241f1c)),
            ),
          ),
        );
      },
    );
  }

  //show error massage
  void showErrorMessagepassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFe7dac7),
          title: Center(
            child: Text(
              "Password Dont Match",
              style: const TextStyle(color: Color(0xFF241f1c)),
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 10, top: 10, left: 10, bottom: 10),
              child: Image.asset('lib/images/main_logo.png'),
              height: 100,
              width: 100,
            ),
            Text(
              'Let\'s create an account for you',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 10, top: 20, left: 10),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // Name feild
                    MyTextField(
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false),
                    const SizedBox(
                      height: 10,
                    ),

                    // Contact feild
                    MyTextField(
                        controller: contactController,
                        hintText: 'Contact',
                        obscureText: false),
                    const SizedBox(
                      height: 10,
                    ),

                    MyTextField(
                        controller: emailnameController,
                        hintText: 'Email',
                        obscureText: false),
                    // ignore: prefer_const_constructors

                    const SizedBox(
                      height: 10,
                    ),
                    // password textfield
                    MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true),

                    const SizedBox(
                      height: 10,
                    ),
                    // forgot password?

                    // sign in button

                    MyButton(
                      text: "Sign In",
                      onTop: signUserUp,
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    // or continue with

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey[800],
                              thickness: 0.5,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey[800],
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // google + apple sign in button
                    // google

                    // not a member? register now

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have Account?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login Now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
