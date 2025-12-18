import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
import 'json_models.dart';
import 'json_cross_file_test.dart';

part 'json_complex_cross_file.freezed.dart';
part 'json_complex_cross_file.g.dart';
part 'json_complex_cross_file.map.dart';

/// Test case: Complex cross-file scenario with nested imports and JSON annotations

@freezed
sealed class ShoppingCart with _$ShoppingCart {
  const factory ShoppingCart({
    @JsonKey(name: 'cart_id') required String cartId,
    @JsonKey(name: 'customer_details') required CustomerInfo customerDetails,
    @JsonKey(name: 'cart_items') required List<CartItem> cartItems,
    @JsonKey(name: 'cart_totals') required CartTotals cartTotals,
    @JsonKey(name: 'shipping_info') required Address shippingInfo,
    @JsonKey(name: 'billing_info') required Address billingInfo,
    @JsonKey(name: 'cart_status') required OrderStatus cartStatus,
    @JsonKey(name: 'created_timestamp') required DateTime createdTimestamp,
    @JsonKey(name: 'last_updated') required DateTime lastUpdated,
  }) = _ShoppingCart;

  factory ShoppingCart.fromJson(Map<String, dynamic> json) =>
      _$ShoppingCartFromJson(json);
}

@freezed
@Mapper(domain: ShoppingCart, toDomain: true, toData: true)
sealed class ShoppingCartData with _$ShoppingCartData {
  const factory ShoppingCartData({
    @JsonKey(name: 'cart_id') required String cartId,
    @JsonKey(name: 'customer_details')
    required CustomerInfoData customerDetails,
    @JsonKey(name: 'cart_items') required List<CartItemData> cartItems,
    @JsonKey(name: 'cart_totals') required CartTotalsData cartTotals,
    @JsonKey(name: 'shipping_info') required AddressData shippingInfo,
    @JsonKey(name: 'billing_info') required AddressData billingInfo,
    @JsonKey(name: 'cart_status') required OrderStatus cartStatus,
    @JsonKey(name: 'created_timestamp') required DateTime createdTimestamp,
    @JsonKey(name: 'last_updated') required DateTime lastUpdated,
  }) = _ShoppingCartData;

  factory ShoppingCartData.fromJson(Map<String, dynamic> json) =>
      _$ShoppingCartDataFromJson(json);
}

@freezed
sealed class CartItem with _$CartItem {
  const factory CartItem({
    @JsonKey(name: 'item_id') required String itemId,
    @JsonKey(name: 'product_details') required ProductDetails productDetails,
    @JsonKey(name: 'selected_quantity') required int selectedQuantity,
    @JsonKey(name: 'item_price') required double itemPrice,
    @JsonKey(name: 'item_discount') required double? itemDiscount,
    @JsonKey(name: 'final_price') required double finalPrice,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@freezed
@Mapper(domain: CartItem, toDomain: true, toData: true)
sealed class CartItemData with _$CartItemData {
  const factory CartItemData({
    @JsonKey(name: 'item_id') required String itemId,
    @JsonKey(name: 'product_details')
    required ProductDetailsData productDetails,
    @JsonKey(name: 'selected_quantity') required int selectedQuantity,
    @JsonKey(name: 'item_price') required double itemPrice,
    @JsonKey(name: 'item_discount') required double? itemDiscount,
    @JsonKey(name: 'final_price') required double finalPrice,
  }) = _CartItemData;

  factory CartItemData.fromJson(Map<String, dynamic> json) =>
      _$CartItemDataFromJson(json);
}

@freezed
sealed class ProductDetails with _$ProductDetails {
  const factory ProductDetails({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_description') required String productDescription,
    @JsonKey(name: 'product_category') required String productCategory,
    @JsonKey(name: 'product_brand') required String productBrand,
    @JsonKey(name: 'product_image_url') required String? productImageUrl,
  }) = _ProductDetails;

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);
}

@freezed
@Mapper(domain: ProductDetails, toDomain: true, toData: true)
sealed class ProductDetailsData with _$ProductDetailsData {
  const factory ProductDetailsData({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_description') required String productDescription,
    @JsonKey(name: 'product_category') required String productCategory,
    @JsonKey(name: 'product_brand') required String productBrand,
    @JsonKey(name: 'product_image_url') required String? productImageUrl,
  }) = _ProductDetailsData;

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsDataFromJson(json);
}

@freezed
sealed class CartTotals with _$CartTotals {
  const factory CartTotals({
    @JsonKey(name: 'subtotal_amount') required double subtotalAmount,
    @JsonKey(name: 'tax_amount') required double taxAmount,
    @JsonKey(name: 'shipping_cost') required double shippingCost,
    @JsonKey(name: 'discount_amount') required double discountAmount,
    @JsonKey(name: 'final_total') required double finalTotal,
  }) = _CartTotals;

  factory CartTotals.fromJson(Map<String, dynamic> json) =>
      _$CartTotalsFromJson(json);
}

@freezed
@Mapper(domain: CartTotals, toDomain: true, toData: true)
sealed class CartTotalsData with _$CartTotalsData {
  const factory CartTotalsData({
    @JsonKey(name: 'subtotal_amount') required double subtotalAmount,
    @JsonKey(name: 'tax_amount') required double taxAmount,
    @JsonKey(name: 'shipping_cost') required double shippingCost,
    @JsonKey(name: 'discount_amount') required double discountAmount,
    @JsonKey(name: 'final_total') required double finalTotal,
  }) = _CartTotalsData;

  factory CartTotalsData.fromJson(Map<String, dynamic> json) =>
      _$CartTotalsDataFromJson(json);
}
