import 'dart:convert';

import 'package:events_app/constants/constants.dart';
import 'package:events_app/constants/error_handling.dart';
import 'package:events_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventServices {
  Future<List<EventModel>> getSearchEvents(
      BuildContext context, String query) async {
    List<EventModel> searchList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/v1/event?search=$query"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0;
                i < jsonDecode(response.body)["content"]["data"].length;
                i++) {
              searchList.add(
                EventModel.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)["content"]["data"][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return searchList;
  }

  Future<EventModel> getEventDetails(BuildContext context, int id) async {
    EventModel eventModel = EventModel(
        id: id,
        title: "",
        description: "",
        banner_image: "",
        date_time: "",
        organiser_name: "",
        organiser_icon: "",
        venue_name: "",
        venue_city: "",
        venue_country: "");
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/v1/event/$id"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            eventModel = EventModel.fromJson(
              jsonEncode(
                jsonDecode(
                  response.body,
                )["content"]["data"],
              ),
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return eventModel;
  }
}
