import 'package:flutter/material.dart';

const Color _textColor = Color(0xFF171717);
const Color _mutedTextColor = Color(0xFF737373);

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const List<_NotificationGroup> _groups = [
    _NotificationGroup(
      title: 'Today',
      notifications: [
        _NotificationData(
          title: 'Payment Successful!',
          message: 'You have made a salon payment',
          color: Color(0xFFFFA51F),
          icon: Icons.account_balance_wallet_rounded,
        ),
      ],
    ),
    _NotificationGroup(
      title: 'Yesterday',
      notifications: [
        _NotificationData(
          title: 'New Services Available!',
          message: 'Now you can search the nearest salon',
          color: Color(0xFFFF6585),
          icon: Icons.add_box_rounded,
        ),
        _NotificationData(
          title: "Today's Special Offers",
          message: 'You get a special promo today!',
          color: Color(0xFFFFD228),
          icon: Icons.people_alt_rounded,
        ),
      ],
    ),
    _NotificationGroup(
      title: 'December 11, 2024',
      notifications: [
        _NotificationData(
          title: 'Credit Card Connected!',
          message: 'Credit Card has been linked!',
          color: Color(0xFF4D8BEF),
          icon: Icons.credit_card_rounded,
        ),
        _NotificationData(
          title: 'Account Setup Successful!',
          message: 'Your account has been created!',
          color: Color(0xFF45D287),
          icon: Icons.person_rounded,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          children: [
            const _NotificationHeader(),
            const SizedBox(height: 24),
            for (final group in _groups) ...[
              _GroupLabel(title: group.title),
              const SizedBox(height: 16),
              for (final notification in group.notifications) ...[
                _NotificationCard(notification: notification),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 2),
            ],
          ],
        ),
      ),
    );
  }
}

class _NotificationHeader extends StatelessWidget {
  const _NotificationHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: _textColor, size: 24),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Text(
            'Notification',
            style: TextStyle(
              color: _textColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _textColor, width: 1.1),
          ),
          child: const Icon(Icons.more_horiz, color: _textColor, size: 14),
        ),
      ],
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: _textColor,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final _NotificationData notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 18,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _NotificationIcon(notification: notification),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _mutedTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.notification});

  final _NotificationData notification;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 1, left: 5, child: _Dot(color: notification.color)),
          Positioned(top: 7, right: 1, child: _Dot(color: notification.color)),
          Positioned(
            bottom: 5,
            left: 1,
            child: _Dot(color: notification.color),
          ),
          Positioned(
            bottom: 0,
            right: 9,
            child: _Dot(color: notification.color),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: notification.color,
              shape: BoxShape.circle,
            ),
            child: Icon(notification.icon, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _NotificationGroup {
  const _NotificationGroup({required this.title, required this.notifications});

  final String title;
  final List<_NotificationData> notifications;
}

class _NotificationData {
  const _NotificationData({
    required this.title,
    required this.message,
    required this.color,
    required this.icon,
  });

  final String title;
  final String message;
  final Color color;
  final IconData icon;
}
