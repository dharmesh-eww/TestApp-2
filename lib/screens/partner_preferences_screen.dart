import 'package:flutter/material.dart';

import 'biodata_session.dart';
import 'vivah_colors.dart';
import 'photo_contact_screen.dart';

class PartnerPreferencesScreen extends StatefulWidget {
  const PartnerPreferencesScreen({super.key, required this.templateName, required this.templateAccent});
  final String templateName;
  final Color templateAccent;

  @override
  State<PartnerPreferencesScreen> createState() => _PartnerPreferencesScreenState();
}

class _PartnerPreferencesScreenState extends State<PartnerPreferencesScreen> {
  bool _include = BiodataSession.includePartnerPreferences;
  late final TextEditingController _minAge = TextEditingController(text: BiodataSession.partnerMinAge);
  late final TextEditingController _maxAge = TextEditingController(text: BiodataSession.partnerMaxAge);
  late final TextEditingController _height = TextEditingController(text: BiodataSession.partnerHeight);
  late final TextEditingController _education = TextEditingController(text: BiodataSession.partnerEducation);
  late final TextEditingController _occupation = TextEditingController(text: BiodataSession.partnerOccupation);
  late final TextEditingController _location = TextEditingController(text: BiodataSession.partnerLocation);
  late final TextEditingController _notes = TextEditingController(text: BiodataSession.partnerNotes);
  String? _ageError;

  @override
  void dispose() { _minAge.dispose(); _maxAge.dispose(); _height.dispose(); _education.dispose(); _occupation.dispose(); _location.dispose(); _notes.dispose(); super.dispose(); }

  void _save() {
    BiodataSession.includePartnerPreferences = _include;
    BiodataSession.partnerMinAge = _minAge.text.trim();
    BiodataSession.partnerMaxAge = _maxAge.text.trim();
    BiodataSession.partnerHeight = _height.text.trim();
    BiodataSession.partnerEducation = _education.text.trim();
    BiodataSession.partnerOccupation = _occupation.text.trim();
    BiodataSession.partnerLocation = _location.text.trim();
    BiodataSession.partnerNotes = _notes.text.trim();
  }

  void _exit() {
    _save(); BiodataSession.save();
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft saved for this app session.')));
  }

  void _continue() {
    final minText = _minAge.text.trim();
    final maxText = _maxAge.text.trim();
    final min = int.tryParse(minText);
    final max = int.tryParse(maxText);
    if (_include && (minText.isNotEmpty || maxText.isNotEmpty) &&
        (min == null || max == null || min < 18 || max > 100 || min > max)) {
      setState(() => _ageError = min != null && max != null && min > max
          ? 'Minimum age must not exceed maximum age.'
          : 'Enter a valid age range from 18 to 100, or leave both blank.');
      return;
    }
    setState(() => _ageError = null);
    _save();
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => PhotoContactScreen(templateName: widget.templateName, templateAccent: widget.templateAccent)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: VivahColors.ivory,
    body: SafeArea(child: Column(children: [
      _PartnerHeader(templateName: widget.templateName, onBack: () { _save(); Navigator.pop(context); }),
      Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(22, 4, 22, 24), children: [
        const Text('Partner preferences', style: TextStyle(color: VivahColors.plumDark, fontSize: 27, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Share preferences only if you’d like them included.', style: TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.4)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: VivahColors.border)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              activeColor: VivahColors.plum,
              title: const Text('Include partner preferences', style: TextStyle(color: VivahColors.ink, fontSize: 14, fontWeight: FontWeight.w700)),
              subtitle: const Text('Off by default. Your preferences stay out of the biodata unless you opt in.', style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.4)),
              value: _include,
              onChanged: (value) => setState(() => _include = value),
            ),
            AnimatedOpacity(
              opacity: _include ? 1 : .48,
              duration: const Duration(milliseconds: 180),
              child: IgnorePointer(
                ignoring: !_include,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 12),
                  const Text('PREFERRED AGE RANGE', style: TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.1)),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(child: _AgeField(label: 'Minimum age', controller: _minAge, onChanged: (_) => setState(() => _ageError = null))),
                    const SizedBox(width: 12),
                    Expanded(child: _AgeField(label: 'Maximum age', controller: _maxAge, onChanged: (_) => setState(() => _ageError = null))),
                  ]),
                  if (_ageError != null) Padding(padding: const EdgeInsets.only(top: 7), child: Text(_ageError!, style: const TextStyle(color: Colors.red, fontSize: 12))),
                  const SizedBox(height: 18),
                  _label('Preferred height range'),
                  _field(_height, 'e.g. 5 ft 2 in – 6 ft'),
                  const SizedBox(height: 16),
                  _label('Education preference'),
                  _field(_education, 'e.g. Any / Bachelor’s degree'),
                  const SizedBox(height: 16),
                  _label('Occupation preference'),
                  _field(_occupation, 'Optional'),
                  const SizedBox(height: 16),
                  _label('Preferred location'),
                  _field(_location, 'City, state or region'),
                  const SizedBox(height: 16),
                  _label('Anything else?'),
                  TextField(controller: _notes, maxLength: 400, minLines: 3, maxLines: 5, textCapitalization: TextCapitalization.sentences, decoration: _input('Keep it respectful and specific to your needs')),
                ]),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 14),
        const Text('Preferences are personal choices, not a compatibility score. You can change them or leave them out.', style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.45)),
      ])),
      _PartnerFooter(onSave: _exit, onContinue: _continue),
    ])),
  );
}

