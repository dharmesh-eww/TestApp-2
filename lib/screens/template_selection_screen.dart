import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'biodata_session.dart';
import 'family_details_screen.dart';
import 'personal_details_screen.dart';

enum BiodataTemplateCategory { classic, modern, traditional }

class BiodataTemplate {
  const BiodataTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.accent,
    required this.paper,
    required this.isPremium,
    required this.layout,
  });

  final String id;
  final String name;
  final String description;
  final BiodataTemplateCategory category;
  final Color accent;
  final Color paper;
  final bool isPremium;
  final int layout;
}

const _templates = <BiodataTemplate>[
  BiodataTemplate(
    id: 'classic-ivory',
    name: 'The Classic',
    description: 'Timeless & elegant',
    category: BiodataTemplateCategory.classic,
    accent: Color(0xFFB88A4A),
    paper: Color(0xFFFFFCF6),
    isPremium: false,
    layout: 0,
  ),
  BiodataTemplate(
    id: 'modern-minimal',
    name: 'Modern Minimal',
    description: 'Clean & confident',
    category: BiodataTemplateCategory.modern,
    accent: Color(0xFF642C45),
    paper: Color(0xFFFFFFFF),
    isPremium: false,
    layout: 1,
  ),
  BiodataTemplate(
    id: 'floral-grace',
    name: 'Floral Grace',
    description: 'Soft floral details',
    category: BiodataTemplateCategory.traditional,
    accent: Color(0xFFAD777F),
    paper: Color(0xFFFFF8F8),
    isPremium: false,
    layout: 2,
  ),
  BiodataTemplate(
    id: 'golden-tradition',
    name: 'Golden Tradition',
    description: 'A ceremonial touch',
    category: BiodataTemplateCategory.traditional,
    accent: Color(0xFF9C7135),
    paper: Color(0xFFFFF9E9),
    isPremium: true,
    layout: 3,
  ),
  BiodataTemplate(
    id: 'contemporary-plum',
    name: 'Contemporary Plum',
    description: 'Refined & expressive',
    category: BiodataTemplateCategory.modern,
    accent: Color(0xFF6B3451),
    paper: Color(0xFFFBF7F8),
    isPremium: true,
    layout: 4,
  ),
  BiodataTemplate(
    id: 'heritage-frame',
    name: 'Heritage Frame',
    description: 'Traditional, beautifully framed',
    category: BiodataTemplateCategory.classic,
    accent: Color(0xFF84633F),
    paper: Color(0xFFFFFCF4),
    isPremium: false,
    layout: 5,
  ),
];

enum _TemplateFilter { all, classic, modern, traditional }

class TemplateSelectionScreen extends StatefulWidget {
  const TemplateSelectionScreen({super.key});

  @override
  State<TemplateSelectionScreen> createState() => _TemplateSelectionScreenState();
}

class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {
  _TemplateFilter _filter = _TemplateFilter.all;
  String? _selectedTemplateId;

  List<BiodataTemplate> get _visibleTemplates {
    if (_filter == _TemplateFilter.all) return _templates;
    final category = switch (_filter) {
      _TemplateFilter.all => null,
      _TemplateFilter.classic => BiodataTemplateCategory.classic,
      _TemplateFilter.modern => BiodataTemplateCategory.modern,
      _TemplateFilter.traditional => BiodataTemplateCategory.traditional,
    };
    return _templates.where((template) => template.category == category).toList();
  }

