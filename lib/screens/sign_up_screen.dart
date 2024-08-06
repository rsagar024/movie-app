import 'package:flutter/material.dart';
import 'package:movie_app/screens/dashboard.dart';
import 'package:movie_app/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          // reverse: false,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/home.png'),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white30,
                              Colors.white70,
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/film-reel.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'PR',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                                TextSpan(
                                  text: 'A',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                                TextSpan(
                                  text: 'NDANA',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/actor.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70, top: 50),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      generateField('Enter your Name'),
                      generateField('Enter your Bio'),
                      generateField('Enter your Username'),
                      generateField('Enter your Password'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'Gender : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                              ),
                              child: Radio(
                                value: 1,
                                groupValue: selected,
                                onChanged: (value) {
                                  setState(() {
                                    selected = 1;
                                  });
                                },
                              ),
                            ),
                            const Text('Male',style: TextStyle(fontFamily: 'SF_Pro',),),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                              ),
                              child: Radio(
                                value: 2,
                                groupValue: selected,
                                onChanged: (value) {
                                  setState(() {
                                    selected = 2;
                                  });
                                },
                              ),
                            ),
                            const Text('Female',style: TextStyle(fontFamily: 'SF_Pro',),),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                                (route) => true,
                          );
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'SF_Pro',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account  ',style: TextStyle(fontFamily: 'SF_Pro',),),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                      (route) => true,
                                );
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget generateField(String text) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: text,
          hintStyle: const TextStyle(fontFamily: 'SF_Pro',),
        ),
        style: const TextStyle(fontFamily: 'SF_Pro',),
      ),
    );
  }
}
