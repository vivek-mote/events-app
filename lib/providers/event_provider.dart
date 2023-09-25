import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/error_handling.dart';
import '../models/event_model.dart';
import 'package:http/http.dart' as http;

class EventProvider extends ChangeNotifier{
  List<EventModel> _eventList=[];
  List<EventModel> get eventList=>_eventList;
  Future<void> getAllEvents(BuildContext context) async{
    try{
      http.Response response=await http.get(
        Uri.parse("$uri/v1/event"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      
      // ignore: use_build_context_synchronously
      httpErrorHandle(response: response, context: context, onSuccess: (){
        for (int i = 0; i < jsonDecode(response.body)['content']['data'].length; i++) {
            _eventList.add(
              EventModel.fromJson(
                jsonEncode(
                  jsonDecode(response.body)['content']['data'][i],
                ),
              ),
            );
          }
          notifyListeners();
      },);
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}