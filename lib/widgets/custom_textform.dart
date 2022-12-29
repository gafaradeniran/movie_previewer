import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController? searchController;
  final Widget? suffixIcon;
  final String? labelText;
  final void Function(String?)? onChanged;
  const SearchFormField(
      {Key? key,
      this.searchController,
      this.suffixIcon,
      this.labelText,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: searchController,
        autofocus: false,
        enableSuggestions: true,
        decoration: InputDecoration(
          labelText: "search by movie name...",
          labelStyle: const TextStyle(color: Colors.grey),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        textInputAction: TextInputAction.search,
        onChanged: onChanged,
      ),
    );
  }
}
