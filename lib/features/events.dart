import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/auth_service.dart';
import 'event_detail.dart';

//Rename and change Blank to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class Events extends StatefulWidget {
  final VoidCallback? onBack;
  const Events({super.key, this.onBack});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<Map<String, dynamic>> events = [];
  bool isLoading = true;
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    currentUserId = authService.value.currentUser!.uid;
    loadEvents();
  }

  Future<void> loadEvents() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .orderBy('date')
        .get();

    if (mounted) {
      setState(() {
        events = snapshot.docs.map((doc) {
          return {'id': doc.id, ...doc.data()};
        }).toList();
        isLoading = false;
      });
    }
  }

  bool isRsvpd(Map<String, dynamic> event) {
    final attendees = List<String>.from(event['attendees'] ?? []);
    return attendees.contains(currentUserId);
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
              //Top pill (Template Page)
              CustomHeaders(
                title: 'Events',
                showBack: true,
                showSettings: true,
                onBack: widget.onBack,
              ),

              const SizedBox(
                height: AppSpacing.pillsSpacing,
              ), // Spacing between the two pills
              //2nd Pill (Background pill, login, )
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

                    // Put whatever you want in the purple pill here (logo, text, buttons, etc.)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                      ), //How far the text is from the top of the purple pill
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : events.isEmpty
                          ? Center(
                              child: Text(
                                'No events found.',
                                style: TextStyle(
                                  color: AppColors.cream,
                                  fontSize: 22,
                                  fontFamily: 'Jersey20',
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                final rsvpd = isRsvpd(event);
                                final date = (event['date'] as Timestamp)
                                    .toDate();

                                return GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventDetail(eventId: event['id']),
                                      ),
                                    );
                                    loadEvents(); // Refresh events when coming back
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.purple,
                                      borderRadius: BorderRadius.circular(
                                        AppSpacing.pillBorderRadius,
                                      ),
                                      border: rsvpd
                                          ? Border.all(
                                              color: AppColors.rose,
                                              width: 4,
                                            )
                                          : Border.all(
                                              color: AppColors.cream.withValues(
                                                alpha: 0.2,
                                              ),
                                              width: 2,
                                            ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              event['title'] ?? '',
                                              style: TextStyle(
                                                fontFamily: 'Jersey20',
                                                fontSize: 28,
                                                color: AppColors.cream,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: rsvpd
                                                    ? AppColors.rose
                                                    : AppColors.lavender,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                event['category'] ?? '',
                                                style: TextStyle(
                                                  fontFamily: 'Jersey20',
                                                  fontSize: 18,
                                                  color: AppColors.cream,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 20,
                                              color: AppColors.gold,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              '${date.month}/${date.day}/${date.year}',
                                              style: TextStyle(
                                                fontFamily: 'Jersey20',
                                                fontSize: 20,
                                                color: AppColors.cream
                                                    .withValues(alpha: 0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 20,
                                              color: AppColors.gold,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              event['location'] ?? '',
                                              style: TextStyle(
                                                fontFamily: 'Jersey20',
                                                fontSize: 20,
                                                color: AppColors.cream
                                                    .withValues(alpha: 0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
