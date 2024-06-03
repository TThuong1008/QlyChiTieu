import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qlmoney/data/category.dart';
import 'package:qlmoney/data/money.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlmoney/widgets/category_list.dart';
import 'package:qlmoney/widgets/khoan_thuchi_listview.dart';
import 'package:qlmoney/data/list_price_find.dart'; // Import tệp dịch vụ

class AllKhoanThuChi extends StatefulWidget {
  const AllKhoanThuChi({Key? key}) : super(key: key);

  @override
  State<AllKhoanThuChi> createState() => _AllKhoanThuChiState();
}

class _AllKhoanThuChiState extends State<AllKhoanThuChi> {
  List<Category> categoryList = [];
  List<Money> khoanThuChiList = [];

  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu ban đầu cho tất cả các ngày
    _layDuLieu(
        DateTime(1970)); // Chọn một ngày ở quá khứ để lấy tất cả các giao dịch
  }

  Future<void> _layDuLieu(DateTime? selectedDate) async {
    List<Money> data = await layKhoanThuChi(selectedDate!);
    List<Category> dataCate = await layCategory();
    setState(() {
      khoanThuChiList = data;
      categoryList = dataCate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text("All Income and Expense",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  )),
            ),
            const SizedBox(
              height: 25,
            ),

            // search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 30,
                              child: Icon(Icons.search),
                            ),
                          ),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search name Income or Expense!",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDatePicker(); // Gọi hàm hiển thị lịch
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text("Category",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),

            Container(
              height: 160,
              child: ListView.builder(
                  itemCount: categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryList(
                        name: categoryList[index].name,
                        icon: categoryList[index].icon,
                        totalPrice: categoryList[index].totalPrice);
                  }),
            ),

            // Khoan Thu va Khoan Chi
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text("Income and Expense",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView.builder(
                  itemCount: khoanThuChiList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // Sử dụng GestureDetector để bắt sự kiện nhấn giữ
                      onLongPress: () {
                        _showDeleteConfirmationDialog(khoanThuChiList[index]);
                      },
                      child: KhoanThuChiListview(
                        name: khoanThuChiList[index].name,
                        icon: khoanThuChiList[index].icon,
                        date: khoanThuChiList[index].time,
                        price: khoanThuChiList[index].price,
                        type: khoanThuChiList[index].type,
                        money: khoanThuChiList[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm hiển thị hộp thoại xác nhận xóa
  Future<void> _showDeleteConfirmationDialog(Money money) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Click ngoài hộp thoại không đóng hộp thoại
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn xóa mục này không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: Text('Xóa'),
              onPressed: () {
                // Thực hiện xóa và đóng hộp thoại
                _deleteMoneyItem(money);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Hàm xóa mục khoản thu chi
  void _deleteMoneyItem(Money money) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('khoanthuchi').doc(money.id);

    // Thực hiện xóa tài liệu từ Firestore
    documentReference.delete().then((value) {
      // Xóa thành công, cập nhật giao diện người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xóa mục')),
      );
    }).catchError((error) {
      // Xử lý lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi xóa mục: $error')),
      );
    });
    setState(() {
      khoanThuChiList.remove(money);
    });
  }

// Ham hien thi Calender
  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // Lấy dữ liệu cho ngày đã chọn
      _layDuLieu(pickedDate);
    }
  }
}
