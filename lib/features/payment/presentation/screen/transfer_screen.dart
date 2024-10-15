import 'package:base/configs/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class TransferScreen extends HookConsumerWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              AutoRouter.of(context).navigate(HomeScreenRoute());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chuyển tiền',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        AutoRouter.of(context).navigate(ScannerScreenRoute());
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _buildGrid(),
              ),
              
            Container(
  padding: const EdgeInsets.all(16), 
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16), 
    boxShadow: [ 
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 4,
        spreadRadius: 2,
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSavedAndTemplateButtons(),
      SizedBox(height: 16),
      _buildSearchField(),
      SizedBox(height: 16),
      _buildUserCard('NGUYEN HOANG KHANG', '1290197042292', 'Ngân hàng TMCP Quân đội'),
      _buildUserCard('NGUYEN HOANG KHANG', '1290197042292', 'Ngân hàng TMCP Quân đội'),
    ],
  ),
)

,

            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildSavedAndTemplateButtons() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Row(
        children: [
    
          Expanded(
            child: InkWell(
              onTap: () {
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue, // Blue background for the selected tab
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Đã lưu',
                  style: TextStyle(
                    color: Colors.white, // White text for the selected tab
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          
          // 'Mẫu chuyển tiền' tab
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle 'Mẫu chuyển tiền' action
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white, // White background for the unselected tab
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Text(
                  'Mẫu chuyển tiền',
                  style: TextStyle(
                    color: Colors.blue, // Blue text for the unselected tab
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Stack(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Tìm theo tên, số tài khoản',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 12,
          child: Icon(Icons.search, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildUserCard(String name, String account, String bank) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://placehold.co/30x30'),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(account, style: TextStyle(color: Colors.grey)),
              Text(bank, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildGridItem(Icons.account_balance, 'Số tài khoản'),
        _buildGridItem(Icons.phone, 'Số điện thoại'),
        _buildGridItem(Icons.credit_card, 'Số thẻ'),
        _buildGridItem(Icons.search, 'Truy vấn giao dịch'),
      ],
    );
  }

  Widget _buildGridItem(IconData icon, String label, {int colSpan = 1}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
