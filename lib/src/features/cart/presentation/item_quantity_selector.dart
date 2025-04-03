import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';

class ItemQuantitySelector extends StatelessWidget {
  const ItemQuantitySelector({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    this.onChanged,
    this.onChangedForDeletion,
  });

  final int quantity;
  final int maxQuantity;
  final ValueChanged<int>? onChanged;
  final void Function()? onChangedForDeletion;

  @override
  Widget build(BuildContext context) {
    return Row(
      //TODO delete comments below if not needed
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (quantity == 1 && onChangedForDeletion != null)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onChangedForDeletion,
          )
        else
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed:
                onChanged != null && quantity > 1
                    ? () => onChanged!.call(quantity - 1)
                    : null,
          ),
        gapW4,
        Text('$quantity', style: Theme.of(context).textTheme.titleMedium),
        gapW4,
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed:
              onChanged != null && quantity < maxQuantity
                  ? () => onChanged!.call(quantity + 1)
                  : null,
        ),
      ],
    );
  }
}
