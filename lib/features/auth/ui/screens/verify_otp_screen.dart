
import 'package:crafty_bay/features/Common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/features/auth/data/verify_request_model.dart';
import 'package:crafty_bay/features/auth/ui/controller/verify_otp_controller.dart';
import 'package:crafty_bay/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay/features/auth/ui/widgets/app_logo.dart';
import 'package:crafty_bay/features/core/ui/widgets/show_snacbar_massage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});
  static final String name = '/verifyOtp';
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      AppLogo(
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 24,),
                      Text("Verify OTP",style: textTheme.titleLarge,),
                      SizedBox(height: 8,),
                      Text("A 4 digit OTP has been sent to your email address",style: textTheme.headlineMedium,),
                      const SizedBox(height: 24),
                      PinCodeTextField(
                        controller: _otpTEController,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldWidth: 50,
                          fieldHeight: 50,
                        ),
                        appContext: context,
                        validator: (String? value) {
                          if (value == null || value.length < 4) {
                            return 'Enter your OTP';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24,),
                      GetBuilder<VerifyOtpController>(
                        builder: (controller) {
                          return Visibility(
                            visible: controller.verifyInProgress == false,
                            replacement:  CircularProgressIndicator(),
                            child: ElevatedButton(
                                onPressed: onTapVerifyButton,
                                child: Text("Verify")),
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  onTapVerifyButton() async {
    if(_fromKey.currentState!.validate()){
      VerifyRequestModel model = VerifyRequestModel(email: widget.email, otp: _otpTEController.text.trim());
      bool isSuccess =await Get.find<VerifyOtpController>().verify(model);
      if(isSuccess){
        Navigator.pushNamedAndRemoveUntil(context, MainBottomNavScreen.name, (predicate)=> false);
        //Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name, (predicate)=> false);
      }else{
        ShowSnackbarMassage(context, Get.find<VerifyOtpController>().errorMassage!);
      }

    }

  }

  @override
  void dispose() {

    super.dispose();
    _otpTEController.dispose();
  }
}
