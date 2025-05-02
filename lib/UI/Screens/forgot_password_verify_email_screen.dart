import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screens/forgot_password_pin_verification_screen.dart';
import 'package:task_manager/UI/Widgets/screen_background.dart';
import 'package:task_manager/UI/Widgets/snack_bar_message.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _sendCodeInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "A 6 digit verification pin will be sent to your email.",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: "Email"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email';
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _sendCodeInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _sendVerificationCodeToEmail,
                      child: const Text('Send Code'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: "Have an account? "),
                        TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = _onTabSignInButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendVerificationCodeToEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _sendCodeInProgress = true;
    setState(() {});

    try {
      final response = await NetworkClient.postRequest(
        url: Urls.recoverVerifyEmailUrl(_emailTEController.text.trim()),
        body: {'email': _emailTEController.text.trim()},
      );

      _sendCodeInProgress = false;
      setState(() {});

      if (response.isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Verification code sent to your email');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ForgotPasswordPinVerificationScreen(
                    email: _emailTEController.text.trim(),
                  ),
            ),
          );
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, response.errorMessage);
        }
      }
    } catch (e) {
      _sendCodeInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context, 'Something went wrong');
      }
    }
  }

  void _onTabSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
