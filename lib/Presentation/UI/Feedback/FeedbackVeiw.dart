import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackNavigator.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ProfileButton.dart';

import 'package:provider/provider.dart';

class FeedbackView extends StatefulWidget {
  static const String routeName = "Feedback";
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends BaseState<FeedbackView, FeedbackViewModel>
    implements FeedbackNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel!.local!.feedback),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                viewModel!.local!.feedbackBodyText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: viewModel!.local!.yourFeedBack,
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileButton(todo: (){}, lable: viewModel!.local!.sendYourFeedback,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  FeedbackViewModel? initViewModel() {
    return FeedbackViewModel();
  }
}
