import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/UpdateUserDataUseCase.dart';
import 'package:heimdall/Domain/UseCase/UploadUserImageUseCase.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:heimdall/Presentation/UI/Widgets/ImagePIckLocationModalBottomSheetWidget.dart';
import 'package:intl/intl.dart';

class ExtraInfoViewModel extends BaseViewModel<ExtraInfoNavigator> {

  UploadUserImageUseCase uploadUserImageUseCase;
  UpdateUserDataUseCase updateUserDataUseCase;
  ExtraInfoViewModel({required this.updateUserDataUseCase , required this.uploadUserImageUseCase});

  late MyUser user;

  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  List<String> genders = ["none" , "Male" , "Female"];
  String selectedGender = 'none';

  DateTime birthDate = DateTime.now();
  late String selectedDate = local!.birthDate;

  // function to return the logo by the theme
  String getLogo(){
    var theme = themeProvider!.getTheme();

    if(theme == MyTheme.blackAndWhiteTheme){
      return "assets/SVG/IconLogoBlack.svg";
    }else if(theme == MyTheme.purpleAndWhiteTheme){
      return "assets/SVG/IconLogoBlack.svg";
    }else if(theme == MyTheme.darkPurpleTheme){
      return "assets/SVG/IconLogoDarkPurple.svg";
    }else {
      return "assets/SVG/IconLogoBlue.svg";
    }
  }

  // validation function
  // mobile validation function to check for the phone number
  String? phoneValidation(String value) {
    if (value.isEmpty) {
      return local!.enterPhoneNumber;
    }
    else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return local!.enterValidMobileNumber;
    }
    return null;
  }

  // change Date function
  changeDate(DateTime? dateTime){
    if(dateTime != null){
      birthDate = dateTime;
      selectedDate = DateFormat("yMMMMd").format(dateTime);
      notifyListeners();
    }
  }

  // function to change the selected gender
  changeSelectedGender(String gender){
    selectedGender = gender;
    notifyListeners();
  }

  // function to show modal bottom sheet of the image picker
  showModalBottomSheet(){
    navigator!.showCustomModalBottomSheet(widget: ImagePickLocationModalBottomSheetWidget(
        title: local!.pickYourImagePickingMethod,
        cameraTitle: local!.camera,
        galleryTitle: local!.gallery,
        openCamera: pickImageFromCamera,
        openGallery: pickImageFromGallery));
  }

  // function to show date picker
  showDatePicker(){
    navigator!.showMyDatePicker();
  }

  // function to go to login screen
  goToLoginScreen(){
    navigator!.goToLoginScreen();
  }

  // function to update user data
  updateAccount()async{
    if(selectedDate == local!.birthDate){
      navigator!.showFailMessage(message:local!.selectYourBirthDate , posActionTitle: local!.ok , posAction: showDatePicker);
      return;
    }
    if(selectedGender == "none"){
      navigator!.showFailMessage(message:local!.selectYourGender , posActionTitle: local!.ok );
      return;
    }
    if (formKey.currentState!.validate()){
      navigator!.showLoading(message: local!.loading);
      user.birthDate = birthDate.toString();
      user.phoneNumber = phoneController.text;
      user.gender = selectedGender;
      try{
        // if the image is not null upload the image and update app config Provider  
        if(image != null){
          var response = await uploadUserImageUseCase.invoke(image: image!);
          user.image = response.photoURL??"";
          appConfigProvider!.updateUser(user: response);
        }
        await updateUserDataUseCase.invoke(user: user, currentUser: appConfigProvider!.getUser()!);
        navigator!.goBack();
        navigator!.showSuccessMessage(message: local!.accountCompletedSuccessfully , posActionTitle: local!.ok , posAction: goToLoginScreen);
      }catch (e){
        // show fail dialog
        navigator!.goBack();
        navigator!.showFailMessage(message: handleErrorMessage(e as Exception) , negativeActionTitle: local!.tryAgain);
      }
      
    }
  }

}