import 'package:efl_counter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInputTable extends StatefulWidget {
  final List<TextEditingController> controllersList;

  const TextInputTable({Key? key, required this.controllersList})
      : super(key: key);

  @override
  _TextInputTableState createState() => _TextInputTableState();
}

class _TextInputTableState extends State<TextInputTable> {
  int parking = 0;
  int charging = 0;
  int totalVehicles = 0;
  int twoWheelerTotal = 0;
  int threeWheelerTotal = 0;
  int fourWheelerTotal = 0;

  List<Map> myCustomers = [
    {'name': 'majenta', 'submitted': true},
    {'name': 'flipkart', 'submitted': true},
    {'name': 'amazon', 'submitted': false},
    {'name': 'rapido', 'submitted': true},
    {'name': 'ola', 'submitted': false},
    {'name': 'uber', 'submitted': true},
    {'name': 'taxiwale', 'submitted': true}
  ];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _updateCounts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  void _updateCounts() {
    print('updating counts');
    parking = 0;
    charging = 0;
    totalVehicles = 0;
    twoWheelerTotal = 0;
    threeWheelerTotal = 0;
    fourWheelerTotal = 0;

    // Count the occurrences of each icon type
    for (int i = 0; i < widget.controllersList.length; i++) {
      if (i == 0 || i == 1) {
        twoWheelerTotal += widget.controllersList[i].text.isNotEmpty
            ? int.parse(widget.controllersList[i].text)
            : 0;
      }
      if (i == 2 || i == 3) {
        threeWheelerTotal += widget.controllersList[i].text.isNotEmpty
            ? int.parse(widget.controllersList[i].text)
            : 0;
      }
      if (i == 4 || i == 5) {
        fourWheelerTotal += widget.controllersList[i].text.isNotEmpty
            ? int.parse(widget.controllersList[i].text)
            : 0;
      }
      if (i % 2 == 0) {
        parking += widget.controllersList[i].text.isNotEmpty
            ? int.parse(widget.controllersList[i].text)
            : 0;
      } else {
        charging += widget.controllersList[i].text.isNotEmpty
            ? int.parse(widget.controllersList[i].text)
            : 0;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          _buildHeaderRow(),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: _buildVehicleColumn()),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: widget.controllersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final controller = widget.controllersList[index];
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 10.0),
                          ),
                        ),
                      );
                      // }
                    },
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: _buildTotalColumn()),
              ],
            ),
          ),
          _buildFooterRow(),
          const SizedBox(height: 30),
          _buildCustomerList(),
          const SizedBox(height: 30),
          CustomButton(
            buttonText: 'Submit',
            onTap: () {
              setState(() => _updateCounts());
              Future.delayed(
                  Duration.zero, () => Get.toNamed('/report_success'));
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    List<String> headers = ['Vehicles', 'Parking', 'Charging', 'Total'];
    return Row(
      children: List.generate(
        headers.length,
        (index) => Expanded(
          child: Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              headers[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleColumn() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.5,
        ),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration:
                  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('ll')));
        });

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     _buildIconCell(0),
    //     _buildIconCell(1),
    //     _buildIconCell(2),
    //   ],
    // );
  }

  Widget _buildTotalColumn() {
    List<int> counters = [twoWheelerTotal, threeWheelerTotal, fourWheelerTotal];
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.5,
        ),
        itemCount: counters.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration:
              BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(counters[index] > 0 ? counters[index].toString() : '')));
        });

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     _buildIconCell(0),
    //     _buildIconCell(1),
    //     _buildIconCell(2),
    //   ],
    // );
  }

  Widget _buildFooterRow() {
    int totalVehicles = parking + charging;
    List<String> headers = [
      'Total',
      parking > 0 ? parking.toString() : '',
      charging > 0 ? charging.toString() : '',
      totalVehicles > 0 ? totalVehicles.toString() : ''
    ];
    return Row(
      children: List.generate(
        headers.length,
        (index) => Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              headers[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounterCell(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey[300],
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            count > 0 ? count.toString() : '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconCell(int rowIndex) {
    IconData iconData;
    switch (rowIndex) {
      case 0:
        iconData = Icons.directions_bike;
        break;
      case 1:
        iconData = Icons.bike_scooter;
        break;
      case 2:
        iconData = Icons.local_taxi_outlined;
        break;
      default:
        iconData = Icons.error;
    }
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(iconData),
      ),
    );
  }

  Widget _buildCustomerList() {
    return Row(
      children: [
        IconButton(
          onPressed: () => _pageController.previousPage(
              duration: Duration(milliseconds: 300), curve: Curves.ease),
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
          color: Colors.white,
        ),
        Expanded(
          child: Container(
            color: Colors.red.shade50,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ListView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: myCustomers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 5, right: 5, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30, top: 15, bottom: 10),
                              child: Center(
                                  child: Text(myCustomers[index]['name']
                                      .toUpperCase())),
                            ),
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                myCustomers[index]['submitted']
                                    ? Icons.verified
                                    : Icons.cancel,
                                size: 40,
                                color: myCustomers[index]['submitted']
                                    ? Colors.green
                                    : Colors.redAccent,
                              )),
                        ))
                      ],
                    ),
                  );
                }),
          ),
        ),
        IconButton(
          onPressed: () => _pageController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.ease),
          icon: Icon(
            Icons.keyboard_arrow_right,
            size: 40,
          ),
          color: Colors.white,
        ),
      ],
    );
  }
}
