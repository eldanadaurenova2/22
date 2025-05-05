import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hotel Booking App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: const NotificationsPage(),
        );
      },
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': '📅 Бронирование приближается',
      'subtitle': 'Rixos Astana — заезд 20 апреля',
      'category': 'reminder',
      'read': false,
    },
    {
      'title': '🏨 Заселение через 3 дня',
      'subtitle': 'Hilton Astana — 23 апреля',
      'category': 'reminder',
      'read': false,
    },
    {
      'title': '🔥 Скидка 20% на Ritz Almaty',
      'subtitle': 'До 25 апреля!',
      'category': 'offer',
      'read': false,
    },
    {
      'title': '🚀 Добавлена тёмная тема',
      'subtitle': 'Смените в профиле или настройках',
      'category': 'update',
      'read': false,
    },
  ];

  void markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  void clearAll() {
    setState(() {
      notifications.clear();
    });
  }

  Widget buildNotificationItem(int index) {
    final item = notifications[index];
    return ListTile(
      leading: Icon(
        item['read'] ? Icons.notifications_none : Icons.notifications_active,
        color: item['read'] ? Colors.grey : Colors.blue,
      ),
      title: Text(
        item['title'],
        style: TextStyle(
          color: item['read'] ? Colors.grey : null,
          fontWeight: item['read'] ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(item['subtitle']),
      trailing: item['read']
          ? const Icon(Icons.check, size: 16, color: Colors.grey)
          : const Icon(Icons.mark_email_read_outlined, size: 18),
      onTap: () => markAsRead(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Уведомления"),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            tooltip: 'Сменить тему',
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          if (notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Очистить всё',
              onPressed: clearAll,
            ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("Нет уведомлений"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => buildNotificationItem(index),
            ),
    );
  }
}
