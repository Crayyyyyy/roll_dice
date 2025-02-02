import 'package:flutter/material.dart';
import 'package:roll_dice/pages/pageExpense/components/expense.dart';

class ListExpenses extends StatelessWidget {
  List<Expense> list;
  void Function(Expense expense) onDismissedExpense;

  ListExpenses({
    super.key,
    required this.list,
    required this.onDismissedExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(list[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          child: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        onDismissed: (direction) {
          onDismissedExpense(list[index]);
        },
        child: TileExpense(
          expense: list[index],
        ),
      ),
      itemCount: list.length,
    );
  }
}

class TileExpense extends StatelessWidget {
  TileExpense({super.key, required this.expense});

  Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${expense.amount.toString()} €'),
        subtitle: Text(expense.title),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconsCategory[expense.category]),
            Text(expense.formattedDate),
          ],
        ),
      ),
    );
  }
}
