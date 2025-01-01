import 'package:base/features/history/domain/entities/history_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final HistoryEntity history;
  final currencyFormatter = NumberFormat('#,##0', 'vi_VN');
  final dateFormatter = DateFormat('dd/MM/yyyy');

  OrderDetails({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTransactionInfo(),
              const SizedBox(height: 20),
              _buildDescriptionSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            history.status == 'Success' ? Icons.check_circle : Icons.cancel,
            color: history.status == 'Success' ? Colors.green : Colors.red,
            size: 40,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaction ID:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                '${history.id}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Date: ${dateFormatter.format(history.crDate)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Status', history.status),
          const SizedBox(height: 5),
          const Divider(
            color: Colors.black26, // Màu mờ hơn, điều chỉnh opacity tại đây
            thickness: 0.5, // Độ dày mỏng hơn
            height: 1, // Chiều cao của Divider
          ),
          const SizedBox(height: 5),
          _buildInfoRow(
              'Amount', '${currencyFormatter.format(history.amount)} VND'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: value.toLowerCase() == 'success'
                  ? Colors.green
                  : value.toLowerCase() == 'cancel'
                      ? Colors.red
                      : Colors
                          .green, // Default color if status is neither Success nor Cancel
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            history.description,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
