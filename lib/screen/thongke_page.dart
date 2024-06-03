import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qlmoney/data/list_price.dart';
import 'package:qlmoney/data/money.dart';

class ThongKePage extends StatefulWidget {
  @override
  _ThongKePageState createState() => _ThongKePageState();
}

class _ThongKePageState extends State<ThongKePage> {
  String selectedCategory = 'Chi'; // Default category
  FirebaseService firebaseService = FirebaseService();
  List<Money> moneyData = [];
  bool isLoading = true;
  Map<String, double> categoryTotal = {}; // Tổng số tiền cho mỗi loại danh mục
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Money> data = await firebaseService.thongKe();
    setState(() {
      moneyData = data;
      isLoading = false;
      categoryTotal = calculateCategoryTotal(
          data); // Tính tổng số tiền cho mỗi loại danh mục
    });
  }

  Map<String, double> calculateCategoryTotal(List<Money> data) {
    Map<String, double> result = {};
    data.forEach((money) {
      String category = money.nameCategory ?? 'Unknown';
      double amount = double.tryParse(money.price ?? '0') ?? 0;
      if (result.containsKey(category)) {
        result[category] = result[category]! + amount;
      } else {
        result[category] = amount;
      }
    });
    return result;
  }

  List<PieChartSectionData> generatePieChartData() {
    double total = categoryTotal.values.fold(0, (sum, item) => sum + item);

    return categoryTotal.entries.map((entry) {
      final percentage = (entry.value / total * 100).toStringAsFixed(1);
      final String category = entry.key;
      return PieChartSectionData(
        color: Colors.primaries[categoryTotal.keys.toList().indexOf(entry.key) %
            Colors.primaries.length],
        value: entry.value,
        title: '$category\n$percentage%',
        radius: 50,
        titleStyle: TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thống Kê"),
        elevation: 5, // Tạo bóng cho AppBar
        shadowColor: Colors.grey,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              final formattedDate =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              setState(() {
                                startDate = DateTime.parse(formattedDate);
                              });
                            }
                          },
                          child: Text('Chọn ngày bắt đầu'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          startDate != null
                              ? 'Từ: ${DateFormat('dd/MM/yyyy').format(startDate!)}'
                              : 'Chưa chọn ngày bắt đầu',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              final formattedDate =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              setState(() {
                                endDate = DateTime.parse(formattedDate);
                              });
                            }
                          },
                          child: Text('Chọn ngày kết thúc'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          endDate != null
                              ? 'Đến: ${DateFormat('dd/MM/yyyy').format(endDate!)}'
                              : 'Chưa chọn ngày kết thúc',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Lọc dữ liệu theo khoảng thời gian đã chọn
                        List<Money> filteredData = moneyData.where((money) {
                          if (money.time == null) {
                            return false; // Bỏ qua mục dữ liệu nếu không có thời gian
                          }
                          final moneyDate = DateTime.tryParse(money.time!);
                          if (moneyDate == null) {
                            return false; // Bỏ qua mục dữ liệu nếu không thể phân tích cú pháp thời gian
                          }
                          return (startDate == null ||
                                  moneyDate.isAfter(startDate!)) &&
                              (endDate == null ||
                                  moneyDate.isBefore(
                                      endDate!.add(Duration(days: 1))));
                        }).toList();
                        //
                        // Tính lại tổng số tiền cho mỗi loại danh mục dựa trên dữ liệu đã lọc
                        categoryTotal = calculateCategoryTotal(filteredData);
                        setState(() {});
                      },
                      child: Text('Thống kê'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    AspectRatio(
                      aspectRatio: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: PieChart(
                          PieChartData(
                            sections: generatePieChartData(),
                            borderData:
                                FlBorderData(show: false), // Ẩn đường viền
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categoryTotal.length,
                      itemBuilder: (BuildContext context, int index) {
                        final category = categoryTotal.keys.toList()[index];
                        final amount = categoryTotal[category]!;
                        final percentage = (amount /
                                categoryTotal.values.reduce((a, b) => a + b) *
                                100)
                            .toStringAsFixed(1);
                        return Card(
                          elevation: 5, // Tạo bóng cho từng Card
                          shadowColor: Colors.grey,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(category),
                            subtitle: Text(
                                'Tổng số tiền: $amount - Phần trăm: $percentage%'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