class _PartnerHeader extends StatelessWidget {
  const _PartnerHeader({required this.templateName, required this.onBack});
  final String templateName; final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 8, 18, 14),
    child: Column(children: [
      Row(children: [IconButton(tooltip: 'Back', onPressed: onBack, icon: const Icon(Icons.arrow_back_rounded, color: VivahColors.plumDark)), const Expanded(child: Text('Create biodata', style: TextStyle(color: VivahColors.plumDark, fontSize: 19, fontWeight: FontWeight.w800))), Flexible(child: Text(templateName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: VivahColors.plum, fontSize: 11, fontWeight: FontWeight.w700)))]),
      const SizedBox(height: 7),
      const Row(children: [Text('STEP 4 OF 5', style: TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)), Spacer(), Text('80% complete', style: TextStyle(color: VivahColors.muted, fontSize: 11))]),
      const SizedBox(height: 7),
      ClipRRect(borderRadius: BorderRadius.circular(8), child: const LinearProgressIndicator(value: .8, minHeight: 5, backgroundColor: VivahColors.border, color: VivahColors.plum)),
    ]),
  );
}
class _PartnerFooter extends StatelessWidget {
  const _PartnerFooter({required this.onSave, required this.onContinue});
  final VoidCallback onSave, onContinue;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.fromLTRB(22, 12, 22, 14), decoration: const BoxDecoration(color: VivahColors.ivory, border: Border(top: BorderSide(color: VivahColors.border))), child: Row(children: [
    Expanded(child: OutlinedButton(onPressed: onSave, style: OutlinedButton.styleFrom(foregroundColor: VivahColors.plum, padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: VivahColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Save & Exit'))),
    const SizedBox(width: 12),
    Expanded(flex: 2, child: FilledButton(onPressed: onContinue, style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Continue'), SizedBox(width: 8), Icon(Icons.arrow_forward_rounded, size: 17)]))),
  ]));
}
class _AgeField extends StatelessWidget {
  const _AgeField({required this.label, required this.controller, required this.onChanged});
  final String label; final TextEditingController controller; final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: VivahColors.ink, fontSize: 12, fontWeight: FontWeight.w700)), const SizedBox(height: 7), TextField(controller: controller, keyboardType: TextInputType.number, onChanged: onChanged, decoration: _input('Age').copyWith(prefixIcon: const Icon(Icons.cake_outlined, size: 18)))]);
}
Widget _label(String value) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text(value, style: const TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w700)));
Widget _field(TextEditingController c, String hint) => TextField(controller: c, textCapitalization: TextCapitalization.words, decoration: _input(hint));
InputDecoration _input(String hint) => InputDecoration(hintText: hint, filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15), border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: VivahColors.border)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: VivahColors.border)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: VivahColors.plum, width: 1.5)));
