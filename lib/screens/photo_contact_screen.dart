import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'biodata_session.dart';
import 'vivah_colors.dart';
import 'preview_editor_screen.dart';

class PhotoContactScreen extends StatefulWidget {
  const PhotoContactScreen({super.key, required this.templateName, required this.templateAccent});
  final String templateName;
  final Color templateAccent;

  @override
  State<PhotoContactScreen> createState() => _PhotoContactScreenState();
}

class _PhotoContactScreenState extends State<PhotoContactScreen> {
  final _phone = TextEditingController(text: BiodataSession.phone);
  final _email = TextEditingController(text: BiodataSession.email);
  final _city = TextEditingController(text: BiodataSession.contactCity);
  Uint8List? _photo = BiodataSession.photoBytes;
  bool _showPhone = BiodataSession.showPhone;
  bool _showEmail = BiodataSession.showEmail;
  bool _picking = false;
  String? _error;

  @override
  void dispose() { _phone.dispose(); _email.dispose(); _city.dispose(); super.dispose(); }

  Future<void> _pickPhoto() async {
    setState(() { _picking = true; _error = null; });
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 88, maxWidth: 1800);
      if (image != null) {
        _photo = await image.readAsBytes();
        BiodataSession.photoBytes = _photo;
      }
    } catch (_) {
      _error = 'Could not open your photo library. Please try again.';
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _save() {
    BiodataSession.photoBytes = _photo;
    BiodataSession.phone = _phone.text.trim();
    BiodataSession.email = _email.text.trim();
    BiodataSession.contactCity = _city.text.trim();
    BiodataSession.showPhone = _showPhone;
    BiodataSession.showEmail = _showEmail;
  }

  void _review() {
    final phone = _phone.text.trim();
    final email = _email.text.trim();
    if (phone.isNotEmpty && !RegExp(r'^[+0-9() .-]{7,20}$').hasMatch(phone)) {
      setState(() => _error = 'Check the phone number format or leave it blank.');
      return;
    }
    if (email.isNotEmpty && !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      setState(() => _error = 'Enter a valid email address or leave it blank.');
      return;
    }
    setState(() => _error = null);
    _save();
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => PreviewEditorScreen(templateName: widget.templateName, templateAccent: widget.templateAccent)));
  }

  void _exit() {
    _save(); BiodataSession.save();
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft saved for this app session.')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: VivahColors.ivory,
    body: SafeArea(child: Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 18, 14),
        child: Column(children: [
          Row(children: [IconButton(tooltip: 'Back', onPressed: () { _save(); Navigator.pop(context); }, icon: const Icon(Icons.arrow_back_rounded, color: VivahColors.plumDark)), const Expanded(child: Text('Create biodata', style: TextStyle(color: VivahColors.plumDark, fontSize: 19, fontWeight: FontWeight.w800))), Flexible(child: Text(widget.templateName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: VivahColors.plum, fontSize: 11, fontWeight: FontWeight.w700)))]),
          const SizedBox(height: 7),
          const Row(children: [Text('STEP 5 OF 5', style: TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)), Spacer(), Text('100% complete', style: TextStyle(color: VivahColors.muted, fontSize: 11))]),
          const SizedBox(height: 7),
          ClipRRect(borderRadius: BorderRadius.circular(8), child: const LinearProgressIndicator(value: 1, minHeight: 5, backgroundColor: VivahColors.border, color: VivahColors.plum)),
        ]),
      ),
      Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(22, 4, 22, 24), children: [
        const Text('Photo & contact', style: TextStyle(color: VivahColors.plumDark, fontSize: 27, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Choose what you want to share. A photo and contact details are optional.', style: TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.4)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: VivahColors.border)),
          child: Column(children: [
            Container(width: 116, height: 136, decoration: BoxDecoration(color: VivahColors.rose, borderRadius: BorderRadius.circular(20), border: Border.all(color: widget.templateAccent.withValues(alpha: .5))), clipBehavior: Clip.antiAlias, child: _photo == null ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo_outlined, color: VivahColors.plum, size: 30), SizedBox(height: 8), Text('Add a portrait', style: TextStyle(color: VivahColors.plum, fontSize: 11, fontWeight: FontWeight.w700))]) : Image.memory(_photo!, fit: BoxFit.cover)),
            const SizedBox(height: 14),
            Text(_photo == null ? 'A clear, recent photo works best' : 'Photo selected', style: const TextStyle(color: VivahColors.ink, fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            const Text('You can continue without adding a photo.', style: TextStyle(color: VivahColors.muted, fontSize: 12)),
            const SizedBox(height: 14),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              OutlinedButton.icon(onPressed: _picking ? null : _pickPhoto, icon: Icon(_photo == null ? Icons.photo_library_outlined : Icons.refresh_rounded), label: Text(_picking ? 'Opening…' : _photo == null ? 'Add photo' : 'Change photo')),
              if (_photo != null) ...[const SizedBox(width: 8), IconButton(tooltip: 'Remove photo', onPressed: () => setState(() { _photo = null; BiodataSession.photoBytes = null; }), icon: const Icon(Icons.delete_outline_rounded, color: VivahColors.plum))],
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        const Text('CONTACT DETAILS', style: TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
        const SizedBox(height: 14),
        _label('Phone number'),
        TextField(controller: _phone, keyboardType: TextInputType.phone, decoration: _input('Optional phone number', Icons.phone_outlined)),
        SwitchListTile.adaptive(contentPadding: EdgeInsets.zero, activeThumbColor: VivahColors.plum, title: const Text('Show phone on biodata', style: TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w600)), value: _showPhone, onChanged: (v) => setState(() => _showPhone = v)),
        const SizedBox(height: 8),
        _label('Email address'),
        TextField(controller: _email, keyboardType: TextInputType.emailAddress, autocorrect: false, decoration: _input('Optional email address', Icons.email_outlined)),
        SwitchListTile.adaptive(contentPadding: EdgeInsets.zero, activeThumbColor: VivahColors.plum, title: const Text('Show email on biodata', style: TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w600)), value: _showEmail, onChanged: (v) => setState(() => _showEmail = v)),
        const SizedBox(height: 8),
        _label('Current city'),
        TextField(controller: _city, textCapitalization: TextCapitalization.words, decoration: _input('City or town (not full address)', Icons.location_city_outlined)),
        if (_error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 12))),
        const SizedBox(height: 14),
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFF5EFE7), borderRadius: BorderRadius.circular(15)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.lock_outline_rounded, size: 18, color: VivahColors.gold), SizedBox(width: 10), Expanded(child: Text('Phone and email are hidden unless you turn on their visibility switches. Only details you choose to include appear in the preview.', style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.45)))])),
      ])),
      Container(padding: const EdgeInsets.fromLTRB(22, 12, 22, 14), decoration: const BoxDecoration(color: VivahColors.ivory, border: Border(top: BorderSide(color: VivahColors.border))), child: Row(children: [
        Expanded(child: OutlinedButton(onPressed: _exit, style: OutlinedButton.styleFrom(foregroundColor: VivahColors.plum, padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: VivahColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Save draft'))),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: FilledButton(onPressed: _review, style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Review biodata'), SizedBox(width: 8), Icon(Icons.arrow_forward_rounded, size: 17)]))),
      ])),
    ])),
  );
}

Widget _label(String value) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text(value, style: const TextStyle(color: VivahColors.ink, fontSize: 13, fontWeight: FontWeight.w700)));
InputDecoration _input(String hint, IconData icon) => InputDecoration(hintText: hint, prefixIcon: Icon(icon, size: 19, color: VivahColors.muted), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.border)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.border)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: VivahColors.plum, width: 1.5)));
