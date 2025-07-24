
import 'package:crafty_bay/features/Common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/features/auth/data/login_request_model.dart';
import 'package:crafty_bay/features/auth/ui/controller/login_controller.dart';
import 'package:crafty_bay/features/auth/ui/screens/sinup_screen.dart';
import 'package:crafty_bay/features/auth/ui/widgets/app_logo.dart';
import 'package:crafty_bay/features/core/ui/widgets/center_circular_progress_.dart';
import 'package:crafty_bay/features/core/ui/widgets/show_snacbar_massage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
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
                      Text("WellCome Back", style: textTheme.titleLarge,),
                      SizedBox(height: 8,),
                      Text("Please Enter Your email & password",
                        style: textTheme.headlineMedium,),
                      SizedBox(height: 24,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailTEController,
                        decoration: InputDecoration(
                            hintText: "Enter Your Email"
                        ),
                        validator: (String? value) {
                          String emailValue = value ?? '';
                          if (EmailValidator.validate(emailValue) == false) {
                            return "Enter your Valid email!";
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
                            hintText: "Enter Password"
                        ),
                        validator: (String? value) {
                          if ((value?.length ?? 0) <= 6) {
                            return 'Enter a password more than 6 letters';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 24,),
                      GetBuilder<LoginController>(
                        builder: (controller) {
                          return Visibility(
                            visible: controller.logInProgress== false,
                            replacement: CenterCircularProgressIndicator(),
                            child: ElevatedButton(
                                onPressed: _onTapLoginButton,
                                child: Text("Next")),
                          );
                        }
                      ),
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don't Have an Account? "),
                          TextButton(onPressed: (){
                            Navigator.
                            pushNamed(context, SignUpScreen.name);
                          },
                              child: Text("Sign UP")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Future<void> _onTapLoginButton() async {
    if (_fromKey.currentState!.validate()) {
      LoginRequestModel model = LoginRequestModel(
          email: _emailTEController.text.trim(),
          password: _passwordTEController.text);
       bool isSuccess =await _loginController.login(model);

      if(isSuccess){
        Navigator.pushNamedAndRemoveUntil(context, MainBottomNavScreen.name, (predicate)=> false);
      }else{
        ShowSnackbarMassage(context, _loginController.errorMassage!);
      }
    }
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
