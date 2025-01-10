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
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF007BFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Updated February 16, 2020',
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
                '1 - Rules for communication and customer service',
                '''
- Professional attitude: Employees must always be polite, cheerful, and gentle with customers.
- Attire: Must wear the correct resort uniform, always neat and clean.
- Communicate effectively: Must speak clearly, avoid using inappropriate language and ensure accurate information.
- Complaint handling: Employees need to receive and resolve complaints calmly and promptly, or transfer them to the manager in charge.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '2 - Information security policy',
                '''
- Privacy protection: Do not disclose personal information or customer transactions to third parties.
- Internal security: Comply with security regulations of the tourist area (such as revenue, event planning).
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '3 -Support and service provision process',
                '''
- Receive requests quickly: Employees must respond to customer requests as quickly as possible.
- Companion and guidance: Assist guests in understanding services, maps, and event schedules.
- Emergency services: In necessary situations, immediately notify the security or medical department.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '4 - Safety and handling emergency situations',
                '''
- Safety: Employees must comply with safety and fire prevention procedures.
- Incident response: Keep calm and assist customers according to procedures.
- Incident reporting: Any serious incidents must be reported immediately to management.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '5 -Employee rights and responsibilities',
                '''
- Working hours: Employees need to comply with shift times and not arbitrarily skip shifts.
- Leave regime: Employees are entitled to leave according to the regulations of the resort and labor laws.
- Reward and discipline: Individuals with excellent performance will be rewarded, while rule violations will be disciplined according to regulations.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '6 - Handle situations related to customer assets',
                '''
- Loss or damage to property: Employees need to assist customers in making records and reporting to the relevant department.
- Abandoned property: When discovering forgotten property, employees must submit it to the lost property management department of the tourist area.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '7 - Handle situations related to lost or swapped customer cards',
                '''
- Card loss notification: users will need to provide necessary information such as account number, personal identification information, and a short description of the card loss situation.
- Request to reissue card: when the customer requests to reissue the card or withdraw money when the card is lost, they must pay an additional 50,000 VND to reissue the card or withdraw money.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '8 -Handle situations related to lost or swapped customer cards',
                '''
- Card loss notification: users will need to provide necessary information such as account number, personal identification information, and a short description of the card loss situation.
- Request to reissue card: when the customer requests to reissue the card or withdraw money when the card is lost, they must pay an additional 50,000 VND to reissue the card or withdraw money.
                ''',
              ),
              const SizedBox(height: 20),
              buildSection(
                '9 - Safety and handling emergency situations',
                '''
- Collect customer opinions: Employees must encourage customers to evaluate the service and record comments.
- Improve service quality: Coordinate with relevant departments to improve weaknesses based on customer feedback.
                ''',
              ),
              buildSection(
                '10 - Customer card after use',
                '''
- Record transaction history: Each transaction made via card will be recorded in the transaction history. Users can look up transactions made, including time, location, and amount spent.
- Cancel or disable cards: expired cards will be automatically disabled by the system to prevent reuse. Users can request a new card if needed.
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
