import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/show_dialog.dart';
Map<String, int> quantities = {};
class Recycle extends StatefulWidget {
  const Recycle({super.key});

  @override
  State<Recycle> createState() => _RecycleState();
}
class _RecycleState extends State<Recycle> {
  int userPoints=0;
  @override
  void initState() {
    // TODO: implement initState
    _loadUserPoints();
    super.initState();
  }
  _loadUserPoints() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userPoints = prefs.getInt('userPoints') ?? 0;
    });
  }
  _saveUserPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userPoints', points);
  }
  _recycleItem(int totalLength) {
    setState(() {
      userPoints+=totalLength;
      _saveUserPoints(userPoints);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SingleChildScrollView(
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
              ProductCategory(category: 'Batteries', subProducts: ['Car batteries', 'Household batteries']),
              ProductCategory(category: 'Car Parts', subProducts: ['Scrap metal from cars', 'Car batteries']),
              ProductCategory(category: 'Organic Waste', subProducts: ['Food scraps', 'Yard waste']),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: ElevatedButton(
            onPressed: () {
              List<String>recycledItems=quantities.entries.where((entry) => entry.value>0).map((entry) => '${entry.key}-${entry.value}').toList();

              if(recycledItems.isNotEmpty)
              {
                int totalLength = recycledItems.fold(0, (sum, item) {
                  // Split each item to get the quantity part and add it to the sum
                  return sum + int.parse(item.split('-')[1]);
                });

                showRecycledDialog(context, recycledItems);
                _recycleItem(totalLength);
                print("I found this much $userPoints");
                print("Hello, I found the following length: $totalLength");
                print('You recycled the following items: ${recycledItems.join(', ')}');
                quantities.clear();
              }
              else
              {
                showNoItemsSelectedDialog(context);
              }


            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text(
              'Recycle',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class ProductCategory extends StatefulWidget {
  final String category;
  final List<String> subProducts;

  const ProductCategory({Key? key, required this.category, required this.subProducts});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        title: ListTile(
          title: Text(
            widget.category,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        trailing: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
        onExpansionChanged: (bool expanded) {
          // Handle expansion state changes if needed
        },
        children: [
          Container(
            height: 150, // Adjust the height as needed
            child: ListView(
              children: widget.subProducts
                  .map((subProduct) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Implement your logic when a subProduct is tapped
                            print('Selected product: $subProduct');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(subProduct),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantities.containsKey(subProduct) &&
                                    quantities[subProduct]! > 0) {
                                  quantities[subProduct] =
                                      quantities[subProduct]! - 1;
                                }
                              });
                            },
                          ),
                          Text(
                            '${quantities[subProduct] ?? 0}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantities[subProduct] =
                                    (quantities[subProduct] ?? 0) + 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(), // Divider after each subProduct
                ],
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
void showNoItemsSelectedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('No Items Selected'),
        content: const Text('Please select items to recycle before clicking the Recycle button.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}