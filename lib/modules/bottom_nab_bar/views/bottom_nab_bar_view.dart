import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/modules/events/views/events_view.dart';
import 'package:handy/modules/give/views/give_view.dart';
import 'package:handy/modules/more/views/more_view.dart';
import 'package:handy/modules/sermons/views/sermons_view.dart';
import '../controllers/bottom_nab_bar.dart';
import '../../home/views/home_view.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.black,
      child: WillPopScope(
        onWillPop: controller.handleBackButton,
        child: Scaffold(
          body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeView(),
              SermonsView(),
              GiveView(),
              EventsView(),
              MoreView(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.black.withAlpha(2),
                    blurRadius: 10.r,
                    offset: Offset(0, -2.h),
                  ),
                ],
                border: Border(
                  top: BorderSide(
                    color: AppTheme.white.withAlpha(5),
                    width: 1.r,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: BottomNavigationBar(
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeTab,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: AppTheme.warningColor,
                  unselectedItemColor: AppTheme.white,
                  elevation: 0,
                  selectedLabelStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                  items: [
                    _buildNavItem(Icons.home_rounded, 'Home'),
                    _buildNavItem(Icons.video_library_rounded, 'Sermons'),
                    _buildNavItem(Icons.favorite_rounded, 'Give'),
                    _buildNavItem(Icons.calendar_month_rounded, 'Events'),
                    _buildNavItem(Icons.more_horiz_rounded, 'More'),
                  ],
                ),
              ),
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
        child: Icon(icon, size: 26.sp),
      ),
      label: label,
    );
  }
}
