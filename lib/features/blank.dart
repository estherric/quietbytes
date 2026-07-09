import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';
import '../app/auth_service.dart';
import '../features/event_detail.dart';

class Blank extends StatefulWidget {
  const Blank({super.key});

  @override
  State<Blank> createState() => _BlankState();
}

class _BlankState extends State<Blank> {
  List<Map<String, dynamic>> events = [];
  String currentUserId = '';

  static const String hikingEventId = 'uCXi5bh1iXo0rJ0CJEZy';
  static const String cookingEventId = 'uuqScq3XYIYhjuOvR0do';
  static const String cafeEventId = 'wdmpTVSbWkyLzohcjIH3';

  // Pin positions (left%, top%)
  final List<Map<String, dynamic>> pins = [
    {'eventId': 'uCXi5bh1iXo0rJ0CJEZy', 'left': 0.77, 'top': 0.08},
    {'eventId': 'uuqScq3XYIYhjuOvR0do', 'left': 0.60, 'top': 0.50},
    {'eventId': 'wdmpTVSbWkyLzohcjIH3', 'left': 0.45, 'top': 0.70},
  ];

  @override
  void initState() {
    super.initState();
    currentUserId = authService.value.currentUser!.uid;
    loadEvents();
  }

  Future<void> loadEvents() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .get();

    if (mounted) {
      setState(() {
        events = snapshot.docs.map((doc) {
          return {'id': doc.id, ...doc.data()};
        }).toList();
      });
    }
  }

  bool isRsvpd(String eventId) {
    final event = events.firstWhere(
      (e) => e['id'] == eventId,
      orElse: () => {},
    );
    if (event.isEmpty) return false;
    final attendees = List<String>.from(event['attendees'] ?? []);
    return attendees.contains(currentUserId);
  }

  Map<String, dynamic>? getEvent(String eventId) {
    try {
      return events.firstWhere((e) => e['id'] == eventId);
    } catch (_) {
      return null;
    }
  }

  void showEventBottomSheet(String eventId) {
    final event = getEvent(eventId);
    if (event == null) return;

    final date = (event['date'] as Timestamp).toDate();
    final rsvpd = isRsvpd(eventId);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.pillBorderRadius),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category chip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: rsvpd ? AppColors.rose : AppColors.lavender,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  event['category'] ?? '',
                  style: TextStyle(
                    fontFamily: 'Jersey20',
                    fontSize: 16,
                    color: AppColors.cream,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                event['title'] ?? '',
                style: TextStyle(
                  fontFamily: 'Jersey20',
                  fontSize: 26,
                  color: AppColors.cream,
                ),
              ),
              const SizedBox(height: 12),

              // Date
              Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColors.gold, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${date.month}/${date.day}/${date.year} • ${date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}',
                    style: TextStyle(
                      fontFamily: 'Jersey20',
                      fontSize: 18,
                      color: AppColors.cream,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Location
              Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.gold, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    event['location'] ?? '',
                    style: TextStyle(
                      fontFamily: 'Jersey20',
                      fontSize: 18,
                      color: AppColors.cream,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // View Event button
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context); // close bottom sheet
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetail(eventId: eventId),
                    ),
                  );
                  loadEvents(); // refresh RSVP state on return
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.pillBorderRadius,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'View Event',
                      style: TextStyle(
                        fontFamily: 'Jersey20',
                        fontSize: 22,
                        color: AppColors.purple,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavender,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPaddingWidth,
            vertical: AppSpacing.verticalPaddingIsland,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomHeaders(title: 'Discover', showSettings: true),
              const SizedBox(height: AppSpacing.pillsSpacing),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Purple pill background
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.pillBorderRadius,
                        ),
                      ),
                    ),

                    // Map image clipped to pill shape
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.pillBorderRadius,
                      ),
                      child: SizedBox.expand(
                        child: Image.asset(
                          'assets/images/map_temp.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),

                    // Pins on top of map
                    ...pins.map((pin) {
                      final eventId = pin['eventId'] as String;
                      final rsvpd = isRsvpd(eventId);

                      return Align(
                        alignment: Alignment(
                          (pin['left'] as double) * 2 - 1,
                          (pin['top'] as double) * 2 - 1,
                        ),
                        child: GestureDetector(
                          onTap: () => showEventBottomSheet(eventId),
                          child: Icon(
                            Icons.location_on,
                            size: 40,
                            color: rsvpd ? AppColors.rose : AppColors.gold,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