  void _useSelectedTemplate() {
    final selected = _templates.where((item) => item.id == _selectedTemplateId);
    if (selected.isEmpty) return;
    final template = selected.first;
    BiodataSession.resetForNew(template.name, template.accent);
    PersonalDetailsScreen.savedDraft = null;
    FamilyDetailsScreen.savedDraft = null;
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => PersonalDetailsScreen(
          templateName: template.name,
          templateAccent: template.accent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleTemplates;

    return Scaffold(
      backgroundColor: VivahColors.ivory,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 22, 4),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: VivahColors.plumDark,
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'Choose a template',
                      style: TextStyle(
                        color: VivahColors.plumDark,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.45,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: VivahColors.border),
                    ),
                    child: const Icon(Icons.auto_awesome_outlined, color: VivahColors.gold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(22, 4, 22, 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pick a style—you can change it later.',
                  style: TextStyle(color: VivahColors.muted, fontSize: 13, height: 1.4),
                ),
              ),
            ),
            SizedBox(
              height: 42,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterChip(
                    label: 'All',
                    selected: _filter == _TemplateFilter.all,
                    onTap: () => setState(() => _filter = _TemplateFilter.all),
                  ),
                  _FilterChip(
                    label: 'Classic',
                    selected: _filter == _TemplateFilter.classic,
                    onTap: () => setState(() => _filter = _TemplateFilter.classic),
                  ),
                  _FilterChip(
                    label: 'Modern',
                    selected: _filter == _TemplateFilter.modern,
                    onTap: () => setState(() => _filter = _TemplateFilter.modern),
                  ),
                  _FilterChip(
                    label: 'Traditional',
                    selected: _filter == _TemplateFilter.traditional,
                    onTap: () => setState(() => _filter = _TemplateFilter.traditional),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: visible.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off_rounded, size: 42, color: VivahColors.muted),
                          const SizedBox(height: 10),
                          const Text('No templates in this category.'),
                          TextButton(
                            onPressed: () => setState(() => _filter = _TemplateFilter.all),
                            child: const Text('Show all templates'),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(22, 4, 22, 18),
                      itemCount: visible.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.62,
                      ),
                      itemBuilder: (context, index) {
                        final template = visible[index];
                        final isSelected = template.id == _selectedTemplateId;
                        return _TemplateOptionCard(
                          template: template,
                          selected: isSelected,
                          onTap: () => setState(() => _selectedTemplateId = template.id),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 13, 22, 16),
              decoration: BoxDecoration(
                color: VivahColors.ivory,
                border: Border(top: BorderSide(color: VivahColors.border.withValues(alpha: 0.8))),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedTemplateId == null ? 'Your design' : 'Template selected',
                            style: const TextStyle(color: VivahColors.muted, fontSize: 11),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _selectedTemplateId == null
                                ? 'Choose one to continue'
                                : _templates.firstWhere((item) => item.id == _selectedTemplateId).name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: VivahColors.plumDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _selectedTemplateId == null ? null : _useSelectedTemplate,
                      style: FilledButton.styleFrom(
                        backgroundColor: VivahColors.plum,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFE7DDE1),
                        disabledForegroundColor: VivahColors.muted,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Use This Template', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 17),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => onTap(),
        labelStyle: TextStyle(
          color: selected ? Colors.white : VivahColors.muted,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        backgroundColor: Colors.white,
        selectedColor: VivahColors.plum,
        side: BorderSide(color: selected ? VivahColors.plum : VivahColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      ),
    );
  }
}

class _TemplateOptionCard extends StatelessWidget {
  const _TemplateOptionCard({
    required this.template,
    required this.selected,
    required this.onTap,
  });

  final BiodataTemplate template;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: '${template.name}, ${template.description}${selected ? ', selected' : ''}',
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? VivahColors.plum : VivahColors.border,
                width: selected ? 2 : 1,
              ),
              boxShadow: selected
                  ? [BoxShadow(color: VivahColors.plum.withValues(alpha: 0.09), blurRadius: 14, offset: const Offset(0, 5))]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _DocumentPreview(template: template),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        template.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: VivahColors.ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (selected)
                      const Icon(Icons.check_circle_rounded, color: VivahColors.plum, size: 18),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        template.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: VivahColors.muted, fontSize: 10),
                      ),
                    ),
                    if (template.isPremium)
                      const Text(
                        'Premium',
                        style: TextStyle(color: VivahColors.gold, fontSize: 9, fontWeight: FontWeight.w800),
                      )
                    else
                      const Text(
                        'Free',
                        style: TextStyle(color: VivahColors.muted, fontSize: 9, fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentPreview extends StatelessWidget {
  const _DocumentPreview({required this.template});

  final BiodataTemplate template;

  @override
  Widget build(BuildContext context) {
    final accent = template.accent;
    final modern = template.layout == 1 || template.layout == 4;
    final floral = template.layout == 2;
    final framed = template.layout == 0 || template.layout == 3 || template.layout == 5;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: template.paper,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: accent.withValues(alpha: 0.8), width: framed ? 1.4 : 0.7),
      ),
      child: Stack(
        children: [
          if (floral)
            Positioned(
              top: -3,
              right: -3,
              child: Icon(Icons.local_florist_rounded, size: 29, color: accent.withValues(alpha: 0.18)),
            ),
          if (template.layout == 3)
            Positioned(
              top: 2,
              left: 2,
              child: Icon(Icons.auto_awesome, size: 13, color: accent.withValues(alpha: 0.75)),
            ),
          Column(
            children: [
              Container(
                width: modern ? 44 : 34,
                height: 3,
                decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(3)),
              ),
              const SizedBox(height: 7),
              Text(
                'BIODATA',
                style: TextStyle(
                  color: accent,
                  fontSize: modern ? 7 : 6,
                  fontWeight: FontWeight.w900,
                  letterSpacing: modern ? 1.4 : 1,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: modern ? 29 : 25,
                    height: modern ? 34 : 30,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(floral ? 20 : 4),
                      border: Border.all(color: accent.withValues(alpha: 0.35)),
                    ),
                    child: Icon(Icons.person_outline_rounded, color: accent, size: 18),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4, width: double.infinity, color: accent.withValues(alpha: 0.85)),
                        const SizedBox(height: 5),
                        ...List.generate(3, (_) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Container(height: 2.5, width: double.infinity, color: accent.withValues(alpha: 0.18)),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _PreviewSectionLabel(label: 'PERSONAL DETAILS', accent: accent),
              const SizedBox(height: 4),
              ...List.generate(3, (i) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Expanded(child: Container(height: 2.5, color: accent.withValues(alpha: 0.18))),
                    const SizedBox(width: 5),
                    Expanded(child: Container(height: 2.5, color: accent.withValues(alpha: 0.10))),
                  ],
                ),
              )),
              const SizedBox(height: 3),
              _PreviewSectionLabel(label: 'FAMILY', accent: accent),
              const SizedBox(height: 5),
              ...List.generate(2, (_) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(height: 2.5, width: double.infinity, color: accent.withValues(alpha: 0.15)),
              )),
              const Spacer(),
              if (framed)
                Container(height: 2, width: 30, decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(2))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewSectionLabel extends StatelessWidget {
  const _PreviewSectionLabel({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(color: accent, fontSize: 5.5, fontWeight: FontWeight.w900, letterSpacing: 0.4),
      ),
    );
  }
}
