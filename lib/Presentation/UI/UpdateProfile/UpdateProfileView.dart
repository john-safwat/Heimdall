import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _UpdateProfileViewState
    extends BaseState<UpdateProfileView, UpdateProfileViewModel>
    implements UpdateProfileNavigator {
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
        body:
            Consumer<UpdateProfileViewModel>(builder: (context, value, child) {
          if (value.errorMessage != null) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(),
                    Lottie.asset("assets/animations/error.json",
                        width: viewModel!.mediaQuery!.width * 0.5),
                    const SizedBox(height: 40),
                    Text(
                      value.errorMessage!,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    )
                  ],
                ));
          } else if (value.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // the button to open bottom sheet
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: value.showModalBottomSheet,
                  child: Container(
                    width: value.mediaQuery!.width - 40,
                    height: value.mediaQuery!.width - 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    // image and title
                    child: value.image == null
                        ? Container(
                            width: value.mediaQuery!.width - 40,
                            height: value.mediaQuery!.width - 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: value.user!.image,
                              imageBuilder: (context, imageProvider) => Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        width: double.infinity,
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned.fill(
                                      child: Container(
                                    padding: const EdgeInsets.all(15),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.1),
                                              Theme.of(context).primaryColor,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      value.local!.tabToPickImage,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                                ],
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SvgPicture.asset(value.getLogo()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    value.local!.pickYourImage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                  )
                                ],
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File(value.image!.path),
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  @override
  UpdateProfileViewModel? initViewModel() {
    return UpdateProfileViewModel(
        getUserDataUseCase: injectGetUserDataUseCase());
  }
}
