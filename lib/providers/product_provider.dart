import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../services/firebase_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  final FirebaseService _firebaseService = FirebaseService();

  List<Product> _products = [];
  bool _showDiscountedPrice = false;
  bool _isLoading = true; // Track loading state

  List<Product> get products => _products;
  bool get showDiscountedPrice => _showDiscountedPrice;
  bool get isLoading => _isLoading; // Expose loading state

  ProductProvider() {
    // Initialize data fetching
    initialize();
  }

  // Asynchronous initialization of fetching methods
  Future<void> initialize() async {
    await Future.wait([_fetchProducts(), _fetchRemoteConfig()]);
    _isLoading = false; // Set loading to false after fetching
    notifyListeners(); // Notify after all data is fetched
  }

  // Fetch products from the ProductService
  Future<void> _fetchProducts() async {
    try {
      _products = await _productService.fetchProducts();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products.'); // Propagate error
    }
  }

  // Fetch the 'showDiscountedPrice' flag from Firebase Remote Config
  Future<void> _fetchRemoteConfig() async {
    try {
      _showDiscountedPrice = await _firebaseService.getShowDiscountedPrice();
      notifyListeners(); // Notify the UI to rebuild when the config is fetched
    } catch (e) {
      print('Error fetching Remote Config: $e');
      throw Exception('Failed to fetch remote config.'); // Propagate error
    }
  }
}
