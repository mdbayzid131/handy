
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar.build(title: "Home"),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget(message: 'Loading...', color: theme.primaryColor)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      size: 100,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome to Home',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your Flutter app is ready!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    CustomButton(
                      onPressed: () => controller.fetchProducts(),
                      text: 'Fetch Products',
                    ),
                  ],
                ),
              ),
      ),
    );

    // return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Icon(
    //           Icons.home,
    //           size: 100,
    //           color: Theme.of(context).primaryColor,
    //         ),
    //         const SizedBox(height: 20),
    //         const Text(
    //           'Welcome to Home',
    //           style: TextStyle(
    //             fontSize: 24,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         const Text(
    //           'Your Flutter app is ready!',
    //           style: TextStyle(
    //             fontSize: 16,
    //             color: Colors.grey,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
