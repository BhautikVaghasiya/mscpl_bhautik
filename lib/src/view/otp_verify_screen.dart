import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_auth_app/src/controller/login_screen_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  final LoginScreenController controller = Get.put(LoginScreenController());

  OTPVerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Verify your phone',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Enter the verification code sent to\n',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: controller.phoneNumber.value,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // OTP Input
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                  decoration: BoxDecoration(
                      color: controller.validOtpStage == 0
                          ? Colors.transparent
                          : controller.validOtpStage == 1
                              ? Colors.green.shade300
                              : Colors.red.shade500,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: List.generate(
                          controller.otpGet.value.length,
                          (index) => Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: TextField(
                                controller: controller.controllers[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                onChanged: (text) {
                                  controller.onTextChanged(index, text);

                                  // Check if the user pressed the delete key
                                  if (text.isEmpty) {
                                    controller.onDeletePressed(index);
                                  }
                                },
                                onSubmitted: (_) => controller.validateOtp(),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white12),
                                  ),
                                  counterText: '',
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: controller.validOtpStage == 0
                              ? Text(
                                  'Verification code expires in ${controller.remainingTime.value}s')
                              : controller.validOtpStage == 1
                                  ? TextButton.icon(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white),
                                      onPressed: () {
                                        // Add your verification logic here
                                      },
                                      icon: const Icon(Icons.done),
                                      label: const Text('Verify'),
                                    )
                                  : TextButton.icon(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white),
                                      onPressed: () {
                                        // Add your verification logic here
                                      },
                                      icon: const Icon(Icons.close),
                                      label: const Text('Invalid OTP'),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    controller.resendCode();
                  },
                  child: const Text('Resend Code'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Change Number'),
                ),
              ],
            ),
          ),
        ));
  }
}
