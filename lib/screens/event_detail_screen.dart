import 'package:events_app/models/event_model.dart';
import 'package:events_app/services/event_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatefulWidget {
  final int id;
  const EventDetailScreen({required this.id, super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  EventServices _eventServices = EventServices();
  late EventModel _eventModel;

  Future<void> getEventDetails() async {
    _eventModel = await _eventServices.getEventDetails(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidthPercentage = 0.65;
    return FutureBuilder(
      future: getEventDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Event Details",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          DateTime parsedDateTime = DateTime.parse(_eventModel.date_time);
          String dateMonthYear =
              DateFormat('d MMMM, yyyy').format(parsedDateTime);
          String dayAndTime =
              DateFormat('EEEE, hh:mm a').format(parsedDateTime);
          return Scaffold(
            appBar: CustomAppBar(_eventModel.banner_image),
            floatingActionButton: GestureDetector(
              onTap: () {},
              child: Container(
                height: 60,
                width: screenWidth * containerWidthPercentage,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(200,86,105, 255),
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "BOOK NOW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        _eventModel.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 35),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Image.network(_eventModel.organiser_icon),
                    title: Text(_eventModel.organiser_name),
                    subtitle: const Text("Organizer"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(20,86,105, 255),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        size: 30,
                        color: Color.fromARGB(200,86,105, 255),
                      ),
                    ),
                    title: Text(dateMonthYear),
                    subtitle: Text(dayAndTime),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: Container(
                      padding:
                          const EdgeInsets.all(5), // Adjust padding as needed
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(20,86,105, 255),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color:  Color.fromARGB(200,86,105, 255),
                      ),
                    ),
                    title: Text(_eventModel.venue_name),
                    subtitle: Text(
                        "${_eventModel.venue_city} , ${_eventModel.venue_country}"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      height: 34,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "About Event",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 15, bottom: 75),
                      child: Text(
                        _eventModel.description,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(244);
  final String imagePath;
  CustomAppBar(this.imagePath);
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 244,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Event Details'),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
