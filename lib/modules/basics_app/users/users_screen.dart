
import 'package:all_in_one/models/user/user_model.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'Ahmed',
      phone: '+20111111111',
    ),
    UserModel(
      id: 2,
      name: 'Sayed',
      phone: '+20222222222',
    ),
    UserModel(
      id: 3,
      name: 'Abd',
      phone: '+203333333333',
    ),
    UserModel(
      id: 4,
      name: 'EL',
      phone: '+204444444444',
    ),
    UserModel(
      id: 5,
      name: 'Motaleb',
      phone: '+205555555555',
    ),
    UserModel(
      id: 1,
      name: 'Ahmed',
      phone: '+20111111111',
    ),
    UserModel(
      id: 2,
      name: 'Sayed',
      phone: '+20222222222',
    ),
    UserModel(
      id: 3,
      name: 'Abd',
      phone: '+203333333333',
    ),
    UserModel(
      id: 4,
      name: 'EL',
      phone: '+204444444444',
    ),
    UserModel(
      id: 5,
      name: 'Motaleb',
      phone: '+205555555555',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.phone,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
