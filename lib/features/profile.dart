import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/auth_service.dart';
import '../features/event_detail.dart';

const List<String> predefinedInterests = [
  'Hiking',
  'Cooking',
  'Gaming',
  'Reading',
  'Music',
  'Art',
  'Sports',
  'Movies',
  'Travel',
  'Food',
];

//Rename and change Blank to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class Profile extends StatefulWidget {
  final VoidCallback? onBack;
  const Profile({super.key, this.onBack});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = '';
  List<String> interests = [];
  List<Map<String, dynamic>> rsvpdEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final uid = authService.value.currentUser?.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    final eventsSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('attendees', arrayContains: uid)
        .get();

    if (mounted) {
      setState(() {
        username = doc.data()?['username'] ?? '';
        interests = List<String>.from(doc.data()?['interests'] ?? []);
        rsvpdEvents = eventsSnapshot.docs.map((doc) {
          return {'id': doc.id, ...doc.data()};
        }).toList();
        isLoading = false;
      });
    }
  }

  Future<void> updateInterests(List<String> newInterests) async {
    final uid = authService.value.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'interests': newInterests,
    });
    setState(() {
      interests = newInterests;
    });
  }

  void showInterestPicker() {
    List<String> tempInterests = List.from(interests);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.pillBorderRadius),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Your Interests',
                    style: TextStyle(
                      fontFamily: 'Jersey20',
                      fontSize: 24,
                      color: AppColors.cream,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: predefinedInterests.map((interest) {
                      final isSelected = tempInterests.contains(interest);
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              tempInterests.remove(interest);
                            } else {
                              tempInterests.add(interest);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.gold
                                : AppColors.lavender,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.pillBorderRadius,
                            ),
                          ),
                          child: Text(
                            interest,
                            style: TextStyle(
                              fontFamily: 'Jersey20',
                              fontSize: 18,
                              color: isSelected
                                  ? AppColors.purple
                                  : AppColors.cream,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Save button
                  GestureDetector(
                    onTap: () {
                      updateInterests(tempInterests);
                      Navigator.pop(context);
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
                          'Save',
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
              //Top pill (Template Page)
              CustomHeaders(
                title: 'Your Profile ',
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
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ListView(
                              children: [
                                // Profile picture
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.cream,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/winnie.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      // Username
                                      Text(
                                        username,
                                        style: TextStyle(
                                          fontFamily: 'Jersey20',
                                          fontSize: 28,
                                          color: AppColors.cream,
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      // Interests header
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Interests',
                                              style: TextStyle(
                                                fontFamily: 'Jersey20',
                                                fontSize: 24,
                                                color: AppColors.cream,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Edit button
                                            GestureDetector(
                                              onTap: showInterestPicker,
                                              child: Icon(
                                                Icons.edit,
                                                color: AppColors.gold,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      // Interest chips
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: interests.isEmpty
                                            ? GestureDetector(
                                                onTap: showInterestPicker,
                                                child: Text(
                                                  'Tap the edit icon to add interests!',
                                                  style: TextStyle(
                                                    fontFamily: 'Jersey20',
                                                    fontSize: 16,
                                                    color: AppColors.cream
                                                        .withValues(alpha: 0.6),
                                                  ),
                                                ),
                                              )
                                            : Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: interests
                                                    .map(
                                                      (interest) => Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 10,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.gold,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                AppSpacing
                                                                    .pillBorderRadius,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          interest,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Jersey20',
                                                            fontSize: 20,
                                                            color: AppColors
                                                                .purple,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                      ),
                                      const SizedBox(height: 24),
                                      // RSVPd Events header
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Your Events',
                                              style: TextStyle(
                                                fontFamily: 'Jersey20',
                                                fontSize: 24,
                                                color: AppColors.cream,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      // RSVPd Events list
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: rsvpdEvents.isEmpty
                                            ? Text(
                                                'No events yet, go RSVP to one!',
                                                style: TextStyle(
                                                  fontFamily: 'Jersey20',
                                                  fontSize: 16,
                                                  color: AppColors.cream
                                                      .withValues(alpha: 0.6),
                                                ),
                                              )
                                            : Column(
                                                children: rsvpdEvents.map((
                                                  event,
                                                ) {
                                                  final date =
                                                      (event['date']
                                                              as Timestamp)
                                                          .toDate();
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDetail(
                                                                eventId:
                                                                    event['id'],
                                                              ),
                                                        ),
                                                      );
                                                      loadProfile(); // Refresh profile after returning from event detail
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 10,
                                                          ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                            14,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.purple,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              AppSpacing
                                                                  .pillBorderRadius,
                                                            ),
                                                        border: Border.all(
                                                          color: AppColors.rose,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            event['title'] ??
                                                                '',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Jersey20',
                                                              fontSize: 20,
                                                              color: AppColors
                                                                  .cream,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 6,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                size: 14,
                                                                color: AppColors
                                                                    .gold,
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              Text(
                                                                '${date.month}/${date.day}/${date.year}',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      'Jersey20',
                                                                  fontSize: 15,
                                                                  color: AppColors
                                                                      .cream
                                                                      .withValues(
                                                                        alpha:
                                                                            0.8,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 14,
                                                                color: AppColors
                                                                    .gold,
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              Text(
                                                                event['location'] ??
                                                                    '',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      'Jersey20',
                                                                  fontSize: 15,
                                                                  color: AppColors
                                                                      .cream
                                                                      .withValues(
                                                                        alpha:
                                                                            0.8,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
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
