import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/app_colors.dart';

import '../../providers/appconfigprovider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
                //change language to english
                provider.changelanguage("en");
              },
              child: provider.applanguage == "en"
                  ? getSelectedItem(AppLocalizations.of(context)!.english)
                  : getUnSelectedItem(AppLocalizations.of(context)!.english),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                //change language to arabic
                provider.changelanguage("ar");
              },
              child: provider.applanguage == "ar"
                  ? getSelectedItem(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItem(AppLocalizations.of(context)!.arabic),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
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

  Widget getUnSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
