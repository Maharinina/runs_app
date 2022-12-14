import 'package:flutter/material.dart';
import 'package:runs/detail.dart';
import 'package:runs/models/shoes.dart';
import 'package:runs/service/runs_service.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Shoes> _shoes = [];
  List<Shoes> _shoesDisplay = [];

  bool isLoading = true;

  @override
  void initState() {
    RunService.fetchShoes().then((value) {
      setState(() {
        isLoading = false;
        _shoes.addAll(value);
        _shoesDisplay = _shoes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        title: Text(
          "Search",
          style: TextStyle(
              fontFamily: 'OpenSans-Bold',
              color: Color(0XFF383838),
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (!isLoading) {
                    return index == 0 ? _searchBar() : _listItem(index - 1);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
                itemCount: _shoesDisplay.length + 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  _listItem(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail(
                    shoes: Shoes(
                        id: _shoesDisplay[index].id,
                        nama: _shoesDisplay[index].nama,
                        image: _shoesDisplay[index].image,
                        warna: _shoesDisplay[index].warna,
                        desc: _shoesDisplay[index].desc,
                        price: _shoesDisplay[index].price,
                        brand: _shoesDisplay[index].brand,
                        isSaved: _shoesDisplay[index].isSaved as bool))));
      },
      child: ShoesCard(
          image: _shoesDisplay[index].image,
          nama: _shoesDisplay[index].nama,
          price: _shoesDisplay[index].price),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, top: 10),
      child: Column(
        children: [
          Container(
            child: TextFormField(
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  _shoesDisplay = _shoes.where((recipe) {
                    var recipeTitle = recipe.nama.toLowerCase();
                    return recipeTitle.contains(text);
                  }).toList();
                });
              },
              decoration: InputDecoration(
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF2F2F2))),
                fillColor: Color(0xFFF2F2F2),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFF2F2F2), width: 3)),
                hintText: 'Search for shoes',
                hintStyle: TextStyle(
                    fontFamily: 'OpenSans-Light',
                    color: Color(0xFF949494),
                    fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ShoesCard extends StatelessWidget {
  final String nama, image, price;
  const ShoesCard({
    Key? key,
    required this.nama,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 3,
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            nama,
            style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 2),
          Text(
            price,
            style: TextStyle(
              fontFamily: 'OpenSans-Regular',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
