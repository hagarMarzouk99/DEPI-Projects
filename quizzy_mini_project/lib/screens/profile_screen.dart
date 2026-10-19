import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  bool notifications = true;

  Color get cardColor => isDark ? Colors.grey.shade800 : Colors.grey.shade100;
  Color get mainColor => isDark ? Colors.white : const Color(0xFF1E1B4B);
  Color get subColor => isDark ? Colors.white70 : Colors.black54;

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
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF1E1B4B),
                    child: Text(
                      'MA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mariam',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5CF05C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Level 5',
                      style: TextStyle(
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Level 5', style: TextStyle(fontSize: 12)),
                      Text('700 / 1000 XP', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.7,
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
                    '300 XP to reach Level 6',
                    style: TextStyle(fontSize: 11, color: subColor),
                  ),
                ],
              ),
            ),
            sectionTitle('Stats'),
            Row(
              children: [
                statCard('24', 'Quizzes', Icons.quiz),
                const SizedBox(width: 10),
                statCard('82%', 'Avg Score', Icons.bar_chart),
                const SizedBox(width: 10),
                statCard('7', 'Day Streak', Icons.local_fire_department),
              ],
            ),
            sectionTitle('Badges'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                badge(Icons.emoji_events, 'Champion', true),
                badge(Icons.local_fire_department, 'On Fire', true),
                badge(Icons.bolt, 'Speedster', true),
                badge(Icons.workspace_premium, 'Master', false),
              ],
            ),
            sectionTitle('Settings'),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Dark theme'),
                    secondary: const Icon(Icons.dark_mode_outlined),
                    value: isDark,
                    onChanged: (value) {
                      setState(() {
                        isDark = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    secondary: const Icon(Icons.notifications_none),
                    value: notifications,
                    onChanged: (value) {
                      setState(() {
                        notifications = value;
                      });
                    },
                  ),
                  const ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDark ? ThemeData.dark() : Theme.of(context),
      child: buildPage(context),
    );
  }
}