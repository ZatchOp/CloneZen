import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  // final List<SearchListModel> dataList;
  // final ValueChanged<List<SearchListModel>> onSearchResult;
  final double? isPaddingEnable;
  final String hintText;
  const CustomSearchBar({
    required this.hintText,
    // required this.dataList,
    // required this.onSearchResult,
    this.isPaddingEnable,
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  //Timer? _debounce;

  // void onSearchChanged(String query) {
  //   log("query : $query");

  //   if (_debounce?.isActive ?? false) _debounce!.cancel();

  //   _debounce = Timer(const Duration(milliseconds: 200), () {
  //     // Filter the list based on whether item or itemValue contains the query
  //     final searchResults = widget.dataList
  //         .where((data) =>
  //             data.item!.toLowerCase().contains(query.toLowerCase()) ||
  //             data.itemValue!.toLowerCase().contains(query.toLowerCase()))
  //         .toList();

  //     log("CustomSearchBar : ${searchResults.map((e) => e.item).toList()}");

  //     if (searchResults.isEmpty) {
  //       widget.onSearchResult([SearchListModel()]);
  //     } else {
  //       widget.onSearchResult(searchResults);
  //     }
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   _debounce?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40, // Set the height to 30
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true, // Reduces the default vertical space
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.grey.shade400, fontSize: 12), // Text size for hint
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.deepOrange),
          ),
          // filled: true,
          fillColor: Colors.white, // Light background color for the input field
        ),
        style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12), // Text size for input text
      ),
    );
  }
}
