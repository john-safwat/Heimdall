import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/GetLockUsersListUseCase.dart';
import 'package:heimdall/Presentation/UI/UsersList/UsersListNavigator.dart';
import 'package:heimdall/Presentation/UI/UsersList/UsersListViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:provider/provider.dart';

class UsersListView extends StatefulWidget {
  static const String routeName = "UserList";

  LockCard? card;

  UsersListView({this.card, super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends BaseState<UsersListView, UsersListViewModel>
    implements UsersListNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadUsersData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.usersList),
          ),
          body: Consumer<UsersListViewModel>(
            builder: (context, value, child) {
              if (viewModel.errorMessage != null) {
                return ErrorMessageWidget(
                    errorMessage: viewModel.errorMessage!,
                    fixErrorFunction: viewModel.loadUsersData);
              } else if (viewModel.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: MasonryView(
                    listOfItem: viewModel.users,
                    numberOfColumn: 2,
                    itemBuilder: (user) {
                      user = user as MyUser;
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: user.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    viewModel.getIcon(),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            Text(
                              user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                            const SizedBox(height: 12,),
                            Text(
                              user.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            )
                          ],
                        ),
                      );
                    },
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
  UsersListViewModel initViewModel() {
    return UsersListViewModel(
        card: widget.card!,
        getLockUsersListUseCase: injectGetLockUsersListUseCase());
  }
}
