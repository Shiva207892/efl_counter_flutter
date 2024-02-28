import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/hub_controller.dart';
import '../../../utils/app_pictures.dart';

class TopCustomerSelector extends StatelessWidget {
  final String? selectedHub;
  final List<String> hubsList;
  final String? selectedCustomer;
  final List<String> customersList;
  const TopCustomerSelector({Key? key, this.selectedHub, this.selectedCustomer, required this.hubsList, required this.customersList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hubsController = Get.find<HubsController>();

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppPictures.mapImage,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                child: MyDropDown(
                  dropdownFor: 'hubs',
                  selectedValue: selectedHub,
                  dropdownList: hubsList,
                  updateSelected: (val) =>
                      hubsController.updateSelectedHub(val),
                ),
              ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                child: MyDropDown(
                  dropdownFor: 'customers',
                  selectedValue: selectedCustomer,
                  dropdownList: customersList,
                  updateSelected: (val) =>
                      hubsController.selectedCustomer.value = val,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MyDropDown extends StatelessWidget {
  final String dropdownFor;
  final String? selectedValue;
  final List<String> dropdownList;
  final void Function(String state) updateSelected;

  const MyDropDown({
    Key? key,
    required this.dropdownFor,
    required this.selectedValue,
    required this.dropdownList,
    required this.updateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      elevation: 100,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            alignment: AlignmentDirectional.center,
            hint: Row(
              children: [
                const Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    dropdownFor == 'hubs' ? 'Hub' : 'Customer',
                    style: poppinsBold.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: dropdownList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) => updateSelected(value!),
            style: const TextStyle(color: Colors.black),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            iconSize: 24,
            elevation: 10,
            isExpanded: true,
            dropdownColor: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
