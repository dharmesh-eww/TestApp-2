import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _routeAfterStartup();
  }

  Future<void> _routeAfterStartup() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    var completed = OnboardingScreen.completedInSession;
    try {
      final preferences = await SharedPreferences.getInstance();
      completed = completed || preferences.getBool('vivah_onboarding_completed') == true;
    } catch (_) {
      // If preferences are unavailable, onboarding remains accessible and recoverable.
    }
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => completed ? const HomeScreen() : OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: VivahColors.ivory,
    body: SafeArea(
      child: Stack(children: [
        Positioned(top: 44, left: -34, child: _Ornament(color: VivahColors.gold.withValues(alpha: .10), size: 150)),
        Positioned(bottom: 70, right: -35, child: _Ornament(color: VivahColors.plum.withValues(alpha: .07), size: 190)),
        Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 78, height: 78, decoration: BoxDecoration(color: VivahColors.plum, borderRadius: BorderRadius.circular(26), boxShadow: const [BoxShadow(color: Color(0x1F642C45), blurRadius: 22, offset: Offset(0, 8))]), child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 39)),
          const SizedBox(height: 20),
          const Text('Vivah Bio', style: TextStyle(color: VivahColors.plumDark, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -.8)),
          const SizedBox(height: 7),
          const Text('Your story, beautifully presented.', style: TextStyle(color: VivahColors.muted, fontSize: 14)),
        ])),
        const Positioned(left: 0, right: 0, bottom: 38, child: Column(children: [
          SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: VivahColors.gold)),
          SizedBox(height: 12),
          Text('Preparing your workspace…', style: TextStyle(color: VivahColors.muted, fontSize: 12)),
        ])),
      ]),
    ),
  );
}

class _Ornament extends StatelessWidget {
  const _Ornament({required this.color, required this.size});
  final Color color; final double size;
  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size, child: CustomPaint(painter: _OrnamentPainter(color)));
}

class _OrnamentPainter extends CustomPainter {
  _OrnamentPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.2;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    for (var i = 0; i < 5; i++) {
      final inset = i * 13.0;
      canvas.drawRRect(RRect.fromRectAndRadius(rect.deflate(inset), const Radius.circular(35)), paint);
    }
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width * .19, paint);
  }
}
