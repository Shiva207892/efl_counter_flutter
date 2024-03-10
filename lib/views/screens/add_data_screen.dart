import 'package:efl_counter/controllers/add_data_controller.dart';
import 'package:efl_counter/controllers/hub_controller.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:efl_counter/views/screens/widgets/customer_listing.dart';
import 'package:efl_counter/views/screens/widgets/fixed_footer_row.dart';
import 'package:efl_counter/widgets/base_gradient.dart';
import 'package:efl_counter/views/screens/widgets/top_customer_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/success_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/data_input_table.dart';
import '../dashboard/app_exit_dialog.dart';
import 'widgets/fixed_header_row.dart';

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<AddDataController>();
    final hubsController = Get.find<HubsController>();

    return WillPopScope(
      onWillPop: () async => await showDialog(
        context: context,
        builder: (context) => const AppExitDialog(),
      ),
      child: Scaffold(
        body: SafeArea(
            child: baseGradientContainer(
          context,
          ListView(
            children: [
              Obx(() => TopCustomerSelector(
                  selectedHub: hubsController.selectedHub.isNotEmpty
                      ? hubsController.selectedHub.value
                      : null,
                  hubsList: hubsController.hubIds,
                  selectedCustomer: hubsController.selectedCustomer.isNotEmpty
                      ? hubsController.selectedCustomer.value
                      : null,
                  customersList: hubsController.customers)),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        buildHeaderRow(),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        const TextInputTable(),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        buildFooterRow(context),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeThirty),
                    Obx(() => CustomersListing(
                        selectedCustomer:
                            hubsController.selectedCustomer.isNotEmpty
                                ? hubsController.selectedCustomer.value
                                : null)),
                    const SizedBox(height: Dimensions.paddingSizeThirty),
                    CustomButton(
                        buttonText: 'Submit',
                        onTap: () {
                          dataController.submitReport(context).then((value) {
                            if (value != null) {
                              showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ReportSubmitDialog(reportData: value))
                                  .then((val) {
                                if (val == true) {
                                  dataController.clearCounters();
                                  dataController.clearControllers();
                                  // Get.find<AppController>()
                                  //     .setCurrentSelectedDate(DateTime.now());
                                }
                              });
                            }
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
