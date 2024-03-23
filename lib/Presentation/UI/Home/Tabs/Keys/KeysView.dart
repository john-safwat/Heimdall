import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/UseCase/GetKeysUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Keys/KeysNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Keys/KeysViewModel.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsView.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/KeyCardWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class KeysView extends StatefulWidget {
  const KeysView({super.key});

  @override
  State<KeysView> createState() => _KeysViewState();
}

class _KeysViewState extends BaseState<KeysView, KeysViewModel>
    implements KeysNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadKeysData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).scaffoldBackgroundColor,
        onRefresh: () async {
          return viewModel.loadKeysData();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: viewModel.searchController,
                style: Theme.of(context).textTheme.bodyLarge,
                onChanged: (value) => viewModel.search(),
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
              Consumer<KeysViewModel>(
                builder: (context, value, child) {
                  if (value.errorMessage != null) {
                    return ErrorMessageWidget(
                        errorMessage: value.errorMessage!,
                        fixErrorFunction: value.loadKeysData);
                  } else if (value.loading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (value.keysList.isEmpty) {
                    return Lottie.asset(viewModel.getAnimation());
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        padding:const EdgeInsets.symmetric(vertical: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.8),
                        itemBuilder: (context, index) =>
                            KeyCardWidget(
                              myKey: viewModel.keysList[index],
                              onClick: viewModel.onCardClick,
                            ),
                        itemCount: viewModel.keysList.length,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  KeysViewModel initViewModel() {
    return KeysViewModel(getKeysUseCase: injectGetKeysUseCase());
  }

  @override
  goToKeyDetailsScreen(EKey key) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KeyDetailsView(myKey: key),
        ));
  }
}
