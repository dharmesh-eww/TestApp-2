import 'package:flutter/material.dart';

import 'biodata_session.dart';
import 'personal_details_screen.dart';
import 'family_details_screen.dart';
import 'export_share_screen.dart';
import 'vivah_colors.dart';

class PreviewEditorScreen extends StatefulWidget {
  const PreviewEditorScreen({super.key, required this.templateName, required this.templateAccent});
  final String templateName;
  final Color templateAccent;

  @override
  State<PreviewEditorScreen> createState() => _PreviewEditorScreenState();
}

class _PreviewEditorScreenState extends State<PreviewEditorScreen> {
  Color _accent = BiodataSession.templateAccent;
  String _template = BiodataSession.templateName;

  @override
  void initState() {
    super.initState();
    if (BiodataSession.templateName.isEmpty) BiodataSession.templateName = widget.templateName;
    if (BiodataSession.fullName.isEmpty) {
      // Keep the existing form's in-memory draft available to the preview.
      BiodataSession.fullName = '';
    }
    _template = BiodataSession.templateName;
    _accent = BiodataSession.templateAccent;
  }

  void _saveDraft() {
    BiodataSession.templateName = _template;
    BiodataSession.templateAccent = _accent;
    BiodataSession.save();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft saved for this app session.')));
  }

