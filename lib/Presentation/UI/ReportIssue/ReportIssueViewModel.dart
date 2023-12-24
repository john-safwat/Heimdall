import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Report/Report.dart';
import 'package:heimdall/Domain/UseCase/SendReportUseCase.dart';
import 'package:heimdall/Presentation/UI/ReportIssue/ReportIssueNavigator.dart';

class ReportIssueViewModel extends BaseViewModel<ReportIssueNavigator> {

  SendReportUseCase sendReportUseCase;

  ReportIssueViewModel({required this.sendReportUseCase});

  TextEditingController controller = TextEditingController();

  sendReport() async {
    if (controller.text.isNotEmpty) {
      navigator!.showLoading(message: local!.loading);
      try {
        var response = await sendReportUseCase.invoke(report: Report(
            id: "",
            message: controller.text,
            uid: appConfigProvider!.user!.uid,
            email: appConfigProvider!.user!.email??"None",
            dateTime: DateTime.now()));
        navigator!.goBack();
        controller.text= "";
        navigator!.showSuccessMessage(message: local!.reportSent+response.id , posActionTitle: local!.ok);
      }catch (e){
        navigator!.goBack();
        navigator!.showFailMessage(message: handleErrorMessage(e as Exception) , posActionTitle: local!.tryAgain);
      }
    }else {
      navigator!.showFailMessage(message: local!.reportCantBeEmpty , posActionTitle: local!.tryAgain);
    }
  }

}