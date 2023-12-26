import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Feedback/Feedback.dart';
import 'package:heimdall/Domain/UseCase/SendFeedBackUseCase.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackNavigator.dart';

class FeedbackViewModel extends BaseViewModel<FeedbackNavigator>{

  SendFeedBackUseCase useCase;
  FeedbackViewModel({required this.useCase});

  TextEditingController controller = TextEditingController();

  double rating = 0;
  // function to update rating
  void changeRating(double newRating){
    rating = newRating;
    notifyListeners();
  }

  // function to validate on data
  String? feedbackValidation(String value) {
    return null;
  }

  sendFeedback()async{
    if(controller.text.isNotEmpty||rating>0){
      navigator!.showLoading(message: local!.loading);
      try{
        await useCase.invoke(
            feedback: Feedback(
                id : "",
                uid: appConfigProvider!.getUser()!.uid,
                message: controller.text,
                rating: rating,
                userName: appConfigProvider!.getUser()!.displayName??"No Name",
                userEmail: appConfigProvider!.getUser()!.email??"No Email",
                image: appConfigProvider!.getUser()!.photoURL??"No Photo"
            )
        );
        navigator!.goBack();
        controller.text = "";
        rating = 0;
        navigator!.showSuccessMessage(message: local!.feedbackSent, posActionTitle: local!.ok );
        notifyListeners();
      }catch (e){
        navigator!.goBack();
        navigator!.showFailMessage(
          message: handleErrorMessage(e as Exception),
          posActionTitle: local!.tryAgain,
        );
      }
    }else {
      navigator!.showErrorNotification(message: local!.feedbackAndRating);
    }
  }

}