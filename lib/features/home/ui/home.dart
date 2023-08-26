import 'package:bloc_state_management/features/cart/ui/cart.dart';
// import 'package:bloc_state_management/features/home/models/home_product_data_model.dart';
import 'package:bloc_state_management/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../cart/ui/cart_clicked.dart';
// import '../../wishlist/ui/wishlist_clicked.dart';
import '../bloc/home_bloc.dart';
import 'product_tile_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(
      HomeInitialEvent(),
    );
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (context, current) => current is! HomeActionState,
      listener: (previous, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cart()),
          );
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishList()),
          );
        }
        // } else if (state is NavigateToCart) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const CartClicked()),
        //   );
        // } else if (state is NavigateToWishList) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const WishListClicked()),
        //   );
        // }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Center(
                  child: Text(
                    'Mr.Shit Grocery App',
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeWishlistButtonNavigateEvent(),
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeCartButtonNavigateEvent(),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
              body: ListView.builder(
                itemBuilder: ((context, index) {
                  return ProductTileWidget(
                    homeBloc: homeBloc,
                    productDataModel: successState.products[index],
                  );
                }),
                itemCount: successState.products.length,
                
              ),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
