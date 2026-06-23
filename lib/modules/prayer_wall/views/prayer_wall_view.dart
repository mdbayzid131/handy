import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../../../data/models/prayer_wall_model.dart';
import '../../../core/widgets/custom_gradient_header.dart';
import '../controllers/prayer_wall_controller.dart';
import '../../../core/widgets/shimmers/list_shimmer.dart';

class PrayerWallView extends GetView<PrayerWallController> {
  const PrayerWallView({super.key});

  void _showAddRequestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
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
                              color: AppTheme.mutedTextColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Text(
                          'Share a Request',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => TextButton(
                            onPressed: controller.isSubmitting.value
                                ? null
                                : controller.submitRequest,
                            child: controller.isSubmitting.value
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppTheme.accentBlue,
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: controller.isSubmitting.value
                                          ? AppTheme.mutedTextColor
                                          : AppTheme.accentBlue,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Your Name',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => TextField(
                        controller: controller.nameController,
                        enabled: !controller.isAnonymous.value,
                        style: TextStyle(
                          color: controller.isAnonymous.value
                              ? AppTheme.white.withValues(alpha: 0.5)
                              : AppTheme.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Anonymous',
                          hintStyle: const TextStyle(
                            color: AppTheme.mutedTextColor,
                          ),
                          filled: true,
                          fillColor: AppTheme.containerColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prayer as Anonymous',
                          style: TextStyle(
                            color: AppTheme.white.withValues(alpha: 0.8),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(
                          () => Checkbox(
                            value: controller.isAnonymous.value,
                            onChanged: (value) {
                              controller.isAnonymous.value = value ?? false;
                            },
                            activeColor: AppTheme.royalBlue,
                            checkColor: AppTheme.white,
                            side: BorderSide(
                              color: AppTheme.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Prayer Request',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: controller.requestController,
                      maxLines: 5,
                      style: const TextStyle(color: AppTheme.white),
                      decoration: InputDecoration(
                        hintText: 'Share what\'s on your heart...',
                        hintStyle: const TextStyle(
                          color: AppTheme.mutedTextColor,
                        ),
                        filled: true,
                        fillColor: AppTheme.containerColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Your request will be shared with the church family. You can choose to remain anonymous.',
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 12.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditRequestBottomSheet(BuildContext context, PrayerWallModel item) {
    controller.nameController.text = item.name == 'Anonymous' ? '' : item.name;
    controller.requestController.text = item.request;
    controller.isAnonymous.value = item.name == 'Anonymous';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
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
                              color: AppTheme.mutedTextColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Text(
                          'Edit Request',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => TextButton(
                            onPressed: controller.isSubmitting.value
                                ? null
                                : () {
                                    controller.editRequest(item.id);
                                  },
                            child: controller.isSubmitting.value
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppTheme.accentBlue,
                                    ),
                                  )
                                : Text(
                                    'Update',
                                    style: TextStyle(
                                      color: controller.isSubmitting.value
                                          ? AppTheme.mutedTextColor
                                          : AppTheme.accentBlue,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Your Name',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => TextField(
                        controller: controller.nameController,
                        enabled: !controller.isAnonymous.value,
                        style: TextStyle(
                          color: controller.isAnonymous.value
                              ? AppTheme.white.withValues(alpha: 0.5)
                              : AppTheme.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Anonymous',
                          hintStyle: const TextStyle(
                            color: AppTheme.mutedTextColor,
                          ),
                          filled: true,
                          fillColor: AppTheme.containerColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prayer as Anonymous',
                          style: TextStyle(
                            color: AppTheme.white.withValues(alpha: 0.8),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(
                          () => Checkbox(
                            value: controller.isAnonymous.value,
                            onChanged: (value) {
                              controller.isAnonymous.value = value ?? false;
                            },
                            activeColor: AppTheme.royalBlue,
                            checkColor: AppTheme.white,
                            side: BorderSide(
                              color: AppTheme.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Prayer Request',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: controller.requestController,
                      maxLines: 5,
                      style: const TextStyle(color: AppTheme.white),
                      decoration: InputDecoration(
                        hintText: 'Share what\'s on your heart...',
                        hintStyle: const TextStyle(
                          color: AppTheme.mutedTextColor,
                        ),
                        filled: true,
                        fillColor: AppTheme.containerColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    PrayerWallModel item,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.containerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: AppTheme.secondaryColor),
          ),
          title: Text(
            'Delete Request',
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this prayer request? This action cannot be undone.',
            style: TextStyle(
              color: AppTheme.mutedTextColor,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.accentBlue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.deleteRequest(item.id);
                Get.back();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: AppTheme.errorColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          CustomGradientHeader(
            title: 'Prayer Wall',
            showBackButton: true,
            trailingWidget: ElevatedButton(
              onPressed: () {
                _showAddRequestBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.warningColor,
                foregroundColor: AppTheme.slate900,
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
          ),

          // Toggle Buttons
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Obx(
              () => Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppTheme.containerColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppTheme.secondaryColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.isPrayerWall.value = true,
                        child: Container(
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: controller.isPrayerWall.value
                                ? AppTheme.accentBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Prayer Wall',
                            style: TextStyle(
                              color: controller.isPrayerWall.value
                                  ? AppTheme.white
                                  : AppTheme.mutedTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.isPrayerWall.value = false,
                        child: Container(
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: !controller.isPrayerWall.value
                                ? AppTheme.accentBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'My Requests',
                            style: TextStyle(
                              color: !controller.isPrayerWall.value
                                  ? AppTheme.white
                                  : AppTheme.mutedTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),
          // Tab Views
          Expanded(
            child: Obx(
              () => controller.isPrayerWall.value
                  ? _buildPrayerList(
                      context,
                      controller.requests,
                      isMyRequest: false,
                    )
                  : _buildPrayerList(
                      context,
                      controller.myRequests,
                      isMyRequest: true,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerList(
    BuildContext context,
    List<PrayerWallModel> list, {
    bool isMyRequest = false,
  }) {
    if (controller.isLoading.value && list.isEmpty) {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        children: const [ListShimmer(itemCount: 4)],
      );
    }
    if (list.isEmpty) return _buildEmptyState(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.pixels > 0 &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
          controller.loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: controller.refreshData,
        color: AppTheme.primaryColor,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index == list.length) {
              return Obx(() {
                final isLoadingMore = controller.isPrayerWall.value
                    ? controller.isLoadingMore.value
                    : controller.isMyLoadingMore.value;
                if (isLoadingMore) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              });
            }
            final item = list[index];
            final initial = item.name.isNotEmpty
                ? item.name[0].toUpperCase()
                : '?';

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppTheme.containerColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppTheme.secondaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppTheme.primaryLighter,
                        radius: 20.r,
                        child: Text(
                          initial,
                          style: TextStyle(
                            color: AppTheme.white,
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
                                color: AppTheme.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              item.date,
                              style: TextStyle(
                                color: AppTheme.mutedTextColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isMyRequest)
                        Transform.translate(
                          offset: Offset(12.w, -12.h),
                          child: PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.more_vert,
                              color: AppTheme.white,
                              size: 24.w,
                            ),
                            color: AppTheme.containerColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(color: AppTheme.secondaryColor),
                            ),
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showEditRequestBottomSheet(context, item);
                              } else if (value == 'delete') {
                                _showDeleteConfirmationDialog(context, item);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: AppTheme.accentBlue,
                                      size: 20.w,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: AppTheme.errorColor,
                                      size: 20.w,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: AppTheme.errorColor,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
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
                      color: AppTheme.white.withValues(alpha: 0.9),
                      fontSize: 15.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      controller.prayForRequest(item.id);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: item.praysCount > 0
                            ? AppTheme.primaryColor
                            : AppTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.volunteer_activism,
                            color: AppTheme.mutedTextColor,
                            size: 16.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'I Prayed · ${item.praysCount}',
                            style: TextStyle(
                              color: AppTheme.mutedTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      color: AppTheme.primaryColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Container(
                height: constraints.maxHeight,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.volunteer_activism,
                      color: AppTheme.mutedTextColor.withValues(alpha: 0.5),
                      size: 64.w,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No requests yet',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Be the first to share a prayer request',
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
