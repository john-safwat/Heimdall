import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/ForgetPassword/ForgetPasswordNavigator.dart';
import 'package:heimdall/Presentation/UI/ForgetPassword/ForgetPasswordViewModel.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatefulWidget {

  static const String routeName = "ForgetPassword";
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends BaseState<ForgetPasswordView , ForgetPasswordViewModel> implements ForgetPasswordNavigator{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel!.local!.forgetPasswordTitle),
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20,),
                  Lottie.asset(viewModel!.getImage() , fit: BoxFit.cover,),
                  const SizedBox(height: 20,),
                  // the text from field for the email
                  Form(
                    key: viewModel!.formKey,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      controller: viewModel!.emailController,
                      validator: (value) {
                        return viewModel!.emailValidation(value ?? "");
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          EvaIcons.email,
                          size: 30,
                        ),
                        hintText: viewModel!.local!.email,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: viewModel!.resetPassword,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(viewModel!.local!.sendEmail),
                    )
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  @override
  ForgetPasswordViewModel? initViewModel() {
    return ForgetPasswordViewModel(
      resetPasswordUseCase: injectResetPasswordUseCase()
    );
  }
}
