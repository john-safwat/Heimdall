import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileNavigator.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  static const String routeName = "updateProfile";
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends BaseState<UpdateProfileView , UpdateProfileViewModel> implements UpdateProfileNavigator{

  @override
  void initState() {
    super.initState();
    viewModel!.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel!.local!.updateProfile),
        ),
        body: Consumer<UpdateProfileViewModel>(
          builder: (context, value, child) {
            if(value.errorMessage!=null){
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(),
                      Lottie.asset("assets/animations/error.json" , width: viewModel!.mediaQuery!.width *0.5),
                      const SizedBox(height: 40),
                      Text(value.errorMessage! , style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,)
                    ],
                  )
              );
            }else if (value.user == null){
              return const Center(child: CircularProgressIndicator(),);
            }else {
              return ListView(
                children: [

                ],
              );
            }
          }
        ),
      ),
    );
  }

  @override
  UpdateProfileViewModel? initViewModel() {
    return UpdateProfileViewModel(
      getUserDataUseCase: injectGetUserDataUseCase()
    );
  }
}
