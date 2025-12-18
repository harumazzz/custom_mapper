import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'json_models.freezed.dart';
part 'json_models.g.dart';
part 'json_models.mapper.dart';

/// Base models that will be referenced from other files

@freezed
sealed class CustomerInfo with _$CustomerInfo {
  const factory CustomerInfo({
    @JsonKey(name: 'customer_id') required String customerId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'email_address') required String emailAddress,
    @JsonKey(name: 'phone_number') required String? phoneNumber,
  }) = _CustomerInfo;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);
}

@freezed
@Mapper(domain: CustomerInfo, toDomain: true, toData: true)
sealed class CustomerInfoData with _$CustomerInfoData {
  const factory CustomerInfoData({
    @JsonKey(name: 'customer_id') required String customerId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'email_address') required String emailAddress,
    @JsonKey(name: 'phone_number') required String? phoneNumber,
  }) = _CustomerInfoData;

  factory CustomerInfoData.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoDataFromJson(json);
}

@freezed
sealed class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(name: 'item_id') required String itemId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'quantity_ordered') required int quantityOrdered,
    @JsonKey(name: 'item_total') required double itemTotal,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

@freezed
@Mapper(domain: OrderItem, toDomain: true, toData: true)
sealed class OrderItemData with _$OrderItemData {
  const factory OrderItemData({
    @JsonKey(name: 'item_id') required String itemId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'quantity_ordered') required int quantityOrdered,
    @JsonKey(name: 'item_total') required double itemTotal,
  }) = _OrderItemData;

  factory OrderItemData.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDataFromJson(json);
}

@freezed
sealed class Address with _$Address {
  const factory Address({
    @JsonKey(name: 'street_address') required String streetAddress,
    @JsonKey(name: 'apartment_unit') required String? apartmentUnit,
    @JsonKey(name: 'city_name') required String cityName,
    @JsonKey(name: 'state_province') required String stateProvince,
    @JsonKey(name: 'postal_code') required String postalCode,
    @JsonKey(name: 'country_code') required String countryCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
@Mapper(domain: Address, toDomain: true, toData: true)
sealed class AddressData with _$AddressData {
  const factory AddressData({
    @JsonKey(name: 'street_address') required String streetAddress,
    @JsonKey(name: 'apartment_unit') required String? apartmentUnit,
    @JsonKey(name: 'city_name') required String cityName,
    @JsonKey(name: 'state_province') required String stateProvince,
    @JsonKey(name: 'postal_code') required String postalCode,
    @JsonKey(name: 'country_code') required String countryCode,
  }) = _AddressData;

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);
}

@freezed
sealed class TransactionDetails with _$TransactionDetails {
  const factory TransactionDetails({
    @JsonKey(name: 'transaction_id') required String transactionId,
    @JsonKey(name: 'amount_charged') required double amountCharged,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'gateway_reference') required String gatewayReference,
  }) = _TransactionDetails;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);
}

@freezed
@Mapper(domain: TransactionDetails, toDomain: true, toData: true)
sealed class TransactionDetailsData with _$TransactionDetailsData {
  const factory TransactionDetailsData({
    @JsonKey(name: 'transaction_id') required String transactionId,
    @JsonKey(name: 'amount_charged') required double amountCharged,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'gateway_reference') required String gatewayReference,
  }) = _TransactionDetailsData;

  factory TransactionDetailsData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsDataFromJson(json);
}

@freezed
sealed class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    @JsonKey(name: 'method_type') required String methodType,
    @JsonKey(name: 'card_last_four') required String? cardLastFour,
    @JsonKey(name: 'card_brand') required String? cardBrand,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

@freezed
@Mapper(domain: PaymentMethod, toDomain: true, toData: true)
sealed class PaymentMethodData with _$PaymentMethodData {
  const factory PaymentMethodData({
    @JsonKey(name: 'method_type') required String methodType,
    @JsonKey(name: 'card_last_four') required String? cardLastFour,
    @JsonKey(name: 'card_brand') required String? cardBrand,
  }) = _PaymentMethodData;

  factory PaymentMethodData.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDataFromJson(json);
}

@freezed
sealed class PaymentStatusInfo with _$PaymentStatusInfo {
  const factory PaymentStatusInfo({
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'status_message') required String statusMessage,
    @JsonKey(name: 'is_successful') required bool isSuccessful,
  }) = _PaymentStatusInfo;

  factory PaymentStatusInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusInfoFromJson(json);
}

@freezed
@Mapper(domain: PaymentStatusInfo, toDomain: true, toData: true)
sealed class PaymentStatusInfoData with _$PaymentStatusInfoData {
  const factory PaymentStatusInfoData({
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'status_message') required String statusMessage,
    @JsonKey(name: 'is_successful') required bool isSuccessful,
  }) = _PaymentStatusInfoData;

  factory PaymentStatusInfoData.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusInfoDataFromJson(json);
}
