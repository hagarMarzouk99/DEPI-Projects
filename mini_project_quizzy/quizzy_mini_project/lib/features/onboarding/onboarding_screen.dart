import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzy_mini_project/core/services/local_storage.dart';
import 'package:quizzy_mini_project/features/onboarding/logic/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:quizzy_mini_project/core/routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(context.read<LocalStorage>()),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnboardingItem> _items = [
    OnboardingItem(
      step: 'STEP 1 OF 3',
      title: 'Make Learning Fun',
      description: 'Explore exciting quizzes and test your knowledge across different topics.',
      footerIcon: Icons.bolt,
      footerText: 'Over 10,000+ trivia challenges await',
      imageWidget: _buildPhoneIllustration(),
    ),
    OnboardingItem(
      step: 'STEP 2 OF 3',
      title: 'See Your Progress',
      description: 'Track your scores, learn from your mistakes, and improve with every quiz.',
      footerIcon: Icons.bolt,
      footerText: 'Real-time analytics & mastery tracking',
      imageWidget: _buildResultIllustration(),
    ),
    OnboardingItem(
      step: 'STEP 3 OF 3',
      title: 'Ready to Challenge Yourself?',
      description: 'Your next challenge is waiting. Start playing, discover new topics, and put your knowledge to the ultimate test.',
      footerIcon: Icons.bolt,
      footerText: '+500 XP Ready',
      imageWidget: _buildTrophyIllustration(),
    ),
  ];

  Future<void> _finishOnboarding() async {
    await context.read<OnboardingCubit>().finish();

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130E26),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF221A45),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: const Icon(Icons.quiz, color: Color(0xFF22C55E), size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Quizzy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF22C55E),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _finishOnboarding,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: context.read<OnboardingCubit>().pageChanged,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration Container
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.white : const Color(0xFF1B1438),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              item.imageWidget,
                              if (index == 2)
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.emoji_events, size: 14, color: Color(0xFF22C55E)),
                                        SizedBox(width: 4),
                                        Text('1st Place', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Step badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bolt, size: 14, color: Color(0xFF22C55E)),
                              const SizedBox(width: 4),
                              Text(
                                item.step,
                                style: const TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Description
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 14.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bottom Controls
            BlocBuilder<OnboardingCubit, int>(
              builder: (context, currentIndex) => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _items.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xFF22C55E),
                      dotColor: Colors.white24,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                      spacing: 6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex < _items.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _finishOnboarding();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFF22C55E).withValues(alpha: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentIndex == _items.length - 1 ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bolt, size: 14, color: Color(0xFF22C55E)),
                      const SizedBox(width: 6),
                      Text(
                        _items[currentIndex].footerText,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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

  static Widget _buildPhoneIllustration() {
    return Center(
      child: Container(
        width: 140,
        height: 230,
        decoration: BoxDecoration(
          color: const Color(0xFF18122B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF22C55E), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF22C55E).withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 40, height: 6, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(3))),
            const SizedBox(height: 16),
            Container(
              width: 110,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2050),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Fun Quiz', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
            const SizedBox(height: 10),
            Container(width: 110, height: 26, decoration: BoxDecoration(color: const Color(0xFF22C55E), borderRadius: BorderRadius.circular(8))),
            const SizedBox(height: 8),
            Container(width: 110, height: 26, decoration: BoxDecoration(color: const Color(0xFF352963), borderRadius: BorderRadius.circular(8))),
            const SizedBox(height: 8),
            Container(width: 110, height: 26, decoration: BoxDecoration(color: const Color(0xFF352963), borderRadius: BorderRadius.circular(8))),
          ],
        ),
      ),
    );
  }

  static Widget _buildResultIllustration() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 230,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
              ),
            ],
          ),
          child: Column(
            children: [
              const Text('Quizzy Results!', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text('95%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.bar_chart, color: Color(0xFF22C55E), size: 24),
                      const SizedBox(height: 4),
                      const Text('Weekly Growth', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.military_tech, color: Colors.amber, size: 24),
                      const SizedBox(height: 4),
                      const Text('Perfect Score', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.shield, color: Colors.blueAccent, size: 24),
                      const SizedBox(height: 4),
                      const Text('Top Learner', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildTrophyIllustration() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF251C48),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF22C55E).withValues(alpha: 0.35),
                blurRadius: 35,
                spreadRadius: 8,
              ),
            ],
          ),
          child: const Icon(Icons.emoji_events, size: 84, color: Color(0xFF22C55E)),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.4)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, size: 14, color: Color(0xFF22C55E)),
              SizedBox(width: 4),
              Text('+500 XP Ready', style: TextStyle(color: Color(0xFF22C55E), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

class OnboardingItem {
  final String step;
  final String title;
  final String description;
  final IconData footerIcon;
  final String footerText;
  final Widget imageWidget;

  OnboardingItem({
    required this.step,
    required this.title,
    required this.description,
    required this.footerIcon,
    required this.footerText,
    required this.imageWidget,
  });
}
