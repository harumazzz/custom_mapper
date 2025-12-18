import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
import 'json_models.dart'; // Import from different file

part 'json_cross_file_test.freezed.dart';
part 'json_cross_file_test.g.dart';
part 'json_cross_file_test.map.dart';

/// Test case 1: Cross-file mapping with JSON annotations
@freezed
sealed class OrderRequest with _$OrderRequest {
  const factory OrderRequest({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'customer_info') required CustomerInfo customerInfo,
    @JsonKey(name: 'order_items') required List<OrderItem> orderItems,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'shipping_address') required Address shippingAddress,
  }) = _OrderRequest;

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);
}

/// Test case 2: Data class that maps to domain class from different file
@freezed
@Mapper(domain: OrderRequest, toDomain: true, toData: true)
sealed class OrderRequestData with _$OrderRequestData {
  const factory OrderRequestData({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'customer_info') required CustomerInfoData customerInfo,
    @JsonKey(name: 'order_items') required List<OrderItemData> orderItems,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'shipping_address') required AddressData shippingAddress,
  }) = _OrderRequestData;

  factory OrderRequestData.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestDataFromJson(json);
}

/// Test case 3: Complex nested mapping with different JSON keys
@freezed
sealed class PaymentResponse with _$PaymentResponse {
  const factory PaymentResponse({
    @JsonKey(name: 'payment_id') required String paymentId,
    @JsonKey(name: 'transaction_details')
    required TransactionDetails transactionDetails,
    @JsonKey(name: 'payment_method') required PaymentMethod paymentMethod,
    @JsonKey(name: 'status_info') required PaymentStatusInfo statusInfo,
    @JsonKey(name: 'processed_at') required DateTime processedAt,
  }) = _PaymentResponse;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);
}

@freezed
@Mapper(domain: PaymentResponse, toDomain: true, toData: true)
sealed class PaymentResponseData with _$PaymentResponseData {
  const factory PaymentResponseData({
    @JsonKey(name: 'payment_id') required String paymentId,
    @JsonKey(name: 'transaction_details')
    required TransactionDetailsData transactionDetails,
    @JsonKey(name: 'payment_method') required PaymentMethodData paymentMethod,
    @JsonKey(name: 'status_info') required PaymentStatusInfoData statusInfo,
    @JsonKey(name: 'processed_at') required DateTime processedAt,
  }) = _PaymentResponseData;

  factory PaymentResponseData.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseDataFromJson(json);
}

/// Test case 4: Enum with JSON values
@JsonEnum(valueField: 'value')
enum OrderStatus {
  pending('PENDING'),
  processing('PROCESSING'),
  shipped('SHIPPED'),
  delivered('DELIVERED'),
  cancelled('CANCELLED');

  const OrderStatus(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum PaymentStatus {
  pending('payment_pending'),
  authorized('payment_authorized'),
  captured('payment_captured'),
  failed('payment_failed'),
  refunded('payment_refunded');

  const PaymentStatus(this.value);
  final String value;
}
