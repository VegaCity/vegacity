import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class PolicyPrivacyScreen extends StatelessWidget {
  const PolicyPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      context.router.pop(); // Navigate back
                    },
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Điều Khoản',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF007BFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Cập nhật 16/02/2020',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sections with policy information
              buildSection(
                '1 - Quy tắc giao tiếp và phục vụ khách hàng',
                '''
- Thái độ chuyên nghiệp: Nhân viên phải luôn lịch sự, vui vẻ, hòa nhã với khách hàng.
- Trang phục: Phải mặc đúng đồng phục của khu du lịch, luôn gọn gàng và sạch sẽ.
- Giao tiếp hiệu quả: Phải nói năng rõ ràng, tránh sử dụng ngôn ngữ không phù hợp và đảm bảo thông tin chính xác.
- Xử lý khiếu nại: Nhân viên cần tiếp nhận và giải quyết khiếu nại bình tĩnh, kịp thời, hoặc chuyển cho quản lý phụ trách.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '2 - Chính sách bảo mật thông tin',
                '''
- Bảo vệ quyền riêng tư: Không được tiết lộ thông tin cá nhân hoặc giao dịch của khách cho bên thứ ba.
- Bảo mật nội bộ: Tuân thủ các quy định bảo mật của khu du lịch (như doanh thu, kế hoạch sự kiện).
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '3 - Quy trình hỗ trợ và cung cấp dịch vụ',
                '''
- Tiếp nhận yêu cầu nhanh chóng: Nhân viên phải trả lời yêu cầu của khách trong thời gian nhanh nhất.
- **Đồng hành và hướng dẫn: Hỗ trợ khách tìm hiểu các dịch vụ, bản đồ, lịch trình sự kiện.
- **Dịch vụ khẩn cấp: Trong tình huống cần thiết, thông báo ngay cho bộ phận an ninh hoặc y tế.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '4 - An toàn và xử lý tình huống khẩn cấp',
                '''
- An toàn: Nhân viên phải tuân thủ các quy trình an toàn và phòng cháy chữa cháy.
- Ứng phó sự cố: Giữ bình tĩnh và hỗ trợ khách đúng quy trình.
- Báo cáo sự cố: Mọi sự cố nghiêm trọng phải báo ngay cho quản lý.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '5 - Quyền lợi và trách nhiệm của nhân viên',
                '''
- Thời gian làm việc: Nhân viên cần tuân thủ thời gian ca làm việc và không tự ý bỏ ca.
- Chế độ nghỉ phép: Nhân viên được nghỉ phép theo quy định của khu du lịch và pháp luật lao động.
- Khen thưởng và kỷ luật: Các cá nhân có thành tích xuất sắc sẽ được khen thưởng, trong khi các hành vi vi phạm quy tắc sẽ bị kỷ luật theo quy định.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '6 - Xử lý tình huống liên quan đến tài sản khách hàng',
                '''
- Mất mát hoặc hư hỏng tài sản: Nhân viên cần hỗ trợ khách hàng lập biên bản và báo cáo cho bộ phận liên quan.
- Tài sản bỏ quên: Khi phát hiện tài sản bị bỏ quên, nhân viên phải nộp cho bộ phận quản lý tài sản thất lạc của khu du lịch.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '7 - Xử lý tình huống liên quan đến mất thẻ hay bị đánh tráo thẻ của khách hàng',
                '''
- Thông báo mất thẻ: người dùng sẽ cần cung cấp các thông tin cần thiết như số tài khoản, thông tin xác thực cá nhân, và mô tả ngắn về tình huống mất thẻ.
- Yêu cầu cấp lại thẻ: khi khách hàng yêu cầu cấp lại thẻ hoặc rút tiền lại khi thẻ mất thì phải nộp thêm 50.000VND để cấp lại thẻ hoặc rút tiền.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '8 - Xử lý tình huống liên quan đến mất thẻ hay bị đánh tráo thẻ của khách hàng',
                '''
- Thông báo mất thẻ: người dùng sẽ cần cung cấp các thông tin cần thiết như số tài khoản, thông tin xác thực cá nhân, và mô tả ngắn về tình huống mất thẻ.
- Yêu cầu cấp lại thẻ: khi khách hàng yêu cầu cấp lại thẻ hoặc rút tiền lại khi thẻ mất thì phải nộp thêm 50.000VND để cấp lại thẻ hoặc rút tiền.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '9 - An toàn và xử lý tình huống khẩn cấp',
                '''
- Thu thập ý kiến khách hàng: Nhân viên phải khuyến khích khách đánh giá dịch vụ và ghi nhận các ý kiến đóng góp.
- Cải thiện chất lượng dịch vụ: Phối hợp với các bộ phận liên quan để cải thiện những điểm yếu dựa trên phản hồi của khách hàng.
                ''',
              ),
              buildSection(
                '10 - Thẻ khách hàng khi xài xong',
                '''
- Ghi nhận lịch sử giao dịch: Mỗi giao dịch thực hiện qua thẻ sẽ được ghi vào lịch sử giao dịch. Người dùng có thể tra cứu các giao dịch đã thực hiện, bao gồm thời gian, địa điểm, và số tiền đã chi tiêu.
- Hủy hoặc vô hiệu hóa thẻ: các thẻ đã hết hạn, hệ thống sẽ tự động vô hiệu hóa để ngăn việc sử dụng lại. Người dùng có thể yêu cầu cấp thẻ mới nếu cần.
                ''',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build a section with a title and content
  Widget buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF007BFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
