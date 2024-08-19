import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/home/home_settings/themebottomsheet.dart';

import '../../providers/appconfigprovider.dart';
import 'languagebottomsheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.WhiteColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.PrimaryColor)),
            child: InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.applanguage == "en"
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.WhiteColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.PrimaryColor)),
            child: InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.apptheme == ThemeMode.light
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
