import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:products_manager_mvvm/View/widgets/label_text_field_widget.dart';
import '../ViewModel/product_list_notifier.dart';

import '../Model/product.dart';

class EditProductView extends ConsumerWidget {
  final Product product;

  const EditProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: product.name);
    final priceController = TextEditingController(text: product.price?.toString());
    final descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Edit Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              LabelTextField(
                inputType: TextInputType.text,
                defaultText: 'Product Name',
                controller: nameController,
                readOnly: false,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.number,
                defaultText: 'Product Price',
                controller: priceController,
                readOnly: false,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.text,
                defaultText: 'Product Description',
                controller: descriptionController,
                readOnly: false,
              ),
              TextButton(
                onPressed: () {
                  final updatedProduct = Product(
                    id: product.id,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: int.tryParse(priceController.text),
                    history: [...?product.history, Product.createHistoryEntry('Updated', '...')],
                  );
                  ref.read(productListProvider.notifier).updateProduct(updatedProduct);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
