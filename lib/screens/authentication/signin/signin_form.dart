import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/controllers/auth.dart';
import 'package:quickstep_app/models/account.dart';
import 'package:quickstep_app/screens/authentication/signin/signin_input_field.dart';
import 'package:quickstep_app/services/auth_service.dart';

import '../../../utils/helpers.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final auth = Get.put(AuthState());

  final _hiveDb = AuthService();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SignInInputField(
            hintText: "Email",
            svg: "email.svg",
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          SignInInputField(
            hintText: "Password",
            svg: "pwd.svg",
            isPwd: true,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.h, bottom: 24.h),
            child: ElevatedButton.icon(
              onPressed: () async {
                if (email == null ||
                    password == null ||
                    email!.isEmpty ||
                    password!.isEmpty) {
                  return;
                }
                final res = await _hiveDb.addAuth(
                  "new-auth-token-service",
                  Account(
                    userId: "new-user-id",
                    fullName: "Aime Ndayambaje",
                    email: email!,
                    username: "aimelive",
                    profilePic: "aime.png",
                    createdAt: DateTime.now().subtract(
                      const Duration(days: 100),
                    ),
                  ),
                );
                if (!mounted) return;
                popPage(context);
                Future.delayed(
                  const Duration(milliseconds: 400),
                  () => auth.isSignedIn.value = res,
                );
                // pushPage(context, to: const LayoutPage());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              ),
              icon: const Icon(
                CupertinoIcons.arrow_right,
                color: Color(0xFF9fcdf5),
              ),
              label: const Text("Sign In"),
            ),
          )
        ],
      ),
    );
  }
}
