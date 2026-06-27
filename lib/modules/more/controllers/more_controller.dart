import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/data/models/contact_mission_model.dart';
import 'package:intl/intl.dart';

class MoreController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  var currentIndex = 0;

  final isLoading = false.obs;
  final contactMission = Rxn<ContactMissionModel>();

  @override
  void onInit() {
    super.onInit();
    fetchContactAndMission();
  }

  Future<void> fetchContactAndMission() async {
    if (contactMission.value == null) isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.contactAndMission);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          contactMission.value = ContactMissionModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching contact & mission: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchContactAndMission();
  }

  String get formattedSundayService {
    final rawTime = contactMission.value?.sundayService?.trim();
    if (rawTime == null || rawTime.isEmpty) {
      return 'Not Available';
    }
    
    try {
      // Find all time patterns like 10:00 or 10:00:00
      final RegExp timeRegExp = RegExp(r'\b(\d{1,2}):(\d{2})(?::\d{2})?\b');
      
      String formattedString = rawTime.replaceAllMapped(timeRegExp, (match) {
        final timeStr = match.group(0)!;
        try {
          final formatString = timeStr.split(':').length == 3 ? "HH:mm:ss" : "HH:mm";
          final parsedTime = DateFormat(formatString).parse(timeStr);
          return DateFormat("hh:mm a").format(parsedTime);
        } catch (e) {
          return timeStr;
        }
      });
      
      // Replace commas with hyphen for ranges
      formattedString = formattedString.replaceAll(RegExp(r'\s*,\s*'), ' - ');
      
      return formattedString;
    } catch (e) {
      return rawTime;
    }
  }

  // Feedback form controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final isSubmittingFeedback = false.obs;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> submitFeedback() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Helpers.showError(
        'Please provide both title and description',
        title: 'Error',
      );
      return;
    }

    isSubmittingFeedback.value = true;
    try {
      final response = await apiClient.postData(
        ApiConstants.feedback,
        {
          "title": title,
          "description": description,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // close bottom sheet
        Helpers.showSuccess(
          'Feedback created successfully',
          title: 'Success',
        );
        titleController.clear();
        descriptionController.clear();
      } else {
        Helpers.showError(
          response.data?['message'] ?? 'Failed to submit feedback',
          title: 'Error',
        );
      }
    } catch (e) {
      Helpers.showDebugLog('Error submitting feedback: $e');
      Helpers.showError(
        'Something went wrong. Please try again.',
        title: 'Error',
      );
    } finally {
      isSubmittingFeedback.value = false;
    }
  }
}