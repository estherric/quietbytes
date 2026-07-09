import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';
import '../components/custom_button.dart';
import '../app/auth_service.dart';

class EventDetail extends StatefulWidget {
  final String eventId;
  const EventDetail({super.key, required this.eventId});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  Map<String, dynamic>? eventData;
  bool isLoading = true;
  bool isRsvpd = false;
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    currentUserId = authService.value.currentUser!.uid;
    loadEvent();
  }

  Future<void> loadEvent() async {
    final doc = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .get();

    if (mounted) {
      final data = doc.data();
      final attendees = List<String>.from(data?['attendees'] ?? []);
      setState(() {
        eventData = data;
        isRsvpd = attendees.contains(currentUserId);
        isLoading = false;
      });
    }
  }

  Future<void> toggleRsvp() async {
    final ref = FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId);

    if (isRsvpd) {
      await ref.update({
        'attendees': FieldValue.arrayRemove([currentUserId]),
      });
    } else {
      await ref.update({
        'attendees': FieldValue.arrayUnion([currentUserId]),
      });
    }

    setState(() {
      isRsvpd = !isRsvpd;
    });
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
              CustomHeaders(
                title: eventData?['title'] ?? 'Event',
                showBack: true,
                showSettings: false,
              ),
              const SizedBox(height: AppSpacing.pillsSpacing),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.pillBorderRadius,
                        ),
                      ),
                    ),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category chip
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.rose,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    eventData?['category'] ?? '',
                                    style: TextStyle(
                                      fontFamily: 'Jersey20',
                                      fontSize: 20,
                                      color: AppColors.cream,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Date
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: AppColors.gold,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      () {
                                        final date =
                                            (eventData?['date'] as Timestamp)
                                                .toDate();
                                        return '${date.month}/${date.day}/${date.year} • ${date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}';
                                      }(),
                                      style: TextStyle(
                                        fontFamily: 'Jersey20',
                                        fontSize: 26,
                                        color: AppColors.cream,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Location
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.gold,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      eventData?['location'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Jersey20',
                                        fontSize: 26,
                                        color: AppColors.cream,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Description
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontFamily: 'Jersey20',
                                    fontSize: 26,
                                    color: AppColors.gold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  eventData?['description'] ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Jersey20',
                                    fontSize: 22,
                                    color: AppColors.cream.withValues(
                                      alpha: 0.9,
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                // RSVP button GOLD when RSVP, ROSE when not RSVP
                                isRsvpd
                                    ? GestureDetector(
                                        onTap: toggleRsvp,
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              AppSpacing.pillBorderRadius,
                                            ),
                                            border: Border.all(
                                              color: AppColors.rose,
                                              width: 2,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Cancel RSVP',
                                              style: TextStyle(
                                                fontFamily: 'Jersey20',
                                                fontSize: 24,
                                                color: AppColors.rose,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : CustomButton(
                                        text: 'RSVP',
                                        onTap: toggleRsvp,
                                      ),
                              ],
                            ),
                          ),
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
