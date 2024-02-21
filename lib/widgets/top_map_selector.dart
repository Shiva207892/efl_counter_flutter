import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:efl_counter/utils/app_pictures.dart';
import 'package:flutter/material.dart';

class TopCustomerSelector extends StatefulWidget {
  const TopCustomerSelector({super.key});

  @override
  State<TopCustomerSelector> createState() => _TopCustomerSelectorState();
}

class _TopCustomerSelectorState extends State<TopCustomerSelector> {
  String? selectedState;
  String? selectedDistrict;
  String? selectedCity;

  final List<String> states = ['State A', 'State B', 'State C', 'State D'];
  final List<String> cities = [
    'City 1',
    'City 2',
    'City 3',
    'City 4',
    'City 5'
  ];
  final List<String> districts = [
    'District 1',
    'District 2',
    'District 3',
    'District 4',
    'District 5'
  ];

  void updateSelectedState(String state) {
    setState(() {
      selectedState = state;
    });
  }

  void updateSelectedDistrict(String district) {
    setState(() {
      selectedDistrict = district;
    });
  }

  void updateSelectedCity(String city) {
    setState(() {
      selectedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
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
            child: MyDroopDown(
                dropdownFor: 'states',
                selectedValue: selectedState,
                dropdownList: states,
                updateSelected: updateSelectedState),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: MyDroopDown(
              dropdownFor: 'districts',
              selectedValue: selectedDistrict,
              dropdownList: districts,
              updateSelected: updateSelectedDistrict,
            ),
          ),
          Positioned.fill(
            bottom: 20,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyDroopDown(
                  dropdownFor: 'cities',
                  selectedValue: selectedCity,
                  dropdownList: cities,
                  updateSelected: updateSelectedCity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyDroopDown extends StatefulWidget {
  final String dropdownFor;
  final String? selectedValue;
  final List<String> dropdownList;
  final void Function(String state) updateSelected;
  const MyDroopDown(
      {super.key,
      required this.selectedValue,
      required this.dropdownList,
      required this.dropdownFor,
      required this.updateSelected});

  @override
  State<MyDroopDown> createState() => _MyDroopDownState();
}

class _MyDroopDownState extends State<MyDroopDown> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 100,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  widget.dropdownFor == 'states' ? 'State' : widget.dropdownFor == 'districts' ? 'District' : 'City',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: widget.dropdownList
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
          value: widget.selectedValue,
          onChanged: (value) => widget.updateSelected(value!),
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.redAccent,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.redAccent,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}