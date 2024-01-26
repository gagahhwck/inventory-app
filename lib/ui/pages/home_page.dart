import 'package:flutter/material.dart';
import 'package:inventory_app/helper/shared_pref.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:inventory_app/ui/pages/login_page.dart';
import 'package:inventory_app/ui/pages/search_page.dart';
import 'package:inventory_app/ui/widgets/grid_item_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _sharedPref = SharedPref();
    final itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              await _sharedPref.remove('login');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: itemProvider.isFetching
          ? const CircularProgressIndicator()
          : GridView.builder(
              itemCount: itemProvider.listBarang.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final barang = itemProvider.listBarang[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormPage(
                                  itemBarang: barang,
                                )));
                  },
                  child: GridItemWidgets(barang: barang),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
