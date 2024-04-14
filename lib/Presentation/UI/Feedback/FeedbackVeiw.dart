import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/SendFeedBackUseCase.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackNavigator.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackViewModel.dart';
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
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.feedback),
          ),
          body: Consumer<FeedbackViewModel>(
            builder:(context, value, child) => Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,),
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      const SizedBox(height: 20,),
                      Text(
                        viewModel.local!.feedbackBodyText,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      RatingBar.builder(
                        initialRating: viewModel.rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glowColor: Colors.amber,
                        maxRating: 5,
                        unratedColor: Colors.grey,
                        itemPadding:const EdgeInsets.symmetric(horizontal: 5.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          viewModel.changeRating(rating);
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        maxLines: 5,
                        controller: viewModel.controller,
                        decoration: InputDecoration(
                          hintText: viewModel.local!.yourFeedBack,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: () => viewModel.sendFeedback(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(viewModel.local!.sendYourFeedback),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  FeedbackViewModel initViewModel() {
    return FeedbackViewModel(
      useCase: injectSendFeedBackUseCase()
    );
  }
}
