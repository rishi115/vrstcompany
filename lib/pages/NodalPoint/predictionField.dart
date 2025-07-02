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
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _onTextChanged(String input) async {
    List<String> result = await GooglePlacesService.getPlacePredictions(input);
    setState(() {
      predictions = result;
    });

    widget.onChanged(input);

    _showOverlay();
  }

  void _showOverlay() {
    _overlayEntry?.remove(); // Remove previous overlay
    if (predictions.isEmpty) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 50), // Adjust based on UI
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.white,
              constraints: BoxConstraints(maxHeight: 370.h),
              child: Padding(
                padding: EdgeInsets.only(top: 8.0), // Adjust space below TextField
                child: Column(
                  children: predictions.map((prediction) {
                    return ListTile(
                      title: Text(prediction),
                      onTap: () {
                        widget.controller.text = prediction;
                        widget.onChanged(prediction);
                        setState(() {
                          predictions.clear();
                        });
                        _overlayEntry?.remove(); // Close overlay
                      },
                    );
                  }).toList(),
                ),
              )


            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: CustomText(
              text: "Address",
              size: ResponsiveWidget.isLargeScreen(context)
                  ? 15.sp
                  : ResponsiveWidget.isSmallScreen(context)
                  ? 15.sp * 4
                  : 15.sp * 1.4,
              color: dark,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: widget.controller,
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: "Enter Address",
              hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            onChanged: _onTextChanged,
          ),
        ],
      ),
    );
  }
}
