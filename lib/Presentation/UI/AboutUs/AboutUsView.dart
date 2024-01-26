import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsNavigator.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsViewModel.dart';
import 'package:heimdall/Presentation/UI/AboutUs/Widgets/TextCard.dart';

import 'package:provider/provider.dart';

class AboutUsView extends StatefulWidget {
  static const String routeName = "AboutUs";

  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends BaseState<AboutUsView, AboutUsViewModel>
    implements AboutUsNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.local!.aboutUs),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                viewModel.local!.applicationVersion,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
            const SizedBox(height: 20),
            Text(viewModel.local!.aboutUs1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(viewModel.local!.aboutUs2,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            TextCard(content: viewModel.local!.aboutUs3),
            const SizedBox(height: 20),
            Text(viewModel.local!.aboutUs4,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 30),
            TextCard(content: viewModel.local!.aboutUs5),
            const SizedBox(height: 20),
            Text(
              viewModel.local!.aboutUs6,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                    child: Text(viewModel.local!.aboutUs7,
                        style: Theme.of(context).textTheme.bodyLarge)),
              ],
            ),
            const SizedBox(height: 20),
            TextCard(content: viewModel.local!.aboutUs8),
            const SizedBox(height: 20),
            Text(viewModel.local!.aboutUs9,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 30),
            TextCard(content: viewModel.local!.developmentTeam),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/team.png"),
            ),
            const SizedBox(height: 20),
            TextCard(content: viewModel.local!.supervisedByDrGoudaIsmail),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.johnSafwat),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.abdelrahmanMosaad),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.dawoudElsabah),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.sherifSayed),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.ahmedYassen),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.mohamedMaher),
            const SizedBox(height: 8),
            TextCard(content: viewModel.local!.mohammedMahmoud),
          ],
        ),
      ),
    );
  }

  @override
  AboutUsViewModel initViewModel() {
    return AboutUsViewModel();
  }
}
