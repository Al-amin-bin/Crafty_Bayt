import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/features/auth/data/signUpRequestModel.dart';
import 'package:crafty_bay/features/auth/ui/controller/signupController.dart';
import 'package:crafty_bay/features/auth/ui/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/auth/ui/widgets/app_logo.dart';
import 'package:crafty_bay/features/core/ui/widgets/center_circular_progress_.dart';
import 'package:crafty_bay/features/core/ui/widgets/show_snacbar_massage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static final String name = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
              key: _fromKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      AppLogo(
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 24,),
                      Text("Complete Profile", style: textTheme.titleLarge,),
                      SizedBox(height: 8,),
                      Text("Get started with us with your details",
                        style: textTheme.headlineMedium,),
                      SizedBox(height: 24,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _firstNameTEController,
                        decoration: InputDecoration(
                            hintText: "First Name"
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return "Please Enter your First Name";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _lastNameTEController,
                        decoration: InputDecoration(
                            hintText: "Last Name"
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return "Please Enter your Last Name";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailTEController,
                        decoration: InputDecoration(
                            hintText: "Email"
                        ),
                        validator: (String? value){
                          String emailValue = value?? '';
                          if(EmailValidator.validate(emailValue) == false){
                            return "Enter your Valid email!";
                          }
                          return null;

                        },

                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _mobileTEController,
                        decoration: InputDecoration(
                            hintText: "Mobile Number"
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return "Please Enter your Valid Mobile Number";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _passwordTEController,
                        decoration: InputDecoration(
                            hintText: "Password"
                        ),
                        validator: (String? value) {
                          if ((value?.length ?? 0) <= 6) {
                            return 'Enter a password more than 6 letters';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _cityTEController,
                        decoration: InputDecoration(
                            hintText: "City"
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return "Please Enter your City Name";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        maxLines: 3,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _shippingAddressTEController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            hintText: "Shopping Address"
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return "Please Enter your Shopping Address";
                          }
                          return null;
                        },

                      ),

                      SizedBox(height: 24,),
                      GetBuilder<SignUpController>(
                        builder: (_) {
                          return Visibility(
                            visible: _signUpController.signupInProgress== false,
                            replacement: CenterCircularProgressIndicator(),
                            child: ElevatedButton(
                                onPressed: onTapSignupButton,


                                child: Text("Sign Up")),
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

  onTapSignupButton() async {
    if (_fromKey.currentState!.validate()) {
      SignUpRequestModel requestModel = SignUpRequestModel(
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          email: _emailTEController.text.trim(),
          phone: _mobileTEController.text.trim(),
          password: _passwordTEController.text,
          city: _cityTEController.text.trim());
      final bool isSuccess = await _signUpController.signUp(requestModel);

      if(isSuccess){
        Navigator.pushNamed(context, VerifyOtpScreen.name, arguments: _emailTEController.text.trim());
        ShowSnackbarMassage(context, _signUpController.massage);
      }else{
        ShowSnackbarMassage(context, _signUpController.errorMassage!);

      }
    }



  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}


