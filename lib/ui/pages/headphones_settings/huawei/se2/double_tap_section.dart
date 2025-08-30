import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../headphones/framework/headphones_settings.dart';
import '../../../../../headphones/huawei/settings.dart';

class DoubleTapSection extends StatelessWidget {
  final HeadphonesSettings<HuaweiFreeBudsSE2Settings> headphones;

  const DoubleTapSection(this.headphones, {super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return StreamBuilder<HuaweiFreeBudsSE2Settings>(
      stream: headphones.settings,
      builder: (context, snapshot) {
        final settingsValue = snapshot.data;
        if (settingsValue == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l.pageHeadphonesSettingsDoubleTap,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
                         ListTile(
               title: Text(l.pageHeadphonesSettingsLeftBud),
               trailing: DropdownButton<DoubleTap>(
                value: settingsValue.doubleTapLeft,
                onChanged: (value) {
                  if (value != null) {
                    headphones.setSettings(
                      settingsValue.copyWith(doubleTapLeft: value),
                    );
                  }
                },
                items: DoubleTap.values.map((tap) {
                  return DropdownMenuItem(
                    value: tap,
                    child: Text(_getDoubleTapText(tap, l)),
                  );
                }).toList(),
              ),
            ),
                         ListTile(
               title: Text(l.pageHeadphonesSettingsRightBud),
               trailing: DropdownButton<DoubleTap>(
                value: settingsValue.doubleTapRight,
                onChanged: (value) {
                  if (value != null) {
                    headphones.setSettings(
                      settingsValue.copyWith(doubleTapRight: value),
                    );
                  }
                },
                items: DoubleTap.values.map((tap) {
                  return DropdownMenuItem(
                    value: tap,
                    child: Text(_getDoubleTapText(tap, l)),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

     String _getDoubleTapText(DoubleTap tap, AppLocalizations l) {
     return switch (tap) {
       DoubleTap.nothing => l.pageHeadphonesSettingsDoubleTapNone,
       DoubleTap.voiceAssistant => l.pageHeadphonesSettingsDoubleTapAssist,
       DoubleTap.playPause => l.pageHeadphonesSettingsDoubleTapPlayPause,
       DoubleTap.next => l.pageHeadphonesSettingsDoubleTapNextSong,
       DoubleTap.previous => l.pageHeadphonesSettingsDoubleTapPrevSong,
     };
   }
}
