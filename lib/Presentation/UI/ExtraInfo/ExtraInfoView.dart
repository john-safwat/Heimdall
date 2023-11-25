import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/UpdateUserDataUseCase.dart';
import 'package:heimdall/Domain/UseCase/UploadUserImageUseCase.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoViewModel.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ExtraInfoView extends StatefulWidget {
  static const String routeName = "ExtraInfo";

  MyUser user;
  ExtraInfoView({required this.user, super.key});

  @override
  State<ExtraInfoView> createState() => _ExtraInfoViewState();
}

class _ExtraInfoViewState extends BaseState<ExtraInfoView, ExtraInfoViewModel>
    implements ExtraInfoNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<ExtraInfoViewModel>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: Text(value.local!.completeProfile),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Row(),
                          // hello user message
                          Text(
                            '${value.local!.hello} ${value.user.name.split(" ")[0]}',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const   SizedBox(height: 10,),
                          // we need to know more about you message
                          Text(
                            value.local!.weNeedToKnowMoreAboutYou,
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                          const   SizedBox(height: 20,),
                          // the button to open bottom sheet
                          InkWell(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            onTap: value.showModalBottomSheet,
                            child: Container(
                              width:value.mediaQuery!.width - 40,
                              height: value.mediaQuery!.width - 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              // image and title
                              child: value.image == null?Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset(value.getLogo()),
                                    const SizedBox(height: 10,),
                                    Text(value.local!.pickYourImage , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),)
                                  ],
                                ),
                              ):ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                  child: Image.file(File(value.image!.path) , fit: BoxFit.cover,)
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          // the text from field for the phone Number
                          Form(
                            key: value.formKey,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.bodyLarge,
                              controller: value.phoneController,
                              validator: (value) {
                                return viewModel!.phoneValidation(value ?? "");
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
                          ),
                          const SizedBox(height: 15,),
                          // Date Picker
                          InkWell(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            onTap: value.showDatePicker,
                            child: Container(
                              padding:const EdgeInsets.symmetric(horizontal: 5 , vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(width: 2 , color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    EvaIcons.calendar,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(value.selectedDate , style: Theme.of(context).textTheme.bodyLarge,)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          // drop down to select the gender
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2 , color: Theme.of(context).primaryColor)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              // Initial Value
                              value: value.selectedGender,
                              style: Theme.of(context).textTheme.titleMedium,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                              // Down Arrow Icon
                              icon: Icon(EvaIcons.arrow_down , color: Theme.of(context).primaryColor,),
                              // Array list of items
                              items: value.genders.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(items),
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (gender) => value.changeSelectedGender(gender??"none"),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          ElevatedButton(
                            onPressed: value.updateAccount,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(value.local!.completeProfile),
                                ],
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  ExtraInfoViewModel? initViewModel() {
    return ExtraInfoViewModel(
      updateUserDataUseCase: injectUpdateUserDataUseCase(),
      uploadUserImageUseCase: injectUploadUserImageUseCase()
    );
  }

  @override
  showMyDatePicker() async{
    viewModel!.changeDate(await showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      barrierDismissible: false,
      currentDate: DateTime.now(),

    ));
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }


}