  void _chooseTemplate() {
    const choices = <(String, Color)>[
      ('The Classic', Color(0xFFB88A4A)),
      ('Modern Minimal', Color(0xFF642C45)),
      ('Floral Grace', Color(0xFFAD777F)),
      ('Golden Tradition', Color(0xFF9C7135)),
      ('Contemporary Plum', Color(0xFF6B3451)),
      ('Heritage Frame', Color(0xFF84633F)),
    ];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: VivahColors.ivory,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Change template', style: TextStyle(color: VivahColors.plumDark, fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            ...choices.map((choice) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(width: 34, height: 42, decoration: BoxDecoration(color: choice.$2.withValues(alpha: .12), borderRadius: BorderRadius.circular(8), border: Border.all(color: choice.$2, width: 1.5)), child: Icon(Icons.description_outlined, color: choice.$2, size: 19)),
              title: Text(choice.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: _template == choice.$1 ? const Icon(Icons.check_circle, color: VivahColors.plum) : null,
              onTap: () { setState(() { _template = choice.$1; _accent = choice.$2; BiodataSession.templateName = _template; BiodataSession.templateAccent = _accent; }); Navigator.pop(sheetContext); },
            )),
          ]),
        ),
      ),
    );
  }

  void _customize() {
    const colors = <Color>[Color(0xFFB88A4A), Color(0xFF642C45), Color(0xFFAD777F), Color(0xFF37685D), Color(0xFF476A9A), Color(0xFF84633F)];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: VivahColors.ivory,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Customize design', style: TextStyle(color: VivahColors.plumDark, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Choose an accent color for your document.', style: TextStyle(color: VivahColors.muted, fontSize: 13)),
          const SizedBox(height: 20),
          Wrap(spacing: 14, children: colors.map((color) => InkWell(
            onTap: () { setState(() { _accent = color; BiodataSession.templateAccent = color; }); Navigator.pop(sheetContext); },
            borderRadius: BorderRadius.circular(30),
            child: Container(width: 42, height: 42, decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: _accent == color ? VivahColors.ink : Colors.transparent, width: 3), boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 5, offset: Offset(0, 2))]), child: _accent == color ? const Icon(Icons.check, color: Colors.white) : null),
          )).toList()),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = BiodataSession.fullName.trim().isEmpty ? 'Your Name Here' : BiodataSession.fullName.trim();
    return Scaffold(
      backgroundColor: const Color(0xFFF0ECE7),
      appBar: AppBar(
        backgroundColor: VivahColors.ivory,
        foregroundColor: VivahColors.plumDark,
        elevation: 0,
        title: const Text('Preview biodata', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
      ),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(18, 12, 18, 12), child: Wrap(spacing: 8, runSpacing: 8, children: [
          OutlinedButton.icon(onPressed: () { PersonalDetailsScreen.savedDraft = null; FamilyDetailsScreen.savedDraft = null; Navigator.push(context, MaterialPageRoute<void>(builder: (_) => PersonalDetailsScreen(templateName: _template, templateAccent: _accent))); }, icon: const Icon(Icons.edit_outlined, size: 17), label: const Text('Edit details')),
          OutlinedButton.icon(onPressed: _chooseTemplate, icon: const Icon(Icons.dashboard_customize_outlined, size: 17), label: const Text('Change template')),
          OutlinedButton.icon(onPressed: _customize, icon: const Icon(Icons.palette_outlined, size: 17), label: const Text('Customize')),
        ])),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: AspectRatio(
                  aspectRatio: 0.707,
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(color: const Color(0xFFFFFDF8), borderRadius: BorderRadius.circular(4), border: Border.all(color: _accent.withValues(alpha: .7), width: 2), boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 20, offset: Offset(0, 8))]),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Container(height: 3, width: 78, decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 10),
                      Text(_template.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: _accent, fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 14),
                      if (BiodataSession.photoBytes != null) ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(BiodataSession.photoBytes!, height: 82, width: 72, fit: BoxFit.cover)),
                      Text(name, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: VivahColors.plumDark, fontSize: 21, height: 1.1, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text([BiodataSession.city].where((s) => s.isNotEmpty).join('  •  '), textAlign: TextAlign.center, style: const TextStyle(color: VivahColors.muted, fontSize: 9)),
                      const SizedBox(height: 16),
                      Expanded(child: ListView(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: [
                        _documentSection('PERSONAL DETAILS', [
                          _pair('Date of birth', BiodataSession.dateOfBirth),
                          _pair('Gender', BiodataSession.gender),
                          _pair('Height', BiodataSession.height),
                          _pair('Marital status', BiodataSession.maritalStatus),
                          _pair('Religion', BiodataSession.religion),
                          _pair('Community', BiodataSession.community),
                          _pair('Mother tongue', BiodataSession.motherTongue),
                          _pair('City', BiodataSession.city),
                        ], _accent),
                        _documentSection('FAMILY', [
                          _pair('Father', BiodataSession.fatherName),
                          _pair('Father’s occupation', BiodataSession.fatherOccupation),
                          _pair('Mother', BiodataSession.motherName),
                          _pair('Mother’s occupation', BiodataSession.motherOccupation),
                          _pair('Siblings', [if (BiodataSession.brothers > 0) '${BiodataSession.brothers} brother(s)', if (BiodataSession.sisters > 0) '${BiodataSession.sisters} sister(s)'].join(', ')),
                          _pair('Family type', BiodataSession.familyType),
                          _pair('Family values', BiodataSession.familyValues),
                          _pair('About family', BiodataSession.familyBackground),
                        ], _accent),
                        _documentSection('EDUCATION & CAREER', [
                          _pair('Qualification', BiodataSession.qualification),
                          _pair('Course', BiodataSession.course),
                          _pair('Institution', BiodataSession.institution),
                          _pair('Graduation year', BiodataSession.graduationYear),
                          _pair('Employment', BiodataSession.employmentStatus),
                          _pair('Occupation', BiodataSession.occupation),
                          _pair('Organization', BiodataSession.company),
                          _pair('Location', BiodataSession.workLocation),
                          _pair('Annual income', BiodataSession.income),
                        ], _accent),
                        if (BiodataSession.includePartnerPreferences) _documentSection('PARTNER PREFERENCES', [
                          _pair('Preferred age', '${BiodataSession.partnerMinAge}–${BiodataSession.partnerMaxAge} years'),
                          _pair('Preferred height', BiodataSession.partnerHeight),
                          _pair('Education', BiodataSession.partnerEducation),
                          _pair('Occupation', BiodataSession.partnerOccupation),
                          _pair('Location', BiodataSession.partnerLocation),
                          _pair('Other preferences', BiodataSession.partnerNotes),
                        ], _accent),
                        _documentSection('CONTACT', [
                          _pair('Phone', BiodataSession.showPhone ? BiodataSession.phone : ''),
                          _pair('Email', BiodataSession.showEmail ? BiodataSession.email : ''),
                          _pair('City', BiodataSession.contactCity),
                        ], _accent),
                      ])),
                      const SizedBox(height: 8),
                      Container(height: 2, width: 40, color: _accent.withValues(alpha: .75)),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(color: VivahColors.ivory, padding: const EdgeInsets.fromLTRB(18, 12, 18, 14), child: Row(children: [
          Expanded(child: OutlinedButton(onPressed: _saveDraft, style: OutlinedButton.styleFrom(foregroundColor: VivahColors.plum, padding: const EdgeInsets.symmetric(vertical: 14), side: const BorderSide(color: VivahColors.border)), child: const Text('Save draft'))),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: FilledButton.icon(onPressed: () { BiodataSession.templateName = _template; BiodataSession.templateAccent = _accent; Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ExportShareScreen())); }, style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)), icon: const Icon(Icons.picture_as_pdf_outlined), label: const Text('Export biodata'))),
        ])),
      ]),
    );
  }
}

Widget _documentSection(String title, List<({String label, String value})> pairs, Color accent) {
  final visible = pairs.where((p) => p.value.trim().isNotEmpty).toList();
  if (visible.isEmpty) return const SizedBox.shrink();
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: accent, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: .9)),
      const SizedBox(height: 4),
      Container(height: 1, color: accent.withValues(alpha: .45)),
      const SizedBox(height: 5),
      ...visible.map((p) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 82, child: Text(p.label, style: const TextStyle(color: VivahColors.muted, fontSize: 7.5))),
        Expanded(child: Text(p.value, style: const TextStyle(color: VivahColors.ink, fontSize: 7.5, fontWeight: FontWeight.w600))),
      ]))),
    ]),
  );
}
({String label, String value}) _pair(String label, String value) => (label: label, value: value.trim());
