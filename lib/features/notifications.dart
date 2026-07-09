import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_button.dart';
import '../components/notification_tile.dart';
import '../components/custom_headers.dart';
import '../features/event_detail.dart';

//Rename and change Notifications to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class Notifications extends StatelessWidget {
  final VoidCallback? onBack;

  const Notifications({super.key, this.onBack});

  static const String hikingEventId = 'uCXi5bh1iXo0rJ0CJEZy';
  static const String cafeEventId = 'wdmpTVSbWkyLzohcjIH3';
  static const String cookingEventId = 'uuqScq3XYIYhjuOvR0do';

  void clearNotifications(BuildContext context) {}

  void navigateToEvent(BuildContext context, String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetail(eventId: eventId)),
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
                title: 'Notifications',
                showBack: true,
                showSettings: true,
                onBack: onBack,
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
                      //height: AppSpacing.test,
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
                        top: 15.0,
                        bottom: 15.0,
                      ), //How far the text is from the top of the purple pill
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                // ------ START HERE To Add NOTIFICATIONS --------
                                NotificationTile(
                                  text: 'Hiking Trip is starting soon!',
                                  onTap: () =>
                                      navigateToEvent(context, hikingEventId),
                                ),

                                NotificationTile(
                                  text:
                                      'You might like this cafe event nearby!',
                                  onTap: () =>
                                      navigateToEvent(context, cafeEventId),
                                ),

                                NotificationTile(
                                  text: 'Cooking class is this weekend!',
                                  onTap: () =>
                                      navigateToEvent(context, cookingEventId),
                                ),

                                // ------ END HERE To Add NOTIFICATIONS --------
                              ],
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          CustomButton(
                            text: 'Clear Notifications',
                            onTap: () => clearNotifications(context),
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
