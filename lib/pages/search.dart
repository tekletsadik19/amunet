import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Search extends ConsumerStatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  ConsumerState<Search> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<Search> {
  TextEditingController searchController = TextEditingController();
  String description = '';
  int searchFilterPage = 0;
  bool _isNoSearch = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  handleFilter(pageNumber){
    setState((){
      searchFilterPage = pageNumber;
    });
  }
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pinkAccent,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title:const Text("Discover",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: "Raleway"
              ),
            ),
            bottom: AppBar(
              backgroundColor: Colors.pinkAccent,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child:  Center(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(
                        color: Colors.pinkAccent
                    ),
                    decoration:  InputDecoration(
                      hintStyle:const TextStyle(color: Colors.black87),
                      hintText: 'Search from AMUNET',
                      prefixIcon: const Icon(Icons.search,color: Colors.black87,),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchController.clear();
                          setState((){
                            _isNoSearch = true;
                          });
                        },
                        child:const Icon(CupertinoIcons.clear, size: 12.0, color: Colors.black),
                      ),
                    ),
                    onSubmitted:(val){
                      setState((){
                        description = val;
                        _isNoSearch = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(),
            ],
            ),
          ),
        ],
      ),
    );
  }

}
