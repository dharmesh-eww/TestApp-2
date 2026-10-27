import 'package:flutter/material.dart';

import 'biodata_session.dart';
import 'vivah_colors.dart';
import 'partner_preferences_screen.dart';

class EducationCareerScreen extends StatefulWidget {
  const EducationCareerScreen({super.key, required this.templateName, required this.templateAccent});
  final String templateName;
  final Color templateAccent;

  @override
  State<EducationCareerScreen> createState() => _EducationCareerScreenState();
}

class _EducationCareerScreenState extends State<EducationCareerScreen> {
  final _course = TextEditingController(text: BiodataSession.course);
  final _institution = TextEditingController(text: BiodataSession.institution);
  final _year = TextEditingController(text: BiodataSession.graduationYear);
  final _occupation = TextEditingController(text: BiodataSession.occupation);
  final _company = TextEditingController(text: BiodataSession.company);
  final _location = TextEditingController(text: BiodataSession.workLocation);
  String? _qualification = BiodataSession.qualification.isEmpty ? null : BiodataSession.qualification;
  String? _status = BiodataSession.employmentStatus.isEmpty ? null : BiodataSession.employmentStatus;
  String? _income = BiodataSession.income.isEmpty ? null : BiodataSession.income;

  @override
  void dispose() {
    _course.dispose(); _institution.dispose(); _year.dispose(); _occupation.dispose();
    _company.dispose(); _location.dispose();
    super.dispose();
  }

  void _save() {
    BiodataSession.qualification = _qualification ?? '';
    BiodataSession.course = _course.text.trim();
    BiodataSession.institution = _institution.text.trim();
    BiodataSession.graduationYear = _year.text.trim();
    BiodataSession.employmentStatus = _status ?? '';
    BiodataSession.occupation = _occupation.text.trim();
    BiodataSession.company = _company.text.trim();
    BiodataSession.workLocation = _location.text.trim();
    BiodataSession.income = _income ?? '';
  }

