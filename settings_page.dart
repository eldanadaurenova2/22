import 'package:flutter/material.dart';
import 'main.dart'; // Импорт themeNotifier

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'Русский';

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Предпочтения',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 🌐 Язык
          ListTile(
            title: const Text("Язык"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'Русский', child: Text('Русский')),
                DropdownMenuItem(value: 'English', child: Text('English')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
          ),

          // 🔔 Уведомления
          SwitchListTile(
            title: const Text('Уведомления'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),

          // 🌙 Темная тема
          SwitchListTile(
            title: const Text('Тёмная тема'),
            value: isDarkTheme,
            onChanged: (value) {
              setState(() {
                themeNotifier.value =
                    value ? ThemeMode.dark : ThemeMode.light;
              });
            },
          ),

          const Divider(height: 32),

          const ListTile(
            title: Text("О приложении"),
            subtitle: Text("Hotel Booking v1.0\nРазработано студентом AITU ❤️"),
          ),
        ],
      ),
    );
  }
}
