import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateUserDataUseCase.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileNavigator.dart';
import 'package:intl/intl.dart';

class UpdateProfileViewModel extends BaseViewModel<UpdateProfileNavigator> {
  GetUserDataUseCase getUserDataUseCase;
  UpdateUserDataUseCase updateUserDataUseCase;

  UpdateProfileViewModel(
      {required this.getUserDataUseCase, required this.updateUserDataUseCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> genders = ["none", "Male", "Female"];
  String selectedGender = 'none';

  DateTime birthDate = DateTime.now();
  late String selectedDate = local!.birthDate;

  MyUser? user;
  String? errorMessage;

  // function to update user
  loadUserData() async {
    user = null;
    errorMessage = null;
    notifyListeners();

    try {
      user = await getUserDataUseCase.invoke(uid: appConfigProvider!.user!.uid);
      nameController.text = user!.name;
      phoneController.text = user!.phoneNumber;
      selectedGender = user!.gender;
      selectedDate =
          DateFormat("yMMMMd").format(DateTime.parse(user!.birthDate));
      notifyListeners();
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }
  }

  // function to show modal bottom sheet of the image picker
  showModalBottomSheet() {
    navigator!.showImagePickerModalBottomSheet();
  }

  // function to return the logo by the theme
  String getLogo() {
    var theme = themeProvider!.getTheme();

    if (theme == MyTheme.blackAndWhiteTheme) {
      return "assets/SVG/IconLogoBlack.svg";
    } else if (theme == MyTheme.purpleAndWhiteTheme) {
      return "assets/SVG/IconLogoBlack.svg";
    } else if (theme == MyTheme.darkPurpleTheme) {
      return "assets/SVG/IconLogoDarkPurple.svg";
    } else {
      return "assets/SVG/IconLogoBlue.svg";
    }
  }

  // validation function
  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name) {
    if (name.isEmpty) {
      return local!.nameCantBeEmpty;
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)) {
      return local!.invalidName;
    } else {
      return null;
    }
  }

  // mobile validation function to check for the phone number
  String? phoneValidation(String value) {
    if (value.isEmpty) {
      return local!.enterPhoneNumber;
    } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return local!.enterValidMobileNumber;
    }
    return null;
  }

  // change Date function
  changeDate(DateTime? dateTime) {
    if (dateTime != null) {
      birthDate = dateTime;
      selectedDate = DateFormat("yMMMMd").format(dateTime);
      notifyListeners();
    }
  }

  // function to change the selected gender
  changeSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  // function to show date picker
  showDatePicker() {
    navigator!.showMyDatePicker();
  }

  //function to update user data
  updateUserData() async {
    if (selectedDate == local!.birthDate) {
      navigator!.showFailMessage(
          message: local!.selectYourBirthDate,
          posActionTitle: local!.ok,
          posAction: showDatePicker);
      return;
    }
    if (selectedGender == "none") {
      navigator!.showFailMessage(
          message: local!.selectYourGender, posActionTitle: local!.ok);
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        navigator!.showLoading(message: local!.loading);
        user!.name = nameController.text;
        user!.birthDate = birthDate.toString();
        user!.phoneNumber = phoneController.text;
        user!.gender = selectedGender;
        var response = await updateUserDataUseCase.invoke(
            user: user!,
            currentUser: appConfigProvider!.getUser()!,
            file: image);
        appConfigProvider!.updateUser(user: response);
        navigator!.goBack();
        navigator!.showSuccessMessage(
            message: local!.accountUpdated,
            posActionTitle: local!.ok,
            );
      } catch (e) {
        navigator!.goBack();
        navigator!.showFailMessage(
            message: handleErrorMessage(e as Exception),
            negativeActionTitle: local!.tryAgain);
      }
    }
  }
}
