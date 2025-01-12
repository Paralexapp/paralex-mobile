import 'package:flutter/material.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/controllers/search_controller.dart';
import 'package:get/get.dart';

class SearchTab extends StatelessWidget {
  final MySearchController searchController = Get.put(MySearchController());
   SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() => TextField(
                  controller: searchController.textEditingController,
                  onChanged: (value) {
                    searchController.updateSuggestions(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search...",
                    suffixIcon: searchController.searchText.value.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear,color: Colors.red,),
                      onPressed: () {
                        searchController.textEditingController.clear();
                        searchController.updateSuggestions('');
                      },
                    )
                        : null,
                  ),
                )),

              ),
              SizedBox(height: 10),
              Obx(() {
                if (searchController.suggestions.isEmpty) {
                  return SizedBox();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: searchController.suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = searchController.suggestions[index];
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () => searchController.selectSuggestion(suggestion),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: searchController.performSearch,
                child: const Text('Search',style: TextStyle(color: PaintColors.paralexpurple),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

