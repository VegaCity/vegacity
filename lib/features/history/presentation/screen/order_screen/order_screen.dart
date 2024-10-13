import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'Nguyễn Văn A',
      'date': '12/09/2024',
      'time': '14:45',
      'package': 'Combo nước',
      'amount': '1,200,000đ',
      'status': 'Hoàn thành',
      'paymentMethod': 'Momo',
    },
    {
      'name': 'Trần Thị B',
      'date': '11/09/2024',
      'time': '10:30',
      'package': 'Combo trọn gói',
      'amount': '1,500,000đ',
      'status': 'Chưa hoàn thành',
      'paymentMethod': 'VNPay',
    },
    {
      'name': 'Lê Văn C',
      'date': '10/09/2024',
      'time': '09:20',
      'package': 'Combo Khô',
      'amount': '1,000,000đ',
      'status': 'Hoàn thành',
      'paymentMethod': 'Momo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Nhóm các giao dịch theo tháng/năm
    final groupedTransactions = <String, List<Map<String, dynamic>>>{};

    for (var transaction in transactions) {
      final date = DateFormat('dd/MM/yyyy').parse(transaction['date']);
      final monthYear = DateFormat('MM/yyyy').format(date);

      if (!groupedTransactions.containsKey(monthYear)) {
        groupedTransactions[monthYear] = [];
      }
      groupedTransactions[monthYear]!.add(transaction);
    }

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: groupedTransactions.entries.map((entry) {
        final monthYear = entry.key;
        final transactions = entry.value;

        // Tính tổng thu cho tháng/năm
        final totalAmount = transactions.fold<int>(
          0,
          (sum, transaction) {
            final amountString = transaction['amount'] ?? '0VND';
            final amount = int.tryParse(
                    amountString.replaceAll('VND', '').replaceAll(',', '')) ??
                0;
            return sum + amount;
          },
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề tháng/năm với chữ "Tháng"
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                child: Text(
                  'Tháng ${monthYear.split('/')[0]}/${monthYear.split('/')[1]}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Hiển thị tổng thu
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  'Tổng thu: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(totalAmount)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...transactions.map((transaction) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 12, bottom: 8.0, right: 12),
                      child: Row(
                        children: [
                          // Hiển thị icon trong Container hình vuông
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: transaction['status'] == 'Hoàn thành'
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8), // bo góc
                            ),
                            child: Icon(
                              transaction['status'] == 'Hoàn thành'
                                  ? Icons.attach_money
                                  : Icons.money_off,
                              size: 25,
                              color: transaction['status'] == 'Hoàn thành'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Nội dung giao dịch nằm ở bên phải
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Hàng trên cùng: Tên người giao dịch (trái) và số tiền (phải)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      transaction['name'] ?? 'Không có tên',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // Hiển thị số tiền với dấu cộng nếu "Hoàn thành"
                                    Text(
                                      '${transaction['status'] == 'Hoàn thành' ? '+' : ''}${transaction['amount'] ?? 'Không có số tiền'}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 2),
                                // Thời gian và trạng thái giao dịch
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${transaction['time'] ?? 'Không có thời gian'} ${transaction['date'] ?? 'Không có ngày'}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      transaction['status'] ??
                                          'Không có trạng thái',
                                      style: TextStyle(
                                        color: transaction['status'] ==
                                                'Hoàn thành'
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                // Gói giao dịch và phương thức thanh toán
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Gói: ${transaction['package'] ?? 'Không có gói'}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${transaction['paymentMethod'] ?? 'tiền mặt'}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Đường kẻ phân cách dưới mỗi giao dịch
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 8.0, right: 8.0),
                      child: Divider(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      }).toList(),
    );
  }
}
