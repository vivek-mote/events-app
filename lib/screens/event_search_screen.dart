import 'package:events_app/models/event_model.dart';
import 'package:events_app/providers/event_provider.dart';
import 'package:events_app/services/event_services.dart';
import 'package:events_app/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventSearchScreen extends StatefulWidget {
  const EventSearchScreen({super.key});

  @override
  State<EventSearchScreen> createState() => _EventSearchScreenState();
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  EventServices _eventServices = EventServices();
  List<EventModel>? _searchedEventList;
  void getCurrentEvents() {
    _searchedEventList =
        Provider.of<EventProvider>(context, listen: false).eventList;
  }

  Future<void> getSearchedEventList(String query) async {
    _searchedEventList = await _eventServices.getSearchEvents(context, query);
    setState(() {});
  }

  @override
  void initState() {
    getCurrentEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 42,
              margin: const EdgeInsets.only(left: 15),
              child: TextFormField(
                onFieldSubmitted: (String query) async {
                  await getSearchedEventList(query);
                },
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 6,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Color.fromARGB(200, 86, 105, 255),
                        size: 27,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                  hintText: 'Type Event Name',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _searchedEventList == null
                ? const CircularProgressIndicator()
                : _searchedEventList!.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: Text("Events are not available"),
                        ),
                      )
                    : Expanded(
                        child: LayoutBuilder(
                          builder:(context,constraints)=> ListView.builder(
                            itemCount: _searchedEventList!.length,
                            itemBuilder: (context, index) {
                              return SearchCard(
                                  eventData: _searchedEventList![index]);
                            },
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
