import 'package:cached_network_image/cached_network_image.dart';
import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/add_data_controller.dart';
import 'package:efl_counter/controllers/hub_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersListing extends StatefulWidget {
  final String? selectedCustomer;
  const CustomersListing({super.key, this.selectedCustomer});

  @override
  State<CustomersListing> createState() => _CustomersListingState();
}

class _CustomersListingState extends State<CustomersListing> {
  final hubsController = Get.find<HubsController>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomerList();
  }

  Widget _buildCustomerList() {
    return widget.selectedCustomer != null
        ? Row(
            children: [
              InkWell(
                onTap: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease),
                child: _iconWidget(Icons.keyboard_arrow_left),
              ),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: hubsController.customers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder<bool>(
                          future: Get.find<AddDataController>()
                              .fetchReportStatus(
                                  hubsController.customers[index]),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for the future to complete, show a loading indicator or placeholder
                              return _buildCustomerCard(false, index);
                            } else {
                              if (snapshot.hasError) {
                                // Handle error if the future fails
                                return Text('Error: ${snapshot.error}');
                              } else {
                                bool isReportSubmitted = snapshot.data ??
                                    false; // Get the data from the future
                                return _buildCustomerCard(
                                    isReportSubmitted, index);
                              }
                            }
                          },
                        );
                      }),
                ),
              ),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              InkWell(
                onTap: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease),
                child: _iconWidget(Icons.keyboard_arrow_right),
              ),
            ],
          )
        : Card(
            child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Text(
              '*Please select Hub and Customer',
              style: poppinsBold.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
          ));
  }

  Widget _buildCustomerCard(bool isReportSubmitted, int index) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                // image: DecorationImage(
                //   image: CachedNetworkImageProvider(hubsController.customersList.firstWhere((customer) => customer.id == hubsController.customers[index])['logo'], cacheKey: hubsController.customers[index]),
                //   fit: BoxFit.fitHeight,
                // )
            ), // Adjust the fit as needed)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 15, bottom: 10),
              child: Center(
                  child: Text(
                hubsController.customers[index].toUpperCase(),
                style: poppinsBold,
              )),
            ),
          ),
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.topCenter,
          child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              child: Icon(
                isReportSubmitted ? Icons.verified : Icons.cancel,
                size: 36,
                color: isReportSubmitted ? Colors.green : Colors.redAccent,
              )),
        ))
      ],
    );
  }

  Widget _iconWidget(IconData iconData) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(
        iconData,
        size: 40,
        color: AppColors.primaryColor,
      ),
    );
  }
}
