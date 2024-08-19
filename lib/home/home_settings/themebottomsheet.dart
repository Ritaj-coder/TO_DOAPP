import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../providers/appconfigprovider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                provider.changemode(ThemeMode.light);
              },
              child: provider.apptheme == ThemeMode.light
                  ? getSelectedTheme(AppLocalizations.of(context)!.light)
                  : getUnSelectedTheme(AppLocalizations.of(context)!.light),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                provider.changemode(ThemeMode.dark);
              },
              child: provider.apptheme == ThemeMode.dark
                  ? getSelectedTheme(AppLocalizations.of(context)!.dark)
                  : getUnSelectedTheme(AppLocalizations.of(context)!.dark),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedTheme(String mymode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mymode,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.PrimaryColor),
        ),
        Icon(
          Icons.check,
          size: 30,
          color: AppColors.PrimaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedTheme(String mymode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(mymode, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
