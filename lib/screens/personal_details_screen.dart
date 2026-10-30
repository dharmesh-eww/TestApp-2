import 'package:flutter/material.dart';

import 'vivah_colors.dart';
import 'biodata_session.dart';
import 'family_details_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  static PersonalDetailsDraft? PersonalDetailsScreen.savedDraft;

  const PersonalDetailsScreen({super.key, required this.templateName, required this.templateAccent});
  final String templateName;
  final Color templateAccent;

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class PersonalDetailsDraft {
  const PersonalDetailsDraft({
    required this.fullName, required this.dateOfBirth, required this.gender,
    required this.height, required this.maritalStatus, required this.religion,
    required this.community, required this.motherTongue, required this.city,
    required this.templateName,
  });
  final String fullName;
  final DateTime? dateOfBirth;
  final String? gender, height, maritalStatus;
  final String religion, community, motherTongue, city, templateName;
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _religion = TextEditingController();
  final _community = TextEditingController();
  final _tongue = TextEditingController();
  final _city = TextEditingController();
  final _nameFocus = FocusNode();
  DateTime? _dob;
  String? _gender, _height, _maritalStatus;

  @override
  void initState() {
    super.initState();
    final d = PersonalDetailsScreen.PersonalDetailsScreen.savedDraft;
    if (d != null) {
      _name.text = d.fullName; _dob = d.dateOfBirth; _gender = d.gender;
      _height = d.height; _maritalStatus = d.maritalStatus;
      _religion.text = d.religion; _community.text = d.community;
      _tongue.text = d.motherTongue; _city.text = d.city;
    } else {
      _name.text = BiodataSession.fullName;
      final parts = BiodataSession.dateOfBirth.split('/');
      if (parts.length == 3) {
        _dob = DateTime.tryParse('${parts[2]}-${parts[1]}-${parts[0]}');
      }
      _gender = BiodataSession.gender.isEmpty ? null : BiodataSession.gender;
      _height = BiodataSession.height.isEmpty ? null : BiodataSession.height;
      _maritalStatus = BiodataSession.maritalStatus.isEmpty ? null : BiodataSession.maritalStatus;
      _religion.text = BiodataSession.religion;
      _community.text = BiodataSession.community;
      _tongue.text = BiodataSession.motherTongue;
      _city.text = BiodataSession.city;
    }
  }

  @override
  void dispose() {
    _name.dispose(); _religion.dispose(); _community.dispose();
    _tongue.dispose(); _city.dispose(); _nameFocus.dispose();
    super.dispose();
  }

  int? get _age {
    if (_dob == null) return null;
    final now = DateTime.now();
    var years = now.year - _dob!.year;
    if (now.month < _dob!.month || (now.month == _dob!.month && now.day < _dob!.day)) years--;
    return years;
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(now.year - 25, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Select date of birth',
    );
    if (result != null) setState(() => _dob = result);
  }

  PersonalDetailsDraft _makeDraft() => PersonalDetailsDraft(
    fullName: _name.text.trim(), dateOfBirth: _dob, gender: _gender,
    height: _height, maritalStatus: _maritalStatus, religion: _religion.text.trim(),
    community: _community.text.trim(), motherTongue: _tongue.text.trim(),
    city: _city.text.trim(), templateName: widget.templateName,
  );

  void _syncSession() {
    final draft = _makeDraft();
    BiodataSession.templateName = widget.templateName;
    BiodataSession.templateAccent = widget.templateAccent;
    BiodataSession.fullName = draft.fullName;
    BiodataSession.dateOfBirth = _dob == null ? '' : '${_dob!.day.toString().padLeft(2, '0')}/${_dob!.month.toString().padLeft(2, '0')}/${_dob!.year}';
    BiodataSession.gender = draft.gender ?? '';
    BiodataSession.height = draft.height ?? '';
    BiodataSession.maritalStatus = draft.maritalStatus ?? '';
    BiodataSession.religion = draft.religion;
    BiodataSession.community = draft.community;
    BiodataSession.motherTongue = draft.motherTongue;
    BiodataSession.city = draft.city;
    if (draft.fullName.trim().isNotEmpty) BiodataSession.title = draft.fullName.trim();
  }

  void _saveAndExit() {
    PersonalDetailsScreen.PersonalDetailsScreen.savedDraft = _makeDraft();
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

  void _goBack() {
    PersonalDetailsScreen.savedDraft = _makeDraft();
    _syncSession();
    Navigator.of(context).maybePop();
  }

  void _continue() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      _nameFocus.requestFocus();
      return;
    }
    PersonalDetailsScreen.savedDraft = _makeDraft();
    _syncSession();
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => FamilyDetailsScreen(
          templateName: widget.templateName,
          templateAccent: widget.templateAccent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final age = _age;
    return Scaffold(
      backgroundColor: VivahColors.ivory,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 18, 12),
            child: Row(children: [
              IconButton(
                tooltip: 'Back',
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back_rounded, color: VivahColors.plumDark),
              ),
              const Expanded(child: Text('Create biodata', style: TextStyle(
                color: VivahColors.plumDark, fontSize: 20, fontWeight: FontWeight.w800,
              ))),
              Flexible(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                decoration: BoxDecoration(color: VivahColors.rose, borderRadius: BorderRadius.circular(12)),
                child: Text(widget.templateName, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: VivahColors.plumDark, fontSize: 11, fontWeight: FontWeight.w700)),
              )),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(children: [
                Text('STEP 1 OF 5', style: TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                Spacer(),
                Text('20% complete', style: TextStyle(color: VivahColors.muted, fontSize: 11)),
              ]),
              const SizedBox(height: 9),
              ClipRRect(borderRadius: BorderRadius.circular(8), child: const LinearProgressIndicator(
                value: .2, minHeight: 5, backgroundColor: VivahColors.border, color: VivahColors.plum,
              )),
              const SizedBox(height: 20),
              const Text('Personal details', style: TextStyle(
                color: VivahColors.plumDark, fontSize: 27, fontWeight: FontWeight.w800, letterSpacing: -.7,
              )),
              const SizedBox(height: 6),
              const Text('Start with the basics. You can review everything before exporting.',
                style: TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.45)),
            ]),
          ),
          Expanded(child: Form(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
              children: [
                const _FieldLabel('Full name', requiredField: true),
                const SizedBox(height: 7),
                TextFormField(
                  controller: _name, focusNode: _nameFocus,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: _decoration('e.g. Aarav Sharma', Icons.person_outline_rounded),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your full name.' : null,
                ),
                const SizedBox(height: 18),
                const _FieldLabel('Date of birth', optional: true),
                const SizedBox(height: 7),
                _DateField(value: _dob, onTap: _pickDob),
                if (age != null) Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text('Age: $age years · Calculated from date of birth',
                    style: const TextStyle(color: VivahColors.muted, fontSize: 12)),
                ),
                const SizedBox(height: 18),
                const _FieldLabel('Gender', optional: true),
                const SizedBox(height: 7),
                _Dropdown(value: _gender, hint: 'Select gender',
                  options: const ['Woman', 'Man', 'Prefer not to say'],
                  onChanged: (v) => setState(() => _gender = v)),
                const SizedBox(height: 18),
                const _FieldLabel('Height', optional: true),
                const SizedBox(height: 7),
                _Dropdown(value: _height, hint: 'Select height (ft / cm)', options: const [
                  '4 ft 6 in (137 cm)', '4 ft 8 in (142 cm)', '4 ft 10 in (147 cm)',
                  '5 ft 0 in (152 cm)', '5 ft 2 in (157 cm)', '5 ft 4 in (163 cm)',
                  '5 ft 6 in (168 cm)', '5 ft 8 in (173 cm)', '5 ft 10 in (178 cm)',
                  '6 ft 0 in (183 cm)', '6 ft 2 in (188 cm)', '6 ft 4 in (193 cm)',
                ], onChanged: (v) => setState(() => _height = v)),
                const SizedBox(height: 18),
                const _FieldLabel('Marital status', optional: true),
                const SizedBox(height: 7),
                _Dropdown(value: _maritalStatus, hint: 'Select marital status', options: const [
                  'Never married', 'Divorced', 'Widowed', 'Separated',
                ], onChanged: (v) => setState(() => _maritalStatus = v)),
                const SizedBox(height: 25),
                const Text('MORE ABOUT YOU', style: TextStyle(
                  color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2,
                )),
                const SizedBox(height: 16),
                const _FieldLabel('Religion', optional: true),
                const SizedBox(height: 7),
                TextFormField(controller: _religion, textCapitalization: TextCapitalization.words,
                  decoration: _decoration('e.g. Hindu', Icons.auto_awesome_outlined)),
                const SizedBox(height: 16),
                const _FieldLabel('Community / caste', optional: true),
                const SizedBox(height: 7),
                TextFormField(controller: _community, textCapitalization: TextCapitalization.words,
                  decoration: _decoration('e.g. Patel', Icons.groups_outlined)),
                const SizedBox(height: 16),
                const _FieldLabel('Mother tongue', optional: true),
                const SizedBox(height: 7),
                TextFormField(controller: _tongue, textCapitalization: TextCapitalization.words,
                  decoration: _decoration('e.g. Gujarati', Icons.translate_rounded)),
                const SizedBox(height: 16),
                const _FieldLabel('Current city', optional: true),
                const SizedBox(height: 7),
                TextFormField(controller: _city, textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  decoration: _decoration('e.g. Ahmedabad', Icons.location_city_outlined)),
              ],
            ),
          )),
          Container(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
            decoration: BoxDecoration(color: VivahColors.ivory,
              border: Border(top: BorderSide(color: VivahColors.border.withValues(alpha: .85)))),
            child: Row(children: [
              Expanded(child: OutlinedButton(
                onPressed: _saveAndExit,
                style: OutlinedButton.styleFrom(
                  foregroundColor: VivahColors.plum, side: const BorderSide(color: VivahColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Save & Exit', style: TextStyle(fontWeight: FontWeight.w700)),
              )),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: FilledButton(
                onPressed: _continue,
                style: FilledButton.styleFrom(
                  backgroundColor: VivahColors.plum, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Continue', style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(width: 8), Icon(Icons.arrow_forward_rounded, size: 17),
                ]),
              )),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label, {this.requiredField = false, this.optional = false});
  final String label;
  final bool requiredField, optional;
  @override
  Widget build(BuildContext context) => Row(children: [
    Text(label, style: const TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w700)),
    if (requiredField) const Text(' *', style: TextStyle(color: VivahColors.plum, fontWeight: FontWeight.w800)),
    if (optional) ...[
      const SizedBox(width: 7),
      const Text('OPTIONAL', style: TextStyle(color: VivahColors.muted, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: .5)),
    ],
  ]);
}

InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
  hintText: hint, prefixIcon: Icon(icon, color: VivahColors.muted, size: 19),
  filled: true, fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.border)),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.border)),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.plum, width: 1.5)),
  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.plum)),
  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.plum, width: 1.5)),
);

class _DateField extends StatelessWidget {
  const _DateField({required this.value, required this.onTap});
  final DateTime? value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final date = value;
    final label = date == null ? 'Select your date of birth'
      : '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return Material(
      color: Colors.white, borderRadius: BorderRadius.circular(14),
      child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(14), child: Container(
        constraints: const BoxConstraints(minHeight: 54),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: VivahColors.border)),
        child: Row(children: [
          const Icon(Icons.calendar_month_outlined, color: VivahColors.muted, size: 19),
          const SizedBox(width: 11),
          Expanded(child: Text(label, style: TextStyle(color: date == null ? VivahColors.muted : VivahColors.ink, fontSize: 14))),
          const Icon(Icons.keyboard_arrow_down_rounded, color: VivahColors.muted),
        ]),
      )),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({required this.value, required this.hint, required this.options, required this.onChanged});
  final String? value;
  final String hint;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
    initialValue: value, isExpanded: true,
    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: VivahColors.muted),
    decoration: _decoration(hint, Icons.tune_rounded),
    items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, overflow: TextOverflow.ellipsis))).toList(),
    onChanged: onChanged,
  );
}
