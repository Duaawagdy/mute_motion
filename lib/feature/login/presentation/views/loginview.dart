import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class login_screen extends StatefulWidget {
  login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  // ignore: non_constant_identifier_names
  bool Show_Pass = true;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Form(
    key: formKey,
    child: ListView(
    children: [
    Image.asset('assets/pana.png'),
    const SizedBox(
    height: 5,
    ),
    Container(
    alignment: Alignment.center,
    child: const Text(
    "Welcome",
    style: TextStyle(fontSize: 30,fontFamily: 'Comfortaa'
        , color: Color(0xff003248)),
    ),
    ),
    const Center(
    child: Text("Please Enter your info",
    style:
    TextStyle(fontSize: 18,fontFamily: 'Comfortaa'
        , color: Color(0xff003248)))),
    const SizedBox(
    height: 20,
    ),
    TextFormField(
    controller: emailCont,
    validator: (value) {
    if (value!.isEmpty) {
    return "Email must not be empty";
    }
    return null;
    },
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
    labelText: "Email",
    prefixIcon: Icon(Icons.mail),
    border: OutlineInputBorder(),
    ),
    ),
    const SizedBox(
    height: 20,
    ),
    TextFormField(
    controller: passCont,
    validator: (value) {
    if (value!.isEmpty) {
    return "Password must not be empty";
    }
    return null;
    },
    keyboardType: TextInputType.visiblePassword,
    obscureText: Show_Pass,
    decoration: InputDecoration(
    labelText: "Password",
    prefixIcon: const Icon(Icons.lock),
    border: const OutlineInputBorder(),
    suffixIcon: IconButton(
    onPressed: () {
    setState(() {
    Show_Pass = !Show_Pass;
    });
    },
    icon: Icon(
    Show_Pass ? Icons.visibility_off : Icons.visibility),
    ),
    ),
    ),
    const SizedBox(
    height: 30,
    ),
    Container(
    width: double.infinity,
    decoration: BoxDecoration(
    color: const Color(0xff003248),
    borderRadius: BorderRadius.circular(20)),
    child: MaterialButton(
    onPressed: () async {
      GoRouter.of(context).push('/navbar');
    if (formKey.currentState!.validate()) {
    print(emailCont.text);
    }
    },
    child: const Text(
    "Login",
    style: TextStyle(fontSize: 22,fontFamily: 'Comfortaa', color: Colors.white),
    )),
    ),
    const SizedBox(
    height: 30,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Text("Don't have an account? ",
    style: TextStyle(
    fontSize: 15,fontFamily: 'Comfortaa',
    )),TextButton(
          onPressed: () {GoRouter.of(context).push('/resgister');},
          child: const Text(
            "Register now",
            style:
            TextStyle(color:Color(0xff003248),fontSize: 16,fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),
          )),
    ],
    )
    ],
    ),
    ),
        ),
    );
  }
}