import 'package:base/features/profile/presentation/widgets/item/detailPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Map<String, dynamic> dashboardData = {};
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      final response = await dio.post(
        'https://api.vegacity.id.vn/api/v1/transaction/dashboard',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI4YWQzNDFiNy0wNDNiLTRjMmItYmE3ZS0wOWY3ZDlkNjIzMGQiLCJlbWFpbCI6Imh1eWhvYW5ncnQwMDlAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQ2FzaGllckFwcCIsIk1hcmtldFpvbmVJZCI6IjVmNzI4ZGViLWIyYzMtNGJhYy05ZDljLTQxYTExZTBhY2NjYyIsIm5iZiI6MTczNjY3ODEyOSwiZXhwIjoxNzM2NzIxMzI5LCJpc3MiOiJWZWdhQ2l0eUFwcCJ9.0_ZB_112p_ci9SQ4Q_bhWV-XwuaFPl4Cx8OLOTZ9xio',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "startDate": "2024-07-01",
          "endDate": "2025-03-03",
          "days": 365,
          "saleType": "PackageItem Charge",
          "groupBy": "Date"
        },
      );

      setState(() {
        dashboardData = response.data['data'];
      });
    } catch (e) {
      print('Error fetching dashboard data: $e');
    }
  }

  Widget buildSummaryCard(
      String title, String value, Color color, IconData icon) {
    return Expanded(
      child: SizedBox(
        height: 150,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 30),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailCard(Map<String, dynamic> data) {
    final NumberFormat currencyFormat = NumberFormat.decimalPattern();
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          'Date: ${data['formattedDate']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow('Total Order', '${data['totalOrder']}'),
                _buildDetailRow('Total Amount Order',
                    currencyFormat.format(data['totalAmountOrder'])),
                _buildDetailRow(
                    'Total Order Cash', '${data['totalOrderCash']}'),
                _buildDetailRow('Total Amount Cash Order',
                    currencyFormat.format(data['totalAmountCashOrder'])),
                _buildDetailRow('TotalOrderOnlineMethods',
                    '${data['totalOrderOnlineMethods']}'),
                _buildDetailRow(
                    'TotalAmountOrderOnlineMethod',
                    currencyFormat
                        .format(data['totalAmountOrderOnlineMethod'])),
                _buildDetailRow(
                    'Total Order Fee Charge', '${data['totalOrderFeeCharge']}'),
                _buildDetailRow('Total Amount Fee Charge',
                    currencyFormat.format(data['totalAmountOrderFeeCharge'])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormat = NumberFormat.decimalPattern();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Dashboard Overview',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: dashboardData.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        buildSummaryCard(
                          'Balance',
                          currencyFormat
                              .format(dashboardData['cashierAppBalance']),
                          Colors.green,
                          Icons.account_balance_wallet,
                        ),
                        const SizedBox(width: 16),
                        buildSummaryCard(
                          'Virtual Currency',
                          currencyFormat.format(
                              dashboardData['cashierAppBalanceHistory']),
                          Colors.blue,
                          Icons.history,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 80), // Add bottom padding for FAB
                      itemCount: dashboardData['groupedStaticsAdmin'].length,
                      itemBuilder: (context, index) {
                        final data =
                            dashboardData['groupedStaticsAdmin'][index];
                        return buildDetailCard(data);
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Add your navigation logic here
              // For example:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DetailPage()));
            },
            backgroundColor: Colors.blue,
            label: const Text(
              'Transaction History',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
