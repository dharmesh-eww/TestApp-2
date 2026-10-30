import 'package:flutter/material.dart';

import 'vivah_colors.dart';
import 'personal_details_screen.dart';
import 'biodata_session.dart';
import 'education_career_screen.dart';

class FamilyDetailsDraft {
  const FamilyDetailsDraft({
    this.fatherName = '',
    this.fatherOccupation = '',
    this.motherName = '',
    this.motherOccupation = '',
    this.brothers = 0,
    this.sisters = 0,
    this.familyType,
    this.familyValues,
    this.familyBackground = '',
  });

  final String fatherName;
  final String fatherOccupation;
  final String motherName;
  final String motherOccupation;
  final int brothers;
  final int sisters;
  final String? familyType;
  final String? familyValues;
  final String familyBackground;
}

class FamilyDetailsScreen extends StatefulWidget {
  static FamilyDetailsDraft? FamilyDetailsScreen.savedDraft;

  const FamilyDetailsScreen({
    super.key,
    required this.templateName,
    required this.templateAccent,
  });

  final String templateName;
  final Color templateAccent;

  @override
  State<FamilyDetailsScreen> createState() => _FamilyDetailsScreenState();
}

class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {

  final _fatherName = TextEditingController();
  final _fatherOccupation = TextEditingController();
  final _motherName = TextEditingController();
  final _motherOccupation = TextEditingController();
  final _familyBackground = TextEditingController();

  int _brothers = 0;
  int _sisters = 0;
  String? _familyType;
  String? _familyValues;

  @override
  void initState() {
    super.initState();
    final draft = FamilyDetailsScreen.FamilyDetailsScreen.savedDraft;
    if (draft != null) {
      _fatherName.text = draft.fatherName;
      _fatherOccupation.text = draft.fatherOccupation;
      _motherName.text = draft.motherName;
      _motherOccupation.text = draft.motherOccupation;
      _familyBackground.text = draft.familyBackground;
      _brothers = draft.brothers;
      _sisters = draft.sisters;
      _familyType = draft.familyType;
      _familyValues = draft.familyValues;
    } else {
      _fatherName.text = BiodataSession.fatherName;
      _fatherOccupation.text = BiodataSession.fatherOccupation;
      _motherName.text = BiodataSession.motherName;
      _motherOccupation.text = BiodataSession.motherOccupation;
      _familyBackground.text = BiodataSession.familyBackground;
      _brothers = BiodataSession.brothers;
      _sisters = BiodataSession.sisters;
      _familyType = BiodataSession.familyType.isEmpty ? null : BiodataSession.familyType;
      _familyValues = BiodataSession.familyValues.isEmpty ? null : BiodataSession.familyValues;
    }
  }

  @override
  void dispose() {
    _fatherName.dispose();
    _fatherOccupation.dispose();
    _motherName.dispose();
    _motherOccupation.dispose();
    _familyBackground.dispose();
    super.dispose();
  }

  FamilyDetailsDraft _makeDraft() => FamilyDetailsDraft(
        fatherName: _fatherName.text.trim(),
        fatherOccupation: _fatherOccupation.text.trim(),
        motherName: _motherName.text.trim(),
        motherOccupation: _motherOccupation.text.trim(),
        brothers: _brothers,
        sisters: _sisters,
        familyType: _familyType,
        familyValues: _familyValues,
        familyBackground: _familyBackground.text.trim(),
      );

  void _syncSession() {
    final draft = _makeDraft();
    BiodataSession.templateName = widget.templateName;
    BiodataSession.templateAccent = widget.templateAccent;
    BiodataSession.fatherName = draft.fatherName;
    BiodataSession.fatherOccupation = draft.fatherOccupation;
    BiodataSession.motherName = draft.motherName;
    BiodataSession.motherOccupation = draft.motherOccupation;
    BiodataSession.brothers = draft.brothers;
    BiodataSession.sisters = draft.sisters;
    BiodataSession.familyType = draft.familyType ?? '';
    BiodataSession.familyValues = draft.familyValues ?? '';
    BiodataSession.familyBackground = draft.familyBackground;
  }

