import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/cart_provider.dart';
import 'package:shopping_provider/item.dart';
import 'package:shopping_provider/my_basket.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController namePhone = TextEditingController();
  final TextEditingController price = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, myProvider, child) => Row(
              children: [
                Text(
                  '${myProvider.totalePrice.toInt()}\$ / ${myProvider.totalePhones}',
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyBasketShop(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CartProvider>(
            builder: (context, myProvider, child) => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: myProvider.items.length,
                    itemBuilder: (context, i) => Card(
                      color: Colors.white60,
                      child: Consumer<CartProvider>(
                        builder: (context, myProvider, child) => ListTile(
                          title: Text(myProvider.items[i].name),
                          subtitle: Text('${myProvider.items[i].price} \$'),
                          trailing: IconButton(
                            onPressed: () =>
                                myProvider.addItem((myProvider.items[i])),
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: namePhone,
                                autovalidateMode: AutovalidateMode.always,
                                validator: (value) {
                                  if (namePhone.text.isEmpty) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Name Phone',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                controller: price,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value.contains('-') ||
                                      value.startsWith('.') ||
                                      value.contains(',')) {
                                    return 'Invalid';
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'price',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    myProvider.addProducts(
                                      namePhone.text,
                                      double.parse(price.text),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Add Now'),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Add Products'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