  void _exit() {
    _save();
    BiodataSession.save();
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft saved for this app session.')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: VivahColors.ivory,
    body: SafeArea(child: Column(children: [
      _StepHeader(title: 'Create biodata', templateName: widget.templateName, step: 3, onBack: () { _save(); Navigator.pop(context); }),
      Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(22, 4, 22, 24), children: [
        const Text('Education & career', style: TextStyle(color: VivahColors.plumDark, fontSize: 27, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Tell your story at your own pace. These details are optional.', style: TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.4)),
        const SizedBox(height: 24),
        const _GroupLabel('EDUCATION'),
        const SizedBox(height: 12),
        _label('Highest qualification'),
        _dropdown(_qualification, 'Choose qualification', const ['High school', 'Diploma', 'Bachelor’s degree', 'Master’s degree', 'Doctorate', 'Professional qualification', 'Currently studying', 'Prefer not to say'], (v) => setState(() => _qualification = v)),
        const SizedBox(height: 14),
        _label('Degree or course'),
        _field(_course, 'e.g. B.Com, B.Tech, MBA', Icons.school_outlined),
        const SizedBox(height: 14),
        _label('College or university'),
        _field(_institution, 'Institution name', Icons.account_balance_outlined),
        const SizedBox(height: 14),
        _label('Graduation year'),
        TextField(controller: _year, keyboardType: TextInputType.number, maxLength: 4, decoration: _input('YYYY', Icons.calendar_today_outlined).copyWith(counterText: '')),
        const SizedBox(height: 24),
        const _GroupLabel('CAREER'),
        const SizedBox(height: 12),
        _label('Employment status'),
        _dropdown(_status, 'Choose status', const ['Student', 'Employed', 'Self-employed', 'Not currently working', 'Prefer not to say'], (v) => setState(() => _status = v)),
        const SizedBox(height: 14),
        _label(_status == 'Student' ? 'Current role (optional)' : 'Occupation / job title'),
        _field(_occupation, _status == 'Student' ? 'e.g. Student' : 'e.g. Software engineer', Icons.work_outline_rounded),
        const SizedBox(height: 14),
        _label(_status == 'Student' ? 'Organization (optional)' : 'Company / organization'),
        _field(_company, 'Organization name', Icons.business_outlined),
        const SizedBox(height: 14),
        _label('Work or study location'),
        _field(_location, 'City, state', Icons.location_on_outlined),
        const SizedBox(height: 14),
        _label('Annual income (optional)'),
        _dropdown(_income, 'Select a range (INR ₹)', const ['Prefer not to say', 'Below ₹3 lakh', '₹3–5 lakh', '₹5–10 lakh', '₹10–20 lakh', 'Above ₹20 lakh'], (v) => setState(() => _income = v)),
        const SizedBox(height: 14),
        const Text('You can leave income and any other field blank. Your work status does not define your worth.', style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.45)),
      ])),
      _StepFooter(onSave: _exit, onContinue: () { _save(); Navigator.push(context, MaterialPageRoute<void>(builder: (_) => PartnerPreferencesScreen(templateName: widget.templateName, templateAccent: widget.templateAccent))); }, continueLabel: 'Continue'),
    ])),
  );
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.title, required this.templateName, required this.step, required this.onBack});
  final String title, templateName;
  final int step;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 8, 18, 18),
    child: Column(children: [
      Row(children: [
        IconButton(tooltip: 'Back', onPressed: onBack, icon: const Icon(Icons.arrow_back_rounded, color: VivahColors.plumDark)),
        Expanded(child: Text(title, style: const TextStyle(color: VivahColors.plumDark, fontSize: 19, fontWeight: FontWeight.w800))),
        Flexible(child: Text(templateName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: VivahColors.plum, fontSize: 11, fontWeight: FontWeight.w700))),
      ]),
      const SizedBox(height: 8),
      Row(children: [Text('STEP $step OF 5', style: const TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)), const Spacer(), Text('${step * 20}% complete', style: const TextStyle(color: VivahColors.muted, fontSize: 11))]),
      const SizedBox(height: 8),
      ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: step / 5, minHeight: 5, backgroundColor: VivahColors.border, color: VivahColors.plum)),
    ]),
  );
}

class _StepFooter extends StatelessWidget {
  const _StepFooter({required this.onSave, required this.onContinue, required this.continueLabel});
  final VoidCallback onSave, onContinue;
  final String continueLabel;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
    decoration: const BoxDecoration(color: VivahColors.ivory, border: Border(top: BorderSide(color: VivahColors.border))),
    child: Row(children: [
      Expanded(child: OutlinedButton(onPressed: onSave, style: OutlinedButton.styleFrom(foregroundColor: VivahColors.plum, padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: VivahColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Save & Exit'))),
      const SizedBox(width: 12),
      Expanded(flex: 2, child: FilledButton(onPressed: onContinue, style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(continueLabel), const SizedBox(width: 8), const Icon(Icons.arrow_forward_rounded, size: 17)]))),
    ]),
  );
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2));
}

Widget _label(String text) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text(text, style: const TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w700)));
Widget _field(TextEditingController c, String hint, IconData icon) => TextField(controller: c, textCapitalization: TextCapitalization.words, decoration: _input(hint, icon));
InputDecoration _input(String hint, IconData icon) => InputDecoration(hintText: hint, prefixIcon: Icon(icon, size: 19, color: VivahColors.muted), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.border)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.border)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.plum, width: 1.5)));
Widget _dropdown(String? value, String hint, List<String> options, ValueChanged<String?> onChanged) => DropdownButtonFormField<String>(value: value, isExpanded: true, decoration: _input(hint, Icons.expand_more_rounded), items: options.map((v) => DropdownMenuItem(value: v, child: Text(v, overflow: TextOverflow.ellipsis))).toList(), onChanged: onChanged);
