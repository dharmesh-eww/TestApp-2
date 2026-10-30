import 'package:flutter/material.dart';

import '../localization/app_language.dart';
import 'vivah_colors.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({
    super.key,
    this.isInitial = false,
    this.onSelected,
  });

  final bool isInitial;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLanguageController.locale,
      builder: (context, selectedLocale, _) => Scaffold(
        backgroundColor: VivahColors.ivory,
        appBar: AppBar(
          backgroundColor: VivahColors.ivory,
          foregroundColor: VivahColors.plumDark,
          elevation: 0,
          automaticallyImplyLeading: !isInitial,
          title: const Text(
            'Choose your language',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(22, 8, 22, 18),
                child: Text(
                  'Select the language you want to use in Vivah Bio.',
                  style: TextStyle(color: VivahColors.muted, fontSize: 14, height: 1.5),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
                  itemCount: AppLanguage.supported.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 9),
                  itemBuilder: (context, index) {
                    final language = AppLanguage.supported[index];
                    final selected = language.locale.languageCode == selectedLocale.languageCode;
                    return Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () async {
                          await AppLanguageController.select(language.locale);
                          if (!context.mounted) return;
                          if (onSelected != null) {
                            onSelected!();
                          } else if (!isInitial) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selected ? VivahColors.plum : VivahColors.border,
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      language.nativeName,
                                      style: const TextStyle(
                                        color: VivahColors.plumDark,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      language.englishName,
                                      style: const TextStyle(
                                        color: VivahColors.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (selected)
                                const Icon(Icons.check_circle_rounded, color: VivahColors.plum)
                              else
                                const Icon(Icons.circle_outlined, color: VivahColors.border),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (isInitial)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: AppLanguageController.hasSelectedLanguage.value
                          ? onSelected
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: VivahColors.plum,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
