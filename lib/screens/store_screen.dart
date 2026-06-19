import 'package:flutter/material.dart';
import '../models/store_item.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCoins = -1;

  final coinPackages = [
    CoinPackage(id: 'c1', coinAmount: 10, price: 1, bonusCoins: 0),
    CoinPackage(
      id: 'c2',
      coinAmount: 50,
      price: 4,
      bonusCoins: 10,
      isMostPopular: true,
    ),
    CoinPackage(id: 'c3', coinAmount: 100, price: 8, bonusCoins: 20),
    CoinPackage(id: 'c4', coinAmount: 500, price: 35, bonusCoins: 150),
    CoinPackage(id: 'c5', coinAmount: 1000, price: 68, bonusCoins: 400),
  ];

  final storeItems = [
    StoreItem(
      id: 'vip1',
      name: '30-Day VIP',
      description: 'VIP membership for 30 days',
      category: StoreCategory.vip,
      price: 99,
      imageUrl: '🎖️',
      durationDays: 30,
      vipPoints: 3000,
    ),
    StoreItem(
      id: 'vip2',
      name: '30-Day SVIP',
      description: 'SVIP membership for 30 days',
      category: StoreCategory.vip,
      price: 199,
      imageUrl: '✨',
      durationDays: 30,
      vipPoints: 6000,
      isBestSeller: true,
    ),
    StoreItem(
      id: 'frame1',
      name: 'Gold Avatar Frame',
      description: 'Exclusive gold frame',
      category: StoreCategory.frame,
      price: 50,
      imageUrl: '👑',
      isLimited: true,
      discountPercent: 20,
      originalPrice: 60,
    ),
    StoreItem(
      id: 'frame2',
      name: 'Platinum Avatar Frame',
      description: 'Premium platinum frame',
      category: StoreCategory.frame,
      price: 100,
      imageUrl: '💎',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Store',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  GlassContainer(
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    borderRadius: 14,
                    child: const Icon(Icons.close, size: 22),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.glassLight.withAlpha((0.05 * 255).toInt()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.accentGradient),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(fontSize: 13),
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Coins & Recharge'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('VIP & Items'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildCoinsTab(), _buildVipTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: coinPackages.length,
      itemBuilder: (context, index) {
        final pkg = coinPackages[index];
        final isSelected = _selectedCoins == index;

        return GestureDetector(
          onTap: () => setState(() => _selectedCoins = index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(colors: AppColors.accentGradient)
                  : null,
              color: isSelected
                  ? null
                  : AppColors.glassLight.withAlpha((0.08 * 255).toInt()),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? AppColors.accentLight
                    : AppColors.borderLight.withAlpha((0.1 * 255).toInt()),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '💰 ${pkg.totalCoins}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (pkg.bonusCoins > 0)
                          Text(
                            '+${pkg.bonusCoins} bonus',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    if (pkg.isMostPopular)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: AppColors.accentGradient,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Most Popular',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: isSelected
                      ? () => _buyCoins(pkg)
                      : () => setState(() => _selectedCoins = index),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withAlpha(0x33)
                          : AppColors.accentLight.withAlpha(0x33),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '\$${pkg.price}.99',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white
                            : AppColors.accentLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVipTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        ...storeItems.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.glassLight.withAlpha((0.08 * 255).toInt()),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.borderLight.withAlpha((0.1 * 255).toInt()),
              ),
            ),
            child: Row(
              children: [
                Text(item.imageUrl, style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          if (item.isBestSeller)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: AppColors.accentGradient,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Best',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _buyItem(item),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppColors.accentGradient,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${item.price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                              if (item.hasDiscount) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '\$${item.originalPrice} -${item.discountPercent}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _buyCoins(CoinPackage package) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Buying ${package.totalCoins} coins for \$${package.price}.99',
        ),
        backgroundColor: AppColors.accentLight,
      ),
    );
  }

  void _buyItem(StoreItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buying ${item.name} for \$${item.price}'),
        backgroundColor: AppColors.accentLight,
      ),
    );
  }
}
