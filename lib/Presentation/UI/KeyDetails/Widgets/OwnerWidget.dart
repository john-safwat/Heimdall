import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsViewModel.dart';
import 'package:provider/provider.dart';

class OwnerWidget extends StatelessWidget {
  const OwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    KeyDetailsViewModel provider = Provider.of<KeyDetailsViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: provider.key.ownerImage ?? "",
              width: 100,
              height: 120,
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: BoxFit.cover
              ),
              errorWidget: (context, url, error) => Image.asset(
                provider.getIcon(),
                fit: BoxFit.cover
              ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              children: [
                Text(
                  provider.key.ownerName!,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                Text(
                  provider.key.ownerId!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
