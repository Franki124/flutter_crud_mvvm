import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:products_manager_mvvm/View/widgets/label_text_field_widget.dart';
import '../Model/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          product.name ?? 'Product Details',
          style: const TextStyle(
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
                controller: TextEditingController(text: product.name),
                readOnly: true,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.number,
                defaultText: 'Product Price',
                controller: TextEditingController(text: product.price?.toString()),
                readOnly: true,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.text,
                defaultText: 'Product Description',
                controller: TextEditingController(text: product.description),
                readOnly: true,
              ),
              // Add other fields as necessary
            ],
          ),
        ),
      ),
    );
  }
}
