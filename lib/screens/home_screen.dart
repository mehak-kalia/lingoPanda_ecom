import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Default category selected for filtering products
  String selectedCategory = 'all';

  // List of product categories
  final List<String> categories = [
    'all',
    'beauty',
    'fragrances',
    'groceries',
    'furniture'
  ];

  @override
  Widget build(BuildContext context) {
    // Accessing ProductProvider to get the list of products
    final productProvider = Provider.of<ProductProvider>(context);

    // Filtering products based on the selected category
    List<Product> filteredProducts = selectedCategory == 'all'
        ? productProvider.products
        : productProvider.products
        .where((product) => product.category == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 250, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 80, 190, 1.0),
        toolbarHeight: 75, // Height of the AppBar
        title: Text(
          "e-Shop",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Horizontal category selection bar
          Container(
            height: 60, // Height of the category bar
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category; // Update selected category
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: selectedCategory == category
                          ? Color.fromRGBO(10, 80, 190, 1.0)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color.fromRGBO(10, 80, 190, 1.0),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category[0].toUpperCase() + category.substring(1),
                      style: GoogleFonts.poppins(
                        color: selectedCategory == category
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Expanded section for displaying products in a grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: filteredProducts.isEmpty
                  ? Center(child: CircularProgressIndicator()) // Loading indicator
                  : GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 6 / 9, // Aspect ratio for grid items
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

                  return GestureDetector(
                    onTap: () {
                      // Show product details in a modal bottom sheet
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return _buildProductDetailBottomSheet(
                              context, product, productProvider);
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.thumbnail,
                                fit: BoxFit.cover,
                                height: 130,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              product.title,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              product.description,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (productProvider.showDiscountedPrice &&
                                    product.discountedPrice < product.price) ...[
                                  Flexible(
                                    child: Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      '\$${product.discountedPrice.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      '(${product.discountPercentage}% off)',
                                      style: GoogleFonts.poppins(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ] else ...[
                                  Flexible(
                                    child: Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the bottom sheet displaying product details
  Widget _buildProductDetailBottomSheet(BuildContext context, Product product, ProductProvider productProvider) {
    // Determine the price to display based on discount settings
    final price = productProvider.showDiscountedPrice
        ? product.discountedPrice
        : product.price;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          color: Color.fromRGBO(245, 245, 250, 1.0),
        ),
        padding: EdgeInsets.all(16.0),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height , // Max height of the bottom sheet
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.thumbnail,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
      
            // Product Title
            Text(
              product.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
      
            // Product Description
            Text(
              product.description,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
      
            // Product Price
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
      
            // Reviews Section Header
            Text(
              "Reviews:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
      
            // Reviews Section
            Expanded(
              child: Column(
                children: product.reviews.map((review) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Reviewer's Name
                        Text(
                          review.reviewerName,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Review Rating
                        Row(
                          children: List.generate(
                            review.rating.toInt(),
                                (index) => Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                        SizedBox(height: 4),
                        // Review Comment
                        Text(
                          review.comment,
                          style: GoogleFonts.poppins(color: Colors.black54),
                        ),
                        SizedBox(height: 4),
                        // Review Date
                        Text(
                          "${DateTime.parse(review.date).toLocal().toString().split(' ')[0]}",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
