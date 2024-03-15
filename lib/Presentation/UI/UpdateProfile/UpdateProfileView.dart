import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateUserDataUseCase.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileNavigator.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:icons_plus/icons_plus.dart';
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
    viewModel.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.local!.updateProfile),
        ),
        body:
            Consumer<UpdateProfileViewModel>(builder: (context, value, child) {
          if (value.errorMessage != null) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: value.loadUserData
              ),
            );
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
                                    child: Text(value.local!.tabToPickImage,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                        textAlign: TextAlign.center),
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
                                  ),
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
                const SizedBox(height: 20),
                Form(
                  key: value.formKey,
                  child: Column(
                    children: [
                      // the text from field for the name
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge,
                        controller: value.nameController,
                        validator: (value) {
                          return viewModel.nameValidation(value ?? "");
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.name,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            EvaIcons.person,
                            size: 30,
                          ),
                          hintText: value.local!.name,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge,
                        controller: value.phoneController,
                        validator: (value) {
                          return viewModel.phoneValidation(value ?? "");
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.phone,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            EvaIcons.phone,
                            size: 30,
                          ),
                          hintText: value.local!.phone,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Date Picker
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: value.showDatePicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Icon(
                                EvaIcons.calendar,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                value.selectedDate,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // drop down to select the gender
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(),
                          // Initial Value
                          value: value.selectedGender,
                          style: Theme.of(context).textTheme.titleMedium,
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          // Down Arrow Icon
                          icon: Icon(
                            EvaIcons.arrow_down,
                            color: Theme.of(context).primaryColor,
                          ),
                          // Array list of items
                          items: value.genders.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(items),
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (gender) =>
                              value.changeSelectedGender(gender ?? "none"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: viewModel.updateUserData,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(value.local!.updateProfile),
                              ],
                            ),
                          ))
                    ],
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
  UpdateProfileViewModel initViewModel() {
    return UpdateProfileViewModel(
        getUserDataUseCase: injectGetUserDataUseCase(),
        updateUserDataUseCase: injectUpdateUserDataUseCase());
  }

  @override
  showMyDatePicker() async {
    viewModel.changeDate(await showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      barrierDismissible: false,
      currentDate: DateTime.now(),
    ));
  }
}