  void _saveAndExit() {
    FamilyDetailsScreen.FamilyDetailsScreen.savedDraft = _makeDraft();
    _syncSession();
    BiodataSession.save();
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).popUntil((route) => route.isFirst);
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Draft saved for this app session.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: VivahColors.plumDark,
      ),
    );
  }

  void _continue() {
    FamilyDetailsScreen.savedDraft = _makeDraft();
    _syncSession();
    FocusScope.of(context).unfocus();
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => EducationCareerScreen(
          templateName: widget.templateName,
          templateAccent: widget.templateAccent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VivahColors.ivory,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 18, 12),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Back',
                    onPressed: () {
                      FamilyDetailsScreen.savedDraft = _makeDraft();
                      _syncSession();
                      Navigator.of(context).maybePop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded, color: VivahColors.plumDark),
                  ),
                  const Expanded(
                    child: Text(
                      'Create biodata',
                      style: TextStyle(
                        color: VivahColors.plumDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                      decoration: BoxDecoration(
                        color: VivahColors.rose,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.templateName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: VivahColors.plumDark,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'STEP 2 OF 5',
                        style: TextStyle(
                          color: VivahColors.gold,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Spacer(),
                      Text('40% complete', style: TextStyle(color: VivahColors.muted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 9),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(
                      value: .4,
                      minHeight: 5,
                      backgroundColor: VivahColors.border,
                      color: VivahColors.plum,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Family details',
                    style: TextStyle(
                      color: VivahColors.plumDark,
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.7,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Share a little about your family. Every field is optional.',
                    style: TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.45),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
                children: [
                  const _SectionTitle('PARENTS'),
                  const SizedBox(height: 14),
                  const _FieldLabel('Father’s name'),
                  const SizedBox(height: 7),
                  TextField(
                    controller: _fatherName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: _decoration('e.g. Rajesh Sharma', Icons.person_outline_rounded),
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Father’s occupation'),
                  const SizedBox(height: 7),
                  TextField(
                    controller: _fatherOccupation,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: _decoration('e.g. Business owner', Icons.work_outline_rounded),
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Mother’s name'),
                  const SizedBox(height: 7),
                  TextField(
                    controller: _motherName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: _decoration('e.g. Sunita Sharma', Icons.person_outline_rounded),
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Mother’s occupation'),
                  const SizedBox(height: 7),
                  TextField(
                    controller: _motherOccupation,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: _decoration('e.g. Teacher, homemaker', Icons.work_outline_rounded),
                  ),
                  const SizedBox(height: 26),
                  const _SectionTitle('SIBLINGS'),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the number of siblings, if you would like to include it.',
                    style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _CountCard(
                          label: 'Brothers',
                          count: _brothers,
                          icon: Icons.person_outline_rounded,
                          onChanged: (value) => setState(() => _brothers = value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CountCard(
                          label: 'Sisters',
                          count: _sisters,
                          icon: Icons.person_2_outlined,
                          onChanged: (value) => setState(() => _sisters = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  const _SectionTitle('FAMILY BACKGROUND'),
                  const SizedBox(height: 14),
                  const _FieldLabel('Family type'),
                  const SizedBox(height: 7),
                  _ChoiceChips(
                    values: const ['Nuclear', 'Joint', 'Extended', 'Prefer not to say'],
                    selected: _familyType,
                    onSelected: (value) => setState(() => _familyType = value),
                  ),
                  const SizedBox(height: 18),
                  const _FieldLabel('Family values'),
                  const SizedBox(height: 7),
                  _ChoiceChips(
                    values: const ['Traditional', 'Moderate', 'Liberal', 'Prefer not to say'],
                    selected: _familyValues,
                    onSelected: (value) => setState(() => _familyValues = value),
                  ),
                  const SizedBox(height: 18),
                  const _FieldLabel('A little more about your family'),
                  const SizedBox(height: 7),
                  TextField(
                    controller: _familyBackground,
                    minLines: 3,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _decoration(
                      'Share anything you would like others to know',
                      Icons.notes_rounded,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5EFE7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lock_outline_rounded, size: 18, color: VivahColors.gold),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Include only details you want to share. You can leave any field blank.',
                            style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
              decoration: BoxDecoration(
                color: VivahColors.ivory,
                border: Border(top: BorderSide(color: VivahColors.border.withValues(alpha: .85))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _saveAndExit,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: VivahColors.plum,
                        side: const BorderSide(color: VivahColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('Save & Exit', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: _continue,
                      style: FilledButton.styleFrom(
                        backgroundColor: VivahColors.plum,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Continue', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 17),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: const TextStyle(
          color: VivahColors.gold,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: const TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w700),
      );
}

InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: VivahColors.muted, size: 19),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: VivahColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: VivahColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: VivahColors.plum, width: 1.5),
      ),
    );

class _CountCard extends StatelessWidget {
  const _CountCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.onChanged,
  });

  final String label;
  final int count;
  final IconData icon;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: VivahColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: VivahColors.plum, size: 19),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(label, style: const TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _CountButton(
                  icon: Icons.remove_rounded,
                  tooltip: 'Remove one $label',
                  onPressed: count > 0 ? () => onChanged(count - 1) : null,
                ),
                Expanded(
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: VivahColors.plumDark, fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
                _CountButton(
                  icon: Icons.add_rounded,
                  tooltip: 'Add one $label',
                  onPressed: count < 20 ? () => onChanged(count + 1) : null,
                ),
              ],
            ),
          ],
        ),
      );
}

class _CountButton extends StatelessWidget {
  const _CountButton({required this.icon, required this.tooltip, required this.onPressed});

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints.tightFor(width: 34, height: 34),
        style: IconButton.styleFrom(
          foregroundColor: VivahColors.plum,
          backgroundColor: VivahColors.rose,
          disabledForegroundColor: VivahColors.muted.withValues(alpha: .35),
        ),
        icon: Icon(icon, size: 17),
      );
}

class _ChoiceChips extends StatelessWidget {
  const _ChoiceChips({
    required this.values,
    required this.selected,
    required this.onSelected,
  });

  final List<String> values;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: values.map((value) {
          final isSelected = value == selected;
          return ChoiceChip(
            label: Text(value),
            selected: isSelected,
            showCheckmark: false,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : VivahColors.ink,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            selectedColor: VivahColors.plum,
            backgroundColor: Colors.white,
            side: BorderSide(color: isSelected ? VivahColors.plum : VivahColors.border),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (_) => onSelected(isSelected ? null : value),
          );
        }).toList(),
      );
}
