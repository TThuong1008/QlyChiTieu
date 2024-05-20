import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qlmoney/data/money.dart';

class FirebaseService {

  Future<List<Money>> getMoneyData() async {
    final user = FirebaseAuth.instance.currentUser;
    List<Money> danhSachGiaoDich = [];
    if(user != null) {
      try {
        DatabaseEvent _moneyRef = await FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(user.uid)
            .child('khoanthuchi')
            .once();
        DatabaseEvent snapshot = await FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(user.uid)
            .child('typecategorys')
            .once();

        // Lấy dữ liệu từ Firebase một lần
        var moneySnapshot = _moneyRef.snapshot.value as Map<dynamic, dynamic>?;
        var categorySnapshot = snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (moneySnapshot != null && categorySnapshot != null) {
          // Lưu trữ dữ liệu tipecategorys trong một bản đồ với các ID loại làm khóa


          moneySnapshot.forEach((key, value) {
            // Lấy ID loại từ mỗi giao dịch và thêm vào danh sách
            String categoryIcon = '';
            String categoryName = '';
            String categoryId = value['category_id'];
            if (categorySnapshot!=null) {

              categorySnapshot.forEach((key, value) {
                String id = value['id'];
                if(id==categoryId){
                  categoryName = value['name'];
                  categoryIcon = value['icon'];
                }
              });
            }
            String time = value['date'];
            String name=value['name'];
            String type = value['type'];
           String price = value['price'];
            Money money = Money(
              icon: categoryIcon,
              nameCategory: categoryName,
              name:name , // Giả định 'name' là trường tên của giao dịch
              time: time,
              type: type,
              price: price,
            );

            danhSachGiaoDich.add(money);
          });

        }

      } catch (error) {
        print('Lỗi khi lấy dữ liệu giao dịch: $error');
        // Xử lý lỗi nếu có
        throw error; // Ném ngoại lệ để cho phép người gọi xử lý
      }
    }
    print(danhSachGiaoDich);
    return danhSachGiaoDich;
  }
}
