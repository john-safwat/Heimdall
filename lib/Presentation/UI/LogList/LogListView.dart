import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetAllLogsUseCase.dart';
import 'package:heimdall/Presentation/UI/LogList/LogListNavigator.dart';
import 'package:heimdall/Presentation/UI/LogList/LogListViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LogListView extends StatefulWidget {
  static const String routeName = "LogList";
  LockCard? card;

  LogListView({this.card, super.key});

  @override
  State<LogListView> createState() => _LogListViewState();
}

class _LogListViewState extends BaseState<LogListView, LogListViewModel>
    implements LogListNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadLogsData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.log),
          ),
          body: Consumer<LogListViewModel>(
            builder: (context, value, child) {
              if (viewModel.errorMessage != null) {
                return ErrorMessageWidget(
                    errorMessage: viewModel.errorMessage!,
                    fixErrorFunction: viewModel.loadLogsData);
              } else if (viewModel.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (viewModel.logs.isEmpty) {
                return Column(
                  children: [
                    Expanded(child: Lottie.asset(viewModel.getAnimation())),
                  ],
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => viewModel.loadLogsData(),
                  backgroundColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${viewModel.local!.openedBy} : ${viewModel.logs[index].userName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor)),
                                const SizedBox(height: 12,),

                                Text("${viewModel.local!.openedUsing} : ${viewModel.logs[index].method}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor)),

                                const SizedBox(height: 12,),
                                Text("${viewModel.local!.user} : ${viewModel.logs[index].uid}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor)),

                                const SizedBox(height: 12,),
                                Row(
                                  children: [
                                    Text(viewModel.local!.at,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor)),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          viewModel.logs[index].timeOpened.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: viewModel.logs.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  LogListViewModel initViewModel() {
    return LogListViewModel(
        card: widget.card!, getAllLogsUseCase: injectGetAllLogsUseCase());
  }
}
