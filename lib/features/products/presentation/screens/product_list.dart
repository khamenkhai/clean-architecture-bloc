// product_page.dart
import 'package:flutter/cupertino.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isLoading = true;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      isLoading = false;
      products = _generateSampleProducts();
    });
  }

  List<Product> _generateSampleProducts() {
    return [
      Product(
        id: '1',
        title: 'iPhone 15 Pro',
        price: 999.00,
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
      ),
      Product(
        id: '2',
        title: 'MacBook Air M2',
        price: 1199.00,
        rating: 4.9,
        image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      ),
      Product(
        id: '3',
        title: 'AirPods Pro',
        price: 249.00,
        rating: 4.7,
        image: 'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=400',
      ),
      Product(
        id: '4',
        title: 'Apple Watch Series 9',
        price: 399.00,
        rating: 4.6,
        image: 'https://images.unsplash.com/photo-1551816230-ef5deaed4a26?w=400',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: null,
        middle: const Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _loadProducts,
          child: const Icon(CupertinoIcons.refresh),
        ),
      ),
      child: SafeArea(
        child: isLoading
            ? const Center(
                child: CupertinoActivityIndicator(radius: 20),
              )
            : products.isEmpty
                ? _buildEmptyState()
                : _buildProductList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              CupertinoIcons.bag,
              size: 40,
              color: CupertinoColors.systemGrey2,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Products Found',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.label,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check back later for new arrivals',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
          const SizedBox(height: 32),
          CupertinoButton.filled(
            borderRadius: BorderRadius.circular(12),
            onPressed: _loadProducts,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = products[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: CupertinoColors.secondarySystemGroupedBackground,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  pressedOpacity: 0.95,
                  onPressed: () {
                    // Handle product selection
                  },
                  child: Row(
                    children: [
                      // Product Image
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey5,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  CupertinoIcons.photo,
                                  color: CupertinoColors.systemGrey2,
                                  size: 32,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Product Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.label,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: CupertinoColors.systemBlue,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  size: 16,
                                  color: CupertinoColors.systemYellow,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoColors.label,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Chevron
                      const Icon(
                        CupertinoIcons.chevron_right,
                        size: 20,
                        color: CupertinoColors.systemGrey2,
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: products.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

// Product model
class Product {
  final String id;
  final String title;
  final double price;
  final double rating;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.image,
  });
}