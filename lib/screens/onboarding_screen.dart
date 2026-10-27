import 'package:flutter/material.dart';

import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  static bool completedInSession = false;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _page = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      eyebrow: 'MADE FOR YOUR STORY',
      title: 'Create a biodata that feels like you',
      description: 'Choose a thoughtful design and make a beautiful first impression.',
      icon: Icons.auto_awesome_rounded,
      motif: 0,
    ),
    _OnboardingPage(
      eyebrow: 'SIMPLE, STEP BY STEP',
      title: 'Your details, your way',
      description: 'Add personal, family and career details at your own pace. Every optional field stays optional.',
      icon: Icons.edit_document,
      motif: 1,
    ),
    _OnboardingPage(
      eyebrow: 'READY WHEN YOU ARE',
      title: 'Preview, save and share',
      description: 'Review your document, choose what contact details to show, then create a printable PDF.',
      icon: Icons.ios_share_rounded,
      motif: 2,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finish() {
    OnboardingScreen.completedInSession = true;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  void _next() {
    if (_page == _pages.length - 1) {
      _finish();
    } else {
      _pageController.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_page];
    return Scaffold(
      backgroundColor: VivahColors.ivory,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        child: Column(children: [
          Row(children: [
            Container(width: 35, height: 35, decoration: BoxDecoration(color: VivahColors.plum, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 19)),
            const SizedBox(width: 9),
            const Text('Vivah Bio', style: TextStyle(color: VivahColors.plumDark, fontSize: 18, fontWeight: FontWeight.w800)),
            const Spacer(),
            TextButton(onPressed: _finish, style: TextButton.styleFrom(foregroundColor: VivahColors.muted), child: const Text('Skip')),
          ]),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (context, index) => _OnboardingIllustration(page: _pages[index]),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Column(
              key: ValueKey(_page),
              children: [
                Text(page.eyebrow, style: const TextStyle(color: VivahColors.gold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
                const SizedBox(height: 12),
                Text(page.title, textAlign: TextAlign.center, style: const TextStyle(color: VivahColors.plumDark, fontSize: 28, height: 1.12, fontWeight: FontWeight.w800, letterSpacing: -.7)),
                const SizedBox(height: 12),
                Text(page.description, textAlign: TextAlign.center, style: const TextStyle(color: VivahColors.muted, fontSize: 14, height: 1.5)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_pages.length, (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _page == index ? 24 : 7,
            height: 7,
            decoration: BoxDecoration(color: _page == index ? VivahColors.plum : VivahColors.border, borderRadius: BorderRadius.circular(8)),
          ))),
          const SizedBox(height: 22),
          SizedBox(width: double.infinity, child: FilledButton(
            onPressed: _next,
            style: FilledButton.styleFrom(backgroundColor: VivahColors.plum, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 17), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_page == _pages.length - 1 ? 'Get Started' : 'Continue', style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(width: 9),
              const Icon(Icons.arrow_forward_rounded, size: 18),
            ]),
          )),
        ]),
      )),
    );
  }
}

class _OnboardingPage {
  const _OnboardingPage({required this.eyebrow, required this.title, required this.description, required this.icon, required this.motif});
  final String eyebrow, title, description;
  final IconData icon;
  final int motif;
}

class _OnboardingIllustration extends StatelessWidget {
  const _OnboardingIllustration({required this.page});
  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) => Center(
    child: AspectRatio(
      aspectRatio: .9,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 360),
        margin: const EdgeInsets.fromLTRB(8, 12, 8, 18),
        decoration: BoxDecoration(color: const Color(0xFFF5EEE7), borderRadius: BorderRadius.circular(32)),
        child: Stack(alignment: Alignment.center, children: [
          Positioned(top: 20, right: 22, child: Icon(Icons.auto_awesome, color: VivahColors.gold.withValues(alpha: .45), size: 27)),
          Positioned(bottom: 24, left: 24, child: Icon(Icons.local_florist_outlined, color: VivahColors.plum.withValues(alpha: .25), size: 40)),
          Container(
            width: 205,
            height: 275,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFFFFDF9), borderRadius: BorderRadius.circular(14), border: Border.all(color: VivahColors.gold.withValues(alpha: .8), width: 1.5), boxShadow: const [BoxShadow(color: Color(0x1A432032), blurRadius: 24, offset: Offset(0, 12))]),
            child: Column(children: [
              Container(width: 55, height: 3, decoration: BoxDecoration(color: VivahColors.gold, borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 10),
              const Text('MARRIAGE BIODATA', style: TextStyle(color: VivahColors.gold, fontSize: 7, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(height: 15),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(width: 52, height: 62, decoration: BoxDecoration(color: VivahColors.rose, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.person_outline_rounded, color: VivahColors.plum, size: 31)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 6, width: 78, decoration: BoxDecoration(color: VivahColors.plum, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(height: 8),
                  ...List.generate(3, (_) => Padding(padding: const EdgeInsets.only(bottom: 5), child: Container(height: 3, width: double.infinity, color: VivahColors.border))),
                ])),
              ]),
              const SizedBox(height: 16),
              ...List.generate(3, (section) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(height: 4, width: 62 + (section * 10), decoration: BoxDecoration(color: section == page.motif ? VivahColors.plum : VivahColors.gold.withValues(alpha: .8), borderRadius: BorderRadius.circular(3))),
                const SizedBox(height: 7),
                ...List.generate(2, (_) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Container(height: 3, width: double.infinity, color: VivahColors.border))),
              ]))),
              const Spacer(),
              Icon(page.icon, color: VivahColors.plum, size: 24),
            ]),
          ),
          Positioned(bottom: 30, right: 20, child: Container(width: 58, height: 58, decoration: const BoxDecoration(color: VivahColors.plum, shape: BoxShape.circle), child: Icon(page.icon, color: Colors.white, size: 25))),
        ]),
      ),
    ),
  );
}
