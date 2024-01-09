import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_auth_app/src/controller/login_screen_controller.dart';
import 'package:phone_auth_app/src/view/otp_verify_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginScreenController controller = Get.put(LoginScreenController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter your mobile no',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'We need to verity your number',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Mobile Number',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: controller.updatePhoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.done),
                        suffixIconColor: controller.isValidPhoneNumber.value
                            ? Colors.black
                            : Colors.black12,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 18),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Enter mobile no',
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF111827)),
                      onPressed: controller.isButtonEnabled.value
                          ? () {
                              controller.startTimer();
                              controller
                                  .otpController(controller.otpGet.value.length);
                              Get.to(OTPVerificationScreen());
                            }
                          : null,
                      child: const Text('Get OTP'),
                    ),
                  ),
                  const Spacer(),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity:
                        const VisualDensity(vertical: -4, horizontal: -4),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                        'Allow fydaa to send financial knowledge and critical alerts on your WhatsApp.'),
                    value: controller.isCheckboxChecked.value,
                    onChanged: (value) {
                      controller.updateCheckbox(value!);
                    },
                  ),
                ],
              ),
            )));
  }
}
