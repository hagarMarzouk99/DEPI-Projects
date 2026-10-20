import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/routes/app_routes.dart';
import '../features/auth/data/user_model.dart';
import '../features/auth/logic/auth_cubit.dart';
import '../features/progress/logic/progress_cubit.dart';
import '../features/progress/logic/progress_state.dart';
import '../features/settings/logic/settings_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool get isDark => context.read<SettingsCubit>().state.isDark;
  bool get notifications =>
      context.read<SettingsCubit>().state.notificationsEnabled;
  ProgressState get stats => context.read<ProgressCubit>().state;
  UserModel? get user => context.read<AuthCubit>().state.user;

  Color get cardColor => Theme.of(context).colorScheme.surfaceContainerHighest;
  Color get mainColor => isDark ? Colors.white : const Color(0xFF1E1B4B);
  Color get subColor => isDark ? Colors.white70 : Colors.black54;

  Future<void> _logout() async {
    await context.read<AuthCubit>().logout();
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget statCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: mainColor),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(label, style: TextStyle(fontSize: 11, color: subColor)),
          ],
        ),
      ),
    );
  }

  Widget badge(IconData icon, String label, bool unlocked) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: unlocked
              ? const Color(0xFF5CF05C)
              : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
          child: Icon(
            icon,
            color: unlocked ? const Color(0xFF1E1B4B) : Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget buildPage(BuildContext context) {
    final account = user;
    final progress = stats;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5CF05C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bolt,
                        size: 18,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('QUIZZY', style: TextStyle(fontSize: 9)),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.notifications_none),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF1E1B4B),
                    child: Text(
                      account?.initials ?? '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    account?.name ?? 'Player',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (account != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      account.email,
                      style: TextStyle(fontSize: 12, color: subColor),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5CF05C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Level ${progress.level}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level ${progress.level}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${progress.xpInLevel} / $kXpPerLevel XP',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress.levelProgress,
                      minHeight: 8,
                      color: isDark
                          ? const Color(0xFF5CF05C)
                          : const Color(0xFF1E1B4B),
                      backgroundColor:
                          isDark ? Colors.grey.shade700 : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${progress.xpToNextLevel} XP to reach Level ${progress.level + 1}',
                    style: TextStyle(fontSize: 11, color: subColor),
                  ),
                ],
              ),
            ),
            sectionTitle('Stats'),
            Row(
              children: [
                statCard('${progress.quizzesTaken}', 'Quizzes', Icons.quiz),
                const SizedBox(width: 10),
                statCard(
                  '${progress.averageScorePercent}%',
                  'Avg Score',
                  Icons.bar_chart,
                ),
                const SizedBox(width: 10),
                statCard(
                  '${progress.streakDays}',
                  'Day Streak',
                  Icons.local_fire_department,
                ),
              ],
            ),
            sectionTitle('Badges'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                badge(Icons.emoji_events, 'Champion', progress.hasChampion),
                badge(Icons.local_fire_department, 'On Fire', progress.hasOnFire),
                badge(Icons.bolt, 'Speedster', progress.hasSpeedster),
                badge(Icons.workspace_premium, 'Master', progress.hasMaster),
              ],
            ),
            sectionTitle('Settings'),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Dark theme'),
                      secondary: const Icon(Icons.dark_mode_outlined),
                      value: isDark,
                      onChanged: context.read<SettingsCubit>().setDark,
                    ),
                    SwitchListTile(
                      title: const Text('Notifications'),
                      secondary: const Icon(Icons.notifications_none),
                      value: notifications,
                      onChanged:
                          context.read<SettingsCubit>().setNotifications,
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Log out'),
                      onTap: _logout,
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

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsCubit>();
    context.watch<ProgressCubit>();
    context.watch<AuthCubit>();

    return buildPage(context);
  }
}
