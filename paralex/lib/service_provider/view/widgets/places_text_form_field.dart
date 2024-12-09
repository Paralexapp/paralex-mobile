import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
import '../../../screens/users/account/pages/controllers/logistics_delivery_info_controller.dart';
import '../../models/place_model.dart';

class PlacesTextField extends StatefulWidget {
  const PlacesTextField({
    super.key,
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
    required this.onSelected,
    this.focusNode,
  });

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
  final FocusNode? focusNode;

  @override
  State<PlacesTextField> createState() => _PlacesTextFieldState();
}

class _PlacesTextFieldState extends State<PlacesTextField> {
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceModel>(
      controller: widget.controller,
      suggestionsCallback: (String query) async {
        if (query.isEmpty) return [];
        return await _searchLocations(query);
      },
      itemBuilder: (context, PlaceModel? itemData) {
        return ListTile(
          leading: const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
          title: Text(
            itemData?.name ?? '',
            style: const TextStyle(color: Colors.green),
          ),
          subtitle: Text(
            itemData?.displayName ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      retainOnLoading: true,
      builder: (
        context,
        controller,
        FocusNode? focusNode,
      ) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: widget.padding,
            prefixIcon: widget.prefix ??
                (widget.showPrefixIcon
                    ? Icon(widget.icon, color: PaintColors.paralexpurple)
                    : null),
            suffixIcon: widget.showSuffixIcon
                ? Icon(widget.suffixIcon, color: PaintColors.paralexpurple)
                : null,
            filled: true,
            fillColor: PaintColors.paralexVeryLightGrey,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: widget.borderColor ?? PaintColors.paralexTransparent, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: widget.borderColor ?? PaintColors.paralexTransparent, width: 2),
            ),
            hintText: widget.hintText,
            hintStyle: FontStyles.cancelTextStyle
                .copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required *';
            }
            return null;
          },
        );
      },
      onSelected: (place) {
        setState(() {
          widget.controller?.text = place.displayName;
          if (widget.onSelected != null) {
            widget.onSelected!(place);
          }
        });
      },
    );
  }

  Future<List<PlaceModel>> _searchLocations(String query) async {
    try {
      var predictionModel = await _controller.searchPlace(query);
      return predictionModel
          .where((element) =>
              element.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      print("Error searching locations: $e");
      return [];
    }
  }
}
