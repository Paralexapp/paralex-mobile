import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/card.dart';

class LogisticsPaymentMethodController extends GetxController {
 List<Card> paymentCards = [
   Card(image: 'assets/images/cash.png', text: 'Cash'),
   Card(image: 'assets/images/visa.png', text: ' Visa'),
   Card(image: 'assets/images/mastercard.png', text: 'Mastercard', selected: true),
   Card(image: 'assets/images/paypal.png', text: 'PayPal'),
 ];
  var selected = false.obs;

 void updateSelected(bool check, int index){
   paymentCards[index].selected = check;
 }
}

class Card{
  Card({required this.image, required this.text,this.selected = false});
  final String image;
  final String text;
  bool selected;
}