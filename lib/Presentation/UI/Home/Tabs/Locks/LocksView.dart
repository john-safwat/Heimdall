import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksViewModel.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LocksView extends StatefulWidget {
  const LocksView({super.key});

  @override
  State<LocksView> createState() => _LocksViewState();
}

class _LocksViewState extends BaseState<LocksView, LocksViewModel>
    implements LocksNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "${viewModel.local!.welcomeBack} "
                          "${viewModel.appConfigProvider?.user?.displayName?.split(" ").first}"
                          " 😊",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      viewModel.local!.weAreWatchingEveryThingForYou,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      controller: viewModel.searchController,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.text,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          EvaIcons.search,
                          size: 30,
                        ),
                        hintText: viewModel.local!.search,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: MyTheme.darkBlue,
                )
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:(){},
            child: const Icon(Bootstrap.qr_code_scan),
          ),
        ),
      ),
    );
  }

  @override
  LocksViewModel initViewModel() {
    return LocksViewModel();
  }
}
