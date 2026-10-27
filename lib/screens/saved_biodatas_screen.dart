import 'package:flutter/material.dart';

import 'biodata_session.dart';
import 'vivah_colors.dart';
import 'preview_editor_screen.dart';
import 'template_selection_screen.dart';

enum _SavedFilter { all, drafts, completed }

class SavedBiodatasScreen extends StatefulWidget {
  const SavedBiodatasScreen({super.key});

  @override
  State<SavedBiodatasScreen> createState() => _SavedBiodatasScreenState();
}

class _SavedBiodatasScreenState extends State<SavedBiodatasScreen> {
  _SavedFilter _filter = _SavedFilter.all;

  List<SavedBiodata> get _visible {
    final items = [...BiodataSession.saved]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return items.where((item) => switch (_filter) {
      _SavedFilter.all => true,
      _SavedFilter.drafts => !item.completed,
      _SavedFilter.completed => item.completed,
    }).toList();
  }

  String _date(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Edited today · ${TimeOfDay.fromDateTime(date).format(context)}';
    }
    return 'Edited ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _rename(SavedBiodata item) async {
    final controller = TextEditingController(text: item.title);
    final formKey = GlobalKey<FormState>();
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: VivahColors.ivory,
        title: const Text('Rename biodata', style: TextStyle(color: VivahColors.plumDark, fontWeight: FontWeight.w800)),
        content: Form(key: formKey, child: TextFormField(controller: controller, autofocus: true, maxLength: 60, decoration: const InputDecoration(labelText: 'Document title'), validator: (value) => value == null || value.trim().isEmpty ? 'Enter a title.' : null)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () { if (formKey.currentState!.validate()) Navigator.pop(context, controller.text.trim()); }, child: const Text('Save')),
        ],
      ),
    );
    controller.dispose();
    if (title == null) return;
    setState(() {
      final index = BiodataSession.saved.indexWhere((entry) => entry.id == item.id);
      if (index >= 0) BiodataSession.saved[index] = item.copyWith(title: title, updatedAt: DateTime.now());
      if (item.id == 'current') BiodataSession.title = title;
    });
  }

  Future<void> _delete(SavedBiodata item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: VivahColors.ivory,
        title: const Text('Delete this biodata?', style: TextStyle(color: VivahColors.plumDark, fontWeight: FontWeight.w800)),
        content: Text('“${item.title}” will be removed from this app session. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), style: FilledButton.styleFrom(backgroundColor: VivahColors.plum), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => BiodataSession.saved.removeWhere((entry) => entry.id == item.id));
  }

  void _duplicate(SavedBiodata item) {
    setState(() => BiodataSession.saved.insert(0, item.copyWith(
      id: 'copy-${DateTime.now().microsecondsSinceEpoch}',
      title: 'Copy of ${item.title}',
      updatedAt: DateTime.now(),
      completed: false,
    )));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A separate copy was created.')));
  }

  void _open(SavedBiodata item) {
    // This MVP retains form values in memory for the current session.
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => PreviewEditorScreen(templateName: item.templateName, templateAccent: BiodataSession.templateAccent)));
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;
    return Scaffold(
      backgroundColor: VivahColors.ivory,
      appBar: AppBar(
        backgroundColor: VivahColors.ivory,
        foregroundColor: VivahColors.plumDark,
        elevation: 0,
        title: const Text('My Biodatas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        actions: [TextButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const TemplateSelectionScreen())), icon: const Icon(Icons.add_rounded), label: const Text('Create new'))],
      ),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 16), child: Row(children: [
          _FilterChip(label: 'All', selected: _filter == _SavedFilter.all, onTap: () => setState(() => _filter = _SavedFilter.all)),
          const SizedBox(width: 8),
          _FilterChip(label: 'Drafts', selected: _filter == _SavedFilter.drafts, onTap: () => setState(() => _filter = _SavedFilter.drafts)),
          const SizedBox(width: 8),
          _FilterChip(label: 'Completed', selected: _filter == _SavedFilter.completed, onTap: () => setState(() => _filter = _SavedFilter.completed)),
        ])),
        Expanded(
          child: items.isEmpty
            ? Center(child: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 92, height: 102, decoration: BoxDecoration(color: VivahColors.rose, borderRadius: BorderRadius.circular(22)), child: const Icon(Icons.description_outlined, color: VivahColors.plum, size: 43)),
                const SizedBox(height: 20),
                const Text('No biodatas yet', style: TextStyle(color: VivahColors.plumDark, fontSize: 21, fontWeight: FontWeight.w800)),
                const SizedBox(height: 7),
                Text(_filter == _SavedFilter.all ? 'Create your first biodata and it will appear here.' : _filter == _SavedFilter.drafts ? 'You have no saved drafts in this session.' : 'No completed biodatas yet.', textAlign: TextAlign.center, style: const TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.4)),
                const SizedBox(height: 18),
                FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const TemplateSelectionScreen())), icon: const Icon(Icons.add_rounded), label: const Text('Create biodata')),
              ])))
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return InkWell(
                    onTap: () => _open(item),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: VivahColors.border)),
                      child: Row(children: [
                        Container(width: 54, height: 68, decoration: BoxDecoration(color: const Color(0xFFFFFCF6), border: Border.all(color: const Color(0xFFB88A4A)), borderRadius: BorderRadius.circular(7)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.description_outlined, color: const Color(0xFFB88A4A), size: 23), const SizedBox(height: 4), Container(width: 28, height: 2, color: VivahColors.border), const SizedBox(height: 3), Container(width: 22, height: 2, color: VivahColors.border)])),
                        const SizedBox(width: 13),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item.title.isEmpty ? 'Untitled biodata' : item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: VivahColors.ink, fontSize: 14, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 5),
                          Text(_date(item.updatedAt), style: const TextStyle(color: VivahColors.muted, fontSize: 11)),
                          const SizedBox(height: 7),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: item.completed ? const Color(0xFFE8F3E9) : VivahColors.rose, borderRadius: BorderRadius.circular(8)), child: Text(item.completed ? 'Ready' : 'Draft', style: TextStyle(color: item.completed ? const Color(0xFF2D7A42) : VivahColors.plum, fontSize: 10, fontWeight: FontWeight.w700))),
                        ])),
                        PopupMenuButton<String>(
                          tooltip: 'Document actions',
                          onSelected: (action) {
                            if (action == 'rename') _rename(item);
                            if (action == 'duplicate') _duplicate(item);
                            if (action == 'export') Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const PreviewEditorScreen(templateName: 'The Classic', templateAccent: VivahColors.gold)));
                            if (action == 'delete') _delete(item);
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'rename', child: Text('Rename')),
                            PopupMenuItem(value: 'duplicate', child: Text('Duplicate')),
                            PopupMenuItem(value: 'export', child: Text('Export again')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        ),
                      ]),
                    ),
                  );
                },
              ),
        ),
        Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 14), child: Text('Saved items are kept in memory for this app session in this prototype.', style: TextStyle(color: VivahColors.muted, fontSize: 11), textAlign: TextAlign.center)),
      ]),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label; final bool selected; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ChoiceChip(label: Text(label), selected: selected, showCheckmark: false, onSelected: (_) => onTap(), selectedColor: VivahColors.plum, backgroundColor: Colors.white, labelStyle: TextStyle(color: selected ? Colors.white : VivahColors.ink, fontSize: 12, fontWeight: FontWeight.w700), side: BorderSide(color: selected ? VivahColors.plum : VivahColors.border));
}
