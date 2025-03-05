import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/helpers/api_constants.dart';

import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/custom_text.dart';

// Replace this with your actual Google Places API key
const String apiKey = 'AIzaSyCE-07OqyB1ze3XgMCta9qH95p4bhENiLg';

class GooglePlacesService {
  static Future<List<String>> getPlacePredictions(String input) async {
    if (input.isEmpty) {
      return [];
    }
    try {
      final String url =
          "https://vr-safetrips.onrender.com/api/direction/autocomplete?input=$input";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List predictions = [];
        try {
          print(data);
          predictions = data['data'];
        } catch (e) {
          print(e);
        }

        return predictions.map((
            prediction) => prediction['description'] as String).toList();
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
      return [];
    }
  }
}



class AddressField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  AddressField({required this.controller, required this.onChanged});

  @override
  _AddressFieldState createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  List<String> predictions = [];

  // Call this function as the user types
  void _onTextChanged(String input) async {
    print('Input: $input');

    List<String> result = await GooglePlacesService.getPlacePredictions(input);
    setState(() {
      predictions = result;
    });

    widget.onChanged(input);

    // widget.onChanged(input);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.all(8.w),
          child: CustomText(
            text: "Address",
            size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
            color: dark,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // The Address Input Field
        TextField(
          controller: widget.controller,
          style: TextStyle(color: Colors.black,
            fontSize: 15.sp,),
          decoration: InputDecoration(
            hintText:"Enter Address",
            hintStyle: TextStyle(color: Colors.black,
              fontSize:15.sp,),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          onChanged: _onTextChanged, // Trigger onTextChanged on input change
        ),

        // Display predictions as suggestions
        if (predictions.isNotEmpty)
          Container(
            color: Colors.white,
            height: 270.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: List.generate(predictions.length, (index) {
                return ListTile(
                  title: Text(predictions[index]),
                  onTap: () {
                    widget.controller.text = predictions[index]; // Set the selected address
                    widget.onChanged(predictions[index]);
                    setState(() {
                      predictions.clear(); // Clear predictions after selection
                    });
                  },
                );
              }),
                  ),
            ),
          )
    ],
    );
  }
}
