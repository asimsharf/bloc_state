import 'package:flutter/material.dart';

import '../models/user.dart';

Widget cardList(_, {required UserModel user}) {
  return Card(
    child: ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
    ),
  );
}
