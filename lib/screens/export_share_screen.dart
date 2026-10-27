import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'biodata_session.dart';
import 'home_screen.dart';
import 'preview_editor_screen.dart';

class ExportShareScreen extends StatefulWidget {
  const ExportShareScreen({super.key});

  @override
  State<ExportShareScreen> createState() => _ExportShareScreenState();
}

class _ExportShareScreenState extends State<ExportShareScreen> {
  bool _processing = false;
  Uint8List? _pdfBytes;
  String? _error;

  Future<Uint8List> _buildPdf() async {
    final document = pw.Document();
    final accent = PdfColor.fromInt(BiodataSession.templateAccent.toARGB32());
    pw.Widget section(String title, List<(String, String)> values) {
      final visible = values.where((entry) => entry.$2.trim().isNotEmpty).toList();
      if (visible.isEmpty) return pw.SizedBox();
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 12),
        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text(title.toUpperCase(), style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: accent, letterSpacing: 1)),
          pw.SizedBox(height: 4),
          pw.Container(height: 1, color: accent),
          pw.SizedBox(height: 5),
          ...visible.map((entry) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.SizedBox(width: 125, child: pw.Text(entry.$1, style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700))),
              pw.Expanded(child: pw.Text(entry.$2, style: const pw.TextStyle(fontSize: 9))),
            ]),
          )),
        ]),
      );
    }

    document.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(38),
      build: (context) => [
        pw.Container(height: 3, color: accent),
        pw.SizedBox(height: 18),
        pw.Center(child: pw.Text(BiodataSession.templateName.toUpperCase(), style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: accent, letterSpacing: 2))),
        if (BiodataSession.photoBytes != null) ...[
          pw.SizedBox(height: 8),
          pw.Center(child: pw.Image(pw.MemoryImage(BiodataSession.photoBytes!), height: 95, width: 75, fit: pw.BoxFit.cover)),
          pw.SizedBox(height: 10),
        ],
        pw.SizedBox(height: 12),
        pw.Center(child: pw.Text(BiodataSession.fullName.trim().isEmpty ? 'Marriage Biodata' : BiodataSession.fullName.trim(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0xFF432032)))),
        pw.SizedBox(height: 6),
        if (BiodataSession.city.trim().isNotEmpty) pw.Center(child: pw.Text(BiodataSession.city.trim(), style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700))),
        pw.SizedBox(height: 24),
        section('Personal details', [
          ('Date of birth', BiodataSession.dateOfBirth), ('Gender', BiodataSession.gender),
          ('Height', BiodataSession.height), ('Marital status', BiodataSession.maritalStatus),
          ('Religion', BiodataSession.religion), ('Community', BiodataSession.community),
          ('Mother tongue', BiodataSession.motherTongue), ('City', BiodataSession.city),
        ]),
        section('Family', [
          ('Father', BiodataSession.fatherName), ('Father’s occupation', BiodataSession.fatherOccupation),
          ('Mother', BiodataSession.motherName), ('Mother’s occupation', BiodataSession.motherOccupation),
          ('Brothers', BiodataSession.brothers > 0 ? '${BiodataSession.brothers}' : ''),
          ('Sisters', BiodataSession.sisters > 0 ? '${BiodataSession.sisters}' : ''),
          ('Family type', BiodataSession.familyType), ('Family values', BiodataSession.familyValues),
          ('About family', BiodataSession.familyBackground),
        ]),
        section('Education & career', [
          ('Qualification', BiodataSession.qualification), ('Course', BiodataSession.course),
          ('Institution', BiodataSession.institution), ('Graduation year', BiodataSession.graduationYear),
          ('Employment', BiodataSession.employmentStatus), ('Occupation', BiodataSession.occupation),
          ('Organization', BiodataSession.company), ('Location', BiodataSession.workLocation),
          ('Annual income', BiodataSession.income),
        ]),
        if (BiodataSession.includePartnerPreferences) section('Partner preferences', [
          ('Preferred age', '${BiodataSession.partnerMinAge}–${BiodataSession.partnerMaxAge} years'),
          ('Height', BiodataSession.partnerHeight), ('Education', BiodataSession.partnerEducation),
          ('Occupation', BiodataSession.partnerOccupation), ('Location', BiodataSession.partnerLocation),
          ('Other preferences', BiodataSession.partnerNotes),
        ]),
        section('Contact', [
          ('Phone', BiodataSession.showPhone ? BiodataSession.phone : ''),
          ('Email', BiodataSession.showEmail ? BiodataSession.email : ''),
          ('City', BiodataSession.contactCity),
        ]),
        pw.SizedBox(height: 14),
        pw.Center(child: pw.Container(height: 2, width: 48, color: accent)),
      ],
    ));
    return document.save();
  }

  Future<void> _createPdf() async {
    setState(() { _processing = true; _error = null; });
    try {
      final bytes = await _buildPdf();
      if (!mounted) return;
      setState(() { _pdfBytes = bytes; _processing = false; });
      BiodataSession.save(completed: true);
    } catch (_) {
      if (!mounted) return;
      setState(() { _processing = false; _error = 'We could not create the PDF. Your details are still here; please try again.'; });
    }
  }

  Future<void> _share() async {
    final bytes = _pdfBytes;
    if (bytes == null) return;
    try {
      await Printing.sharePdf(bytes: bytes, filename: 'VivahBio_Biodata.pdf');
    } catch (_) {
      if (mounted) setState(() => _error = 'The share sheet could not be opened. Please try again.');
    }
  }

  Future<void> _saveOrPrint() async {
    final bytes = _pdfBytes;
    if (bytes == null) return;
    try {
      await Printing.layoutPdf(name: 'VivahBio_Biodata.pdf', onLayout: (_) async => bytes);
    } catch (_) {
      if (mounted) setState(() => _error = 'Could not open the print/save dialog on this device.');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: VivahColors.ivory,
    appBar: AppBar(backgroundColor: VivahColors.ivory, foregroundColor: VivahColors.plumDark, elevation: 0, title: const Text('Export & share', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800))),
    body: ListView(padding: const EdgeInsets.fromLTRB(22, 8, 22, 30), children: [
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: VivahColors.border)),
        child: Row(children: [
          Container(width: 66, height: 86, decoration: BoxDecoration(color: const Color(0xFFFFFCF6), border: Border.all(color: BiodataSession.templateAccent, width: 1.5), borderRadius: BorderRadius.circular(8)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.description_outlined, color: BiodataSession.templateAccent, size: 27), const SizedBox(height: 4), Container(width: 32, height: 2, color: BiodataSession.templateAccent), const SizedBox(height: 4), Container(width: 36, height: 2, color: VivahColors.border), const SizedBox(height: 3), Container(width: 30, height: 2, color: VivahColors.border)])),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(BiodataSession.fullName.trim().isEmpty ? 'Untitled biodata' : BiodataSession.fullName.trim(), maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: VivahColors.plumDark, fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 5),
            Text(BiodataSession.templateName, style: const TextStyle(color: VivahColors.muted, fontSize: 12)),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.check_circle_outline_rounded, size: 15, color: VivahColors.gold), const SizedBox(width: 5), Text(_pdfBytes == null ? 'Ready to create' : 'PDF created', style: const TextStyle(color: VivahColors.muted, fontSize: 11))]),
          ])),
        ]),
      ),
      const SizedBox(height: 22),
      const Text('FILE FORMAT', style: TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: VivahColors.plum)), child: const Row(children: [Icon(Icons.picture_as_pdf_rounded, color: VivahColors.plum, size: 27), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('PDF document', style: TextStyle(color: VivahColors.ink, fontWeight: FontWeight.w700)), SizedBox(height: 3), Text('A4 · Recommended for printing and sharing', style: TextStyle(color: VivahColors.muted, fontSize: 12))])), Icon(Icons.check_circle_rounded, color: VivahColors.plum)])),
      const SizedBox(height: 18),
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFF5EFE7), borderRadius: BorderRadius.circular(15)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.privacy_tip_outlined, color: VivahColors.gold, size: 19), SizedBox(width: 10), Expanded(child: Text('Check the preview before sharing. Your file may contain personal details and any contact information you chose to show.', style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.45)))])),
      if (_error != null) Padding(padding: const EdgeInsets.only(top: 14), child: Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 13))),
      if (_pdfBytes == null) ...[
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: _processing ? null : _createPdf, style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), icon: _processing ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.picture_as_pdf_outlined), label: Text(_processing ? 'Creating PDF…' : 'Create PDF')),
      ] else ...[
        const SizedBox(height: 24),
        Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFFE8F3E9), borderRadius: BorderRadius.circular(18)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.check_circle_rounded, color: Color(0xFF2D7A42), size: 26), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Your PDF is ready', style: TextStyle(color: Color(0xFF205B31), fontSize: 16, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('VivahBio_Biodata.pdf · A4 document', style: TextStyle(color: Color(0xFF376748), fontSize: 12))]))])),
        const SizedBox(height: 14),
        FilledButton.icon(onPressed: _share, style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15)), icon: const Icon(Icons.share_outlined), label: const Text('Share PDF')),
        const SizedBox(height: 10),
        OutlinedButton.icon(onPressed: _saveOrPrint, style: OutlinedButton.styleFrom(foregroundColor: VivahColors.plum, padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: VivahColors.border)), icon: const Icon(Icons.print_outlined), label: const Text('Print / Save PDF')),
        const SizedBox(height: 10),
        OutlinedButton.icon(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (_) => PreviewEditorScreen(templateName: BiodataSession.templateName, templateAccent: BiodataSession.templateAccent))), style: OutlinedButton.styleFrom(foregroundColor: VivahColors.plum, padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: VivahColors.border)), icon: const Icon(Icons.arrow_back_rounded), label: const Text('Back to preview')),
        const SizedBox(height: 8),
        TextButton.icon(onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst), icon: const Icon(Icons.home_outlined), label: const Text('Back to home')),
      ],
    ]),
  );
}
