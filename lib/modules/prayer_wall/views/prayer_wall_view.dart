import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/prayer_wall_model.dart';
import '../controllers/prayer_wall_controller.dart';

class PrayerWallView extends GetView<PrayerWallController> {
  const PrayerWallView({super.key});

  void _showAddRequestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: const Color(0xFF8E99AF),
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Text(
                        'Share a Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: const Color(0xFF3B68E7),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Your Name (optional)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Anonymous',
                      hintStyle: const TextStyle(color: Color(0xFF8E99AF)),
                      filled: true,
                      fillColor: const Color(0xFF1A2340),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Prayer Request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Share what\'s on your heart...',
                      hintStyle: const TextStyle(color: Color(0xFF8E99AF)),
                      filled: true,
                      fillColor: const Color(0xFF1A2340),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Your request will be shared with the church family. You can choose to remain anonymous.',
                    style: TextStyle(
                      color: const Color(0xFF8E99AF),
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16.h,
                bottom: 16.h,
                left: 10.w, // reduced to fit back button nicely
                right: 20.w,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2844B4), // Lighter blue
                    Color(0xFF0A123D), // Darker blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
                        onPressed: () => Get.back(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prayer Wall',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'PIWC Stoneyburn',
                            style: TextStyle(
                              color: const Color(0xFFFFC107),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => _showAddRequestBottomSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      foregroundColor: const Color(0xFF0F172A),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 18.w),
                        SizedBox(width: 4.w),
                        Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
  
            // Tabs
            Container(
              color: const Color(0xFF1A2340), // slightly lighter background for tab bar
              child: TabBar(
                indicatorColor: const Color(0xFFFFC107),
                indicatorWeight: 3.0,
                labelColor: const Color(0xFF3B68E7), // Active tab text color
                unselectedLabelColor: const Color(0xFF8E99AF), // Inactive tab text color
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Prayer Wall'),
                  Tab(text: 'My Requests'),
                ],
              ),
            ),
  
            // Tab Views
            Expanded(
              child: Obx(
                () => TabBarView(
                  children: [
                    _buildPrayerList(controller.requests),
                    _buildEmptyState(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerList(List<PrayerWallModel> list) {
    if (list.isEmpty) return _buildEmptyState();

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final initial = item.name.isNotEmpty ? item.name[0].toUpperCase() : '?';

        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2340),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2844B4),
                    radius: 20.r,
                    child: Text(
                      initial,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          item.date,
                          style: TextStyle(
                            color: const Color(0xFF8E99AF),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                item.request,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 15.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.volunteer_activism,
                      color: const Color(0xFF8E99AF),
                      size: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'I Prayed · ${item.praysCount}',
                      style: TextStyle(
                        color: const Color(0xFF8E99AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.volunteer_activism,
            color: const Color(0xFF8E99AF).withOpacity(0.5),
            size: 64.w,
          ),
          SizedBox(height: 16.h),
          Text(
            'No requests yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Be the first to share a prayer request',
            style: TextStyle(
              color: const Color(0xFF8E99AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
