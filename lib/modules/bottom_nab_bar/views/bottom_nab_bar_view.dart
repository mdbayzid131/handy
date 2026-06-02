import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/modules/events/views/events_view.dart';
import 'package:handy/modules/give/views/give_view.dart';
import 'package:handy/modules/more/views/more_view.dart';
import 'package:handy/modules/news/views/news_view.dart';
import 'package:handy/modules/sermons/views/sermons_view.dart';
import '../controllers/bottom_nab_bar.dart';
import '../../home/views/home_view.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeView(),
              SermonsView(),
              NewsView(),
              GiveView(),
              EventsView(),
              MoreView(),
            ],
          )),
      bottomNavigationBar: Obx(
        () => Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D1B3E),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeTab,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent, // Use container color
                selectedItemColor: const Color(0xFFFFD700),
                unselectedItemColor: const Color(0xFF8E99AF),
                elevation: 0,
                selectedLabelStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                items: [
                  _buildNavItem(Icons.home_rounded, 'Home'),
                  _buildNavItem(Icons.video_library_rounded, 'Sermons'),
                  _buildNavItem(Icons.campaign_rounded, 'News'),
                  _buildNavItem(Icons.favorite_rounded, 'Give'),
                  _buildNavItem(Icons.calendar_month_rounded, 'Events'),
                  _buildNavItem(Icons.more_horiz_rounded, 'More'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 2.h, top: 4.h),
        child: Icon(icon, size: 22.sp),
      ),
      label: label,
    );
  }
}
