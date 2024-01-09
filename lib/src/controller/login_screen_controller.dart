import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var phoneNumber = ''.obs;
  var isCheckboxChecked = false.obs;
  var isValidPhoneNumber = false.obs;
  var remainingTime = 170.obs; // 2 minutes and 50 seconds
  var isButtonEnabled = false.obs;

  var isResendButtonEnabled = false.obs;
  var resendCount = 0.obs;
  var otpGet = '934477'.obs;
  var validOtpStage = 0.obs;

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
    isValidPhoneNumber.value = value.length == 10;
    updateButtonState();
  }

  void updateCheckbox(bool value) {
    isCheckboxChecked.value = value;
    updateButtonState();
  }

  void updateButtonState() {
    // Enable the button only if the checkbox is checked and the phone number is valid
    isButtonEnabled.value = isValidPhoneNumber.value && isCheckboxChecked.value;
  }

  void startTimer() {
    remainingTime.value = 170;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value == 0) {
        timer.cancel();
      } else {
        remainingTime.value -= 1;
      }
    });
  }

  void resendCode() {
    otpGet.value = '12345';
    Get.snackbar('OTP Resend', 'New Otp 12345');
    resendCount.value = 0;
    startTimer();
    resendCount.value += 1;
  }

  // final int otpLength = 6;
  List<TextEditingController> controllers = <TextEditingController>[];
  List<FocusNode> focusNodes = <FocusNode>[];

  otpController(otpLength) {
    controllers.clear();
    focusNodes.clear();
    validOtpStage.value = 0;
    if (otpLength <= 0) {
      throw ArgumentError("otpLength must be a positive integer");
    }

    for (int i = 0; i < otpLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  void onTextChanged(int index, String text) {
    if (text.isNotEmpty) {
      if (index < otpGet.value.length - 1) {
        FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
      } else {
        validateOtp();
        Get.focusScope!.unfocus();
        if (index > 0) {
          Get.focusScope!.requestFocus(focusNodes[index - 1]);
        }
      }
    }
  }

  void onDeletePressed(int index) {
    if (index > 0) {
      controllers[index].text = '';
      FocusScope.of(Get.context!).requestFocus(focusNodes[index - 1]);
    }
  }

  void validateOtp() {
    String enteredOtp = controllers.map((controller) => controller.text).join();
    if (enteredOtp == otpGet.value) {
      validOtpStage.value = 1;
      // Get.snackbar('Success', 'OTP Verified successfully');
    } else {
      validOtpStage.value = 2;
      //  Get.snackbar('Error', 'Invalid OTP. Please try again.');
    }
  }
}
