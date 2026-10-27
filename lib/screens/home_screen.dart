import 'package:flutter/material.dart';

class VivahColors {
  static const plum = Color(0xFF642C45);
  static const plumDark = Color(0xFF432032);
  static const gold = Color(0xFFB88A4A);
  static const ivory = Color(0xFFFCF9F4);
  static const rose = Color(0xFFF4E8EA);
  static const ink = Color(0xFF282329);
  static const muted = Color(0xFF777078);
  static const border = Color(0xFFE9E0DA);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature will be connected when that screen is implemented.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: VivahColors.plumDark,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VivahColors.ivory,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _TopBar(onSettings: () => _showComingSoon(context, 'Settings')),
                  const SizedBox(height: 30),
                  const Text(
                    'YOUR STORY, BEAUTIFULLY PRESENTED',
                    style: TextStyle(
                      color: VivahColors.gold,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.55,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Let’s create your\nbiodata.',
                    style: TextStyle(
                      color: VivahColors.plumDark,
                      fontSize: 32,
                      height: 1.12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A thoughtful first impression starts with a story that feels like you.',
                    style: TextStyle(
                      color: VivahColors.muted,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _CreateCard(
                    onTap: () => _showComingSoon(context, 'Create biodata'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Continue editing',
                          style: TextStyle(
                            color: VivahColors.ink,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showComingSoon(context, 'My biodatas'),
                        style: TextButton.styleFrom(
                          foregroundColor: VivahColors.plum,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: const Text('My biodatas'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _EmptyDraftCard(),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Find your style',
                          style: TextStyle(
                            color: VivahColors.ink,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showComingSoon(context, 'Template gallery'),
                        style: TextButton.styleFrom(
                          foregroundColor: VivahColors.plum,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 174,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _TemplateCard(
                          title: 'The Classic',
                          subtitle: 'Timeless & elegant',
                          style: _TemplateStyle.classic,
                          onTap: () => _showComingSoon(context, 'Template selection'),
                        ),
                        const SizedBox(width: 12),
                        _TemplateCard(
                          title: 'Modern Minimal',
                          subtitle: 'Clean & confident',
                          style: _TemplateStyle.modern,
                          onTap: () => _showComingSoon(context, 'Template selection'),
                        ),
                        const SizedBox(width: 12),
                        _TemplateCard(
                          title: 'Floral Grace',
                          subtitle: 'Soft & traditional',
                          style: _TemplateStyle.floral,
                          onTap: () => _showComingSoon(context, 'Template selection'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PrivacyNote(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onSettings});

  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: VivahColors.plum,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vivah Bio',
                style: TextStyle(
                  color: VivahColors.plumDark,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.45,
                ),
              ),
              Text(
                'Marriage biodata maker',
                style: TextStyle(color: VivahColors.muted, fontSize: 11),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Settings',
          onPressed: onSettings,
          icon: const Icon(Icons.tune_rounded, color: VivahColors.plumDark),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: VivahColors.border),
            minimumSize: const Size(44, 44),
          ),
        ),
      ],
    );
  }
}

class _CreateCard extends StatelessWidget {
  const _CreateCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: VivahColors.plum,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(21),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [VivahColors.plum, VivahColors.plumDark],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -18,
                top: -24,
                child: Icon(
                  Icons.local_florist_outlined,
                  size: 130,
                  color: Colors.white.withValues(alpha: 0.055),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    child: const Icon(Icons.note_add_outlined, color: Colors.white, size: 25),
                  ),
                  const SizedBox(height: 23),
                  const Text(
                    'Create new biodata',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose a design and make it yours.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Text(
                        'Get started',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: VivahColors.gold,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyDraftCard extends StatelessWidget {
  const _EmptyDraftCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: VivahColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 58,
            decoration: BoxDecoration(
              color: VivahColors.rose,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_outlined, color: VivahColors.plum, size: 26),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nothing here just yet',
                  style: TextStyle(
                    color: VivahColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Your saved biodata will appear here.',
                  style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _TemplateStyle { classic, modern, floral }

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({
    required this.title,
    required this.subtitle,
    required this.style,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final _TemplateStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = switch (style) {
      _TemplateStyle.classic => VivahColors.gold,
      _TemplateStyle.modern => VivahColors.plum,
      _TemplateStyle.floral => const Color(0xFFAD777F),
    };

    return SizedBox(
      width: 142,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: VivahColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFCF8),
                      border: Border.all(color: accent.withValues(alpha: 0.65), width: 1.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(3)),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 26,
                              decoration: BoxDecoration(
                                color: accent.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(Icons.person_outline, size: 15, color: accent),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                children: List.generate(
                                  4,
                                  (index) => Container(
                                    height: 2.5,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: index == 0 ? accent : VivahColors.border,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        ...List.generate(
                          3,
                          (index) => Container(
                            height: 2.5,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: VivahColors.border,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: VivahColors.ink, fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: VivahColors.muted, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5EFE7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, size: 18, color: VivahColors.gold),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your details belong to you. You decide what appears on the biodata you share.',
              style: TextStyle(color: VivahColors.muted, fontSize: 12, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}
