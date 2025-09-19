import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'New Message',
      body: 'John Doe sent you a message about iPhone 14',
      time: '10 minutes ago',
      isRead: false,
    ),
    NotificationItem(
      title: 'Price Drop Alert',
      body: 'MacBook Pro you viewed dropped price to P1,099',
      time: '2 hours ago',
      isRead: false,
    ),
    NotificationItem(
      title: 'Order Shipped',
      body: 'Your iPhone 15 Pro has been shipped',
      time: '1 day ago',
      isRead: true,
    ),
    NotificationItem(
      title: 'Welcome to ByteBack!',
      body: 'Start buying and selling to reduce e-waste',
      time: '3 days ago',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: _markAllAsRead,
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? const Center(
        child: Text('No notifications yet'),
      )
          : ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Dismissible(
            key: Key(notification.title),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                _notifications.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Dismissed ${notification.title}')),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: notification.isRead
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight:
                  notification.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body),
                  const SizedBox(height: 4),
                  Text(
                    notification.time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: notification.isRead
                  ? null
                  : const Icon(Icons.circle, size: 10, color: Colors.blue),
              onTap: () {
                if (!notification.isRead) {
                  setState(() {
                    notification.isRead = true;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }
}

class NotificationItem {
  String title;
  String body;
  String time;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });
}