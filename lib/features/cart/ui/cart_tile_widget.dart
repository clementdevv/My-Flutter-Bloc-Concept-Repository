import 'package:bloc_state_management/features/home/bloc/home_bloc.dart';
import 'package:bloc_state_management/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

import '../bloc/cart_bloc.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartTileWidget({super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),        
        border: Border.all(
          color: Colors.black87,
        ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(             
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
            child: const SizedBox(
              height: 220,
              width: double.maxFinite,
            ),
          ),
          const SizedBox(height: 20),
          Text(productDataModel.description),
          Text(
            productDataModel.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              '\$' + productDataModel.price.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(children: [
            IconButton(onPressed: () {
              // homeBloc.add(HomeProductWishListButtonClickedEvent(
              //   clickedProduct: productDataModel,
              // ),);
            }, icon: Icon(Icons.favorite_outline)),
            IconButton(onPressed: () {
              cartBloc.add(CartRemoveFromCartEvent(
                productDataModel: productDataModel,
              ),);
            }, icon: Icon(Icons.shopping_bag)),
          ],)
        ],
      ),
    );
  }
}
