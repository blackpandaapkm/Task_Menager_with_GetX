import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_menager_with_getx/api/apiClient.dart';
import '../../style/style.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  void _formOnSubmit() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }

    setState(() {
      _loading = true;
    });

    final res = await VerifyEmailRequest(email);
    if (res == true) {
      Get.toNamed('/pinVerification');
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Center(
            child: _loading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Email Address", style: Head1Text(colorDarkBlue)),
                  SizedBox(height: 1),
                  Text("A 6 digit verification pin will be sent to your email address", style: Head6Text(colorLightGray)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: AppInputDecoration("Email Address"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild('Next'),
                    onPressed: _formOnSubmit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
