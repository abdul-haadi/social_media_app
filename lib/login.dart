import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/authservice.dart';
import 'package:social_media_app/homepage.dart';
import 'package:social_media_app/locator.dart';
import 'package:social_media_app/onboarding.dart';
import 'package:social_media_app/signup.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});
  
  final _formKey = GlobalKey<FormState>();
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool obscureText = true;
  // final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.all(25.0),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnBoarding()));
              },
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white, size: 30, semanticLabel: 'Back'),
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Hello Again!",
                  style:
                      TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
              const Text(
                "Sign into your account",
                style: TextStyle(color: Colors.grey),
              ),
              Form(
                key: widget._formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          TextFormField(

                            controller: _email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              return null;
                            
                            },
                            decoration: InputDecoration(
                              labelText: "Enter email",
                              labelStyle: const TextStyle(color: Colors.grey),
                              hintText: "Enter your email",
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(

                            controller: _password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              return null;
                            
                            },
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              labelText: "Enter password",
                              labelStyle: const TextStyle(color: Colors.grey),
                              hintText: "Enter your password",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  obscureText = !obscureText;
                                },
                                icon: const Icon(Icons.visibility_off),
                              ),

                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot your Password?",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              onPressed: () {
                                if(widget._formKey.currentState!.validate()){
                                  _login();
                                }
                                _login();
                                
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? Let's ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignUpScreen()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    final _user = await locator<AuthService>()
        .loginUserWithEmailAndPassword(_email.text, _password.text);
    if (_user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
}
