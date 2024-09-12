import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SolderItem extends StatelessWidget {
  String name;
  String address;
  String militaryId;
  void Function()? onTap;
  void Function(BuildContext)? onDelete;

  SolderItem({
    super.key,
    required this.address,
    required this.name,
    required this.militaryId,
    this.onTap,
    required onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Slidable(
        startActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ]),
        child: ListTile(
          onTap: onTap,
          title: Text(name),
          subtitle: Text(address),
          trailing: Text(militaryId),
        ),
      ),
    );
  }
}
