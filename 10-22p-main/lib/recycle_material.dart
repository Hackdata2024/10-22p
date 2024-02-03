import 'package:flutter/material.dart';
class Recycle extends StatelessWidget {
  const Recycle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductCategory(category: 'Paper Products', subProducts: ['Newspapers', 'Magazines', 'Cardboard boxes', 'Office paper']),
          ProductCategory(category: 'Plastic Containers', subProducts: ['PET bottles (water and soda bottles)', 'HDPE containers (milk jugs, detergent bottles)', 'PVC containers']),
          ProductCategory(category: 'Glass', subProducts: ['Glass bottles', 'Jars']),
          ProductCategory(category: 'Metal Cans', subProducts: ['Aluminum cans', 'Steel cans (soup cans, food cans)']),
          ProductCategory(category: 'Electronics', subProducts: ['Cell phones', 'Computers', 'Printers']),
          ProductCategory(category: 'Textiles', subProducts: ['Clothing', 'Shoes', 'Bedding']),
          ProductCategory(category: 'Tires', subProducts: ['Rubber tires']),
          ProductCategory(category: 'Appliances', subProducts: ['Refrigerators', 'Washing machines', 'Dryers']),
          ProductCategory(category: 'Batteries', subProducts: ['Car batteries', 'Household batteries (rechargeable and non-rechargeable)']),
          ProductCategory(category: 'Car Parts', subProducts: ['Scrap metal from cars', 'Car batteries']),
          ProductCategory(category: 'Organic Waste', subProducts: ['Food scraps', 'Yard waste']),


          // Add more ProductCategory widgets for other product categories
        ],
      ),
    );
  }
}
class ProductCategory extends StatefulWidget {
  final String category;
  final List<String> subProducts;

  const ProductCategory({super.key, required this.category, required this.subProducts});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.category,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (isExpanded)
            Column(
              children: widget.subProducts
                  .map((subProduct) => InkWell(
                onTap: () {
                  // Implement your logic when a subProduct is tapped
                  print('Selected product: $subProduct');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(subProduct),
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}


