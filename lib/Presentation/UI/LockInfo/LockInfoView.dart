import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLockModelUseCase.dart';
import 'package:heimdall/Presentation/UI/LockInfo/LockInfoNavigator.dart';
import 'package:heimdall/Presentation/UI/LockInfo/LockInfoViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:provider/provider.dart';

class LockInfoView extends StatefulWidget {
  static const String routeName = "lockInfo";
  LockCard? lockCard;

  LockInfoView({super.key, this.lockCard});

  @override
  State<LockInfoView> createState() => _LockInfoViewState();
}

class _LockInfoViewState extends BaseState<LockInfoView, LockInfoViewModel>
    implements LockInfoNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.lockInfo),
          ),
          body: Consumer<LockInfoViewModel>(
            builder: (context, value, child) {
              if (viewModel.errorMessage != null) {
                return ErrorMessageWidget(
                    errorMessage: viewModel.errorMessage!,
                    fixErrorFunction: viewModel.loadData);
              } else if (viewModel.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    CachedNetworkImage(
                      imageUrl: viewModel.model.image ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        child: Column(
                          children: [
                            Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${viewModel.local!.modelName} : ${viewModel.model.name}" ??
                                  "lock",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                            ),
                          ],
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        viewModel.getIcon(),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      viewModel.local!.components,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) => InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        onTap: (){
                          viewModel.onComponentClick(viewModel.model.components![index]);
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  viewModel.model.components![index].image ?? "",
                              imageBuilder: (context, imageProvider) => Container(
                                padding: const EdgeInsets.all(10),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2,
                                        color: Theme.of(context).primaryColor)),
                                child: Image(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                viewModel.getIcon(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              placeholder: (context, url) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.7),
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: Text(
                                viewModel.model.components![index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                            ))
                          ],
                        ),
                      ),
                      itemCount: viewModel.model.components!.length,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  LockInfoViewModel initViewModel() {
    return LockInfoViewModel(
        lockCard: widget.lockCard!,
        getLockModelUseCase: injectGetLockModelUseCase());
  }

  @override
  showCustomModalBottomSheet({required Widget widget}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => widget,
    );
  }

}
