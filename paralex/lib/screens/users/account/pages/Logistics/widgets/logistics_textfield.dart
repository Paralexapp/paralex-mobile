import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/screens/users/account/pages/controllers/logistics_delivery_info_controller.dart';
import 'package:paralex/service_provider/models/place_model.dart';
import 'package:paralex/utils/validator.dart';

class LogisticsTextfield extends StatelessWidget {
  const LogisticsTextfield(
      {super.key,
      this.minLines,
      this.padding,
      this.hintText,
      this.keyboardType,
      this.icon,
      this.controller,
      this.borderColor,
      this.suffixIcon,
      this.showPrefixIcon = false,
      this.showSuffixIcon = false,
      this.maxLines,
      this.prefix,
      this.suffix});
  final String? hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Color? borderColor;
  final bool showPrefixIcon;
  final bool showSuffixIcon;
  final int? maxLines;
  final int? minLines;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      decoration: InputDecoration(
        contentPadding: padding,
        prefixIcon: prefix ??
            (showPrefixIcon == true
                ? Icon(
                    icon,
                    color: PaintColors.paralexpurple,
                  )
                : null),
        suffixIcon: suffix ??
            (showSuffixIcon == true
                ? Icon(
                    suffixIcon,
                    color: PaintColors.paralexpurple,
                  )
                : null),
        filled: true,
        fillColor: PaintColors.paralexVeryLightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide:
              BorderSide(color: borderColor ?? PaintColors.paralexTransparent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide:
              BorderSide(color: borderColor ?? PaintColors.paralexTransparent, width: 2),
        ),
        hintText: hintText,
        hintStyle: FontStyles.cancelTextStyle
            .copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required *';
        }
      },
    );
  }
}

class LogisticsPhoneField extends StatelessWidget {
  const LogisticsPhoneField(
      {super.key,
      this.suffixWidget,
      this.hintText,
      this.onChanged,
      this.onCountryChanged,
      this.controller});
  final Widget? suffixWidget;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(PhoneNumber phoneNumber)? onChanged;
  final void Function(Country country)? onCountryChanged;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      disableLengthCheck: true,
      dropdownIconPosition: IconPosition.trailing,
      dropdownDecoration: BoxDecoration(),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: PaintColors.paralexVeryLightGrey,
        suffixIcon: suffixWidget,
        hintText: hintText,
        hintStyle: FontStyles.cancelTextStyle
            .copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: PaintColors.paralexTransparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: PaintColors.paralexTransparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: PaintColors.paralexTransparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: PaintColors.paralexTransparent),
        ),
      ),
      initialCountryCode: 'NG',
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
      validator: (value) {
        if (value!.isValidNumber()) return null;
      },
    );
  }
}

class PlacesTextField extends StatelessWidget {
  PlacesTextField(
      {super.key,
      this.minLines,
      this.padding,
      this.hintText,
      this.keyboardType,
      this.icon,
      this.controller,
      this.borderColor,
      this.suffixIcon,
      this.showPrefixIcon = false,
      this.showSuffixIcon = false,
      this.maxLines,
      this.prefix,
      this.suffix,
      required this.onSelected});
  final String? hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Color? borderColor;
  final bool showPrefixIcon;
  final bool showSuffixIcon;
  final int? maxLines;
  final int? minLines;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final Function(PlaceModel)? onSelected;
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceModel>(
      suggestionsCallback: (String query) async {
        if (query.isEmpty) return [];
        // Perform location search using the Geocoding API
        return await _searchLocations(query);
      },
      itemBuilder: (context, PlaceModel? itemData) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.grey,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${itemData?.name}",
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      "${itemData?.displayName}",
                      style: TextStyle(overflow: TextOverflow.clip),
                    ),
                    const Divider()
                  ],
                ),
              ),
            ],
          ),
        );
      },
      // onSelected: (value) {
      //   print('position ===== ${controller}');
      //   onSelected!(value);
      // },
      retainOnLoading: true,
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType ?? TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: padding,
            prefixIcon: prefix ??
                (showPrefixIcon == true
                    ? Icon(
                        icon,
                        color: PaintColors.paralexpurple,
                      )
                    : null),
            suffixIcon: suffix ??
                (showSuffixIcon == true
                    ? Icon(
                        suffixIcon,
                        color: PaintColors.paralexpurple,
                      )
                    : null),
            filled: true,
            fillColor: PaintColors.paralexVeryLightGrey,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: borderColor ?? PaintColors.paralexTransparent, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: borderColor ?? PaintColors.paralexTransparent, width: 2),
            ),
            hintText: hintText,
            hintStyle: FontStyles.cancelTextStyle
                .copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required *';
            }
          },
        );
      },
      onSelected: (PlaceModel value) {
        controller?.text = value.displayName;
        onSelected!(value);
      },
    );
  }

  Future<List<PlaceModel>> _searchLocations(String query) async {
    try {
      // var predictionModel = await _controller.placeAutoComplete(placeInput: query);
      var predictionModel = await _controller.searchPlace(query);

      var filter = predictionModel
          .where((element) =>
              element.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      print('response.body====${filter}');
      return predictionModel;
    } catch (e) {
      print("Error searching locations: $e");
      return [];
    }
  }
}
