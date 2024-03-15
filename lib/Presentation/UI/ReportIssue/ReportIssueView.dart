import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/SendReportUseCase.dart';
import 'package:heimdall/Presentation/UI/ReportIssue/ReportIssueNavigator.dart';
import 'package:heimdall/Presentation/UI/ReportIssue/ReportIssueViewModel.dart';

import 'package:provider/provider.dart';

class ReportIssueView extends StatefulWidget {
  static const String routeName = "ReportIssue";
  const ReportIssueView({super.key});

  @override
  State<ReportIssueView> createState() => _ReportIssueViewState();
}

class _ReportIssueViewState extends BaseState<ReportIssueView , ReportIssueViewModel> implements ReportIssueNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text(viewModel.local!.report,),),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(viewModel.local!.weAreHereToHelp,style: Theme.of(context).textTheme.titleLarge ,textAlign: TextAlign.center,),
            const SizedBox(
              height: 20,
            ),
            Text(viewModel.local!.reportBodyText,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.justify,),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 5,
              controller: viewModel.controller,
              decoration: InputDecoration(
                hintText: viewModel.local!.yourReport,
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => viewModel.sendReport(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(viewModel.local!.sendYourReport),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  ReportIssueViewModel initViewModel() {
    return ReportIssueViewModel(
      sendReportUseCase: injectSendReportUseCase()
    );
  }
}