import 'package:events_app/models/event_model.dart';
import 'package:events_app/providers/event_provider.dart';
import 'package:events_app/screens/event_search_screen.dart';
import 'package:events_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<EventModel>? _eventList = [];
  @override
  void initState() {
    fetchAllEvents();
    super.initState();
  }

  fetchAllEvents() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    await eventProvider.getAllEvents(context);
    _eventList = eventProvider.eventList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _eventList == null
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Events"),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromARGB(1, 86, 105, 255),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Events",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return EventSearchScreen();
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                itemCount: _eventList!.length,
                itemBuilder: (context, index) {
                  return EventCard(index: index);
                },
              ),
            ),
          );
  }
}
