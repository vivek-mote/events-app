import 'package:events_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/event_detail_screen.dart';

class SearchCard extends StatelessWidget {
  final EventModel eventData;
  const SearchCard({required this.eventData, super.key});
  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(eventData.date_time);
    String formattedDateTime =
        DateFormat('EE, MMMM d, hh:mm a').format(parsedDateTime);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return EventDetailScreen(id: eventData.id);
            },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 1,
        child: Column(
          children: [
            Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        eventData.banner_image,
                        fit: BoxFit.cover,
                        height: screenHeight*0.13,
                        width: screenWidth*0.23,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: screenWidth*0.60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          formattedDateTime,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(200,86,105, 255),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: screenWidth*0.60,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          eventData.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
