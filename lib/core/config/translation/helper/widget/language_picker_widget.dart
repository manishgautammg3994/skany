import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/servicelocator.dart';
import '../../provider/locale_provider.dart';
import '../l10n.dart';

class LanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Get.locale; // or  Localizations.localeOf(context);
    final flag = L10n.getFlag(locale!.languageCode);

    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 72,
        child: Text(
          flag,
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}

class LanguagePickerWidget extends StatelessWidget {
  //provider
  static LocaleProvider get provider => ServiceLocator.get<LocaleProvider>();
  @override
  Widget build(BuildContext context) {
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: L10n.all.map(
          (locale) {
            final flag = L10n.getFlag(locale.languageCode);

            return DropdownMenuItem(
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              value: locale,
              onTap: () {
                // final provider = Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(locale.countryCode!);
              },
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
