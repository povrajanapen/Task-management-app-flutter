import 'package:flutter/material.dart';
import 'package:task_management_app/models/member_model.dart';
import '../dummy/dummy_members.dart';
import '../models/app_color.dart';

class AssignedMembers extends StatelessWidget {
  final List<int> assignedMemberIds;

  const AssignedMembers({super.key, required this.assignedMemberIds});

  @override
  Widget build(BuildContext context) {
    
    // Filter the assigned members based on their IDs
    List<MemberModel> assignedMembers = dummyMembers
        .where((member) => assignedMemberIds.contains(member.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: assignedMembers.isEmpty
          ? const Center(
              child: Text(
                'No members assigned to this project.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          :  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'assigned to',
            style: AppColors.greetingStyle,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60, // Constrain the height of the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: assignedMembers.length,
              itemBuilder: (context, index) {
                final member = assignedMembers[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(member.avatarUrl),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 50, // Constrain name width
                        child: Text(
                          member.name,
                          style: AppColors.captionStyle,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center, // Align name to center
                        ),
                      ),
                    ],
                  );
                
              },
            ),
          ),
        ],
      ),
    );
  }
}