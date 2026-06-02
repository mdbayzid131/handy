import 'package:get/get.dart';

class GiveController extends GetxController {
  final showHistory = false.obs;
  
  final selectedFund = 'Offering'.obs;
  final selectedAmount = 0.obs;
  final customAmount = ''.obs;
  
  final selectedFrequency = 'One-time'.obs;
  final selectedPaymentMethod = 'Card (Stripe)'.obs;
  
  void toggleHistory() {
    showHistory.value = !showHistory.value;
  }
}