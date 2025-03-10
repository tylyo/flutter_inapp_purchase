enum ResponseCodeAndroid {
  BILLING_RESPONSE_RESULT_OK,
  BILLING_RESPONSE_RESULT_USER_CANCELED,
  BILLING_RESPONSE_RESULT_SERVICE_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_DEVELOPER_ERROR,
  BILLING_RESPONSE_RESULT_ERROR,
  BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED,
  BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED,
  UNKNOWN,
}

/// An item available for purchase from either the `Google Play Store` or `iOS AppStore`
class IAPItem {
  final String? productId;
  final String? price;
  final String? currency;
  final String? localizedPrice;
  final String? title;
  final String? description;
  final String? introductoryPrice;

  /// ios only
  final String? subscriptionPeriodNumberIOS;
  final String? subscriptionPeriodUnitIOS;
  final String? introductoryPriceNumberIOS;
  final String? introductoryPricePaymentModeIOS;
  final String? introductoryPriceNumberOfPeriodsIOS;
  final String? introductoryPriceSubscriptionPeriodIOS;
  final List<DiscountIOS>? discountsIOS;

  /// android only
  final String? subscriptionPeriodAndroid;
  final int? introductoryPriceCyclesAndroid;
  final String? introductoryPricePeriodAndroid;
  final String? freeTrialPeriodAndroid;
  final String? signatureAndroid;

  final String? iconUrl;
  final String? originalJson;
  final String originalPrice;

  /// Create [IAPItem] from a Map that was previously JSON formatted
  IAPItem.fromJSON(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        price = json['price'] as String?,
        currency = json['currency'] as String?,
        localizedPrice = json['localizedPrice'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        introductoryPrice = json['introductoryPrice'] as String?,
        introductoryPricePaymentModeIOS =
            json['introductoryPricePaymentModeIOS'] as String?,
        introductoryPriceNumberOfPeriodsIOS =
            json['introductoryPriceNumberOfPeriodsIOS'] as String?,
        introductoryPriceSubscriptionPeriodIOS =
            json['introductoryPriceSubscriptionPeriodIOS'] as String?,
        introductoryPriceNumberIOS =
            json['introductoryPriceNumberIOS'] as String?,
        subscriptionPeriodNumberIOS =
            json['subscriptionPeriodNumberIOS'] as String?,
        subscriptionPeriodUnitIOS =
            json['subscriptionPeriodUnitIOS'] as String?,
        subscriptionPeriodAndroid =
            json['subscriptionPeriodAndroid'] as String?,
        introductoryPriceCyclesAndroid =
            json['introductoryPriceCyclesAndroid'] as int?,
        introductoryPricePeriodAndroid =
            json['introductoryPricePeriodAndroid'] as String?,
        freeTrialPeriodAndroid = json['freeTrialPeriodAndroid'] as String?,
        signatureAndroid = json['signatureAndroid'] as String?,
        iconUrl = json['iconUrl'] as String?,
        originalJson = json['originalJson'] as String?,
        originalPrice = json['originalPrice'].toString(),
        discountsIOS = _extractDiscountIOS(json['discounts']);

  /// wow, i find if i want to save a IAPItem, there is not "toJson" to cast it into String...
  /// i'm sorry to see that... so,
  ///
  /// you can cast a IAPItem to json(Map<String, dynamic>) via invoke this method.
  /// for example:
  /// String str =  convert.jsonEncode(item)
  ///
  /// and then get IAPItem from "str" above
  /// IAPItem item = IAPItem.fromJSON(convert.jsonDecode(str));
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['localizedPrice'] = this.localizedPrice;
    data['title'] = this.title;
    data['description'] = this.description;
    data['introductoryPrice'] = this.introductoryPrice;

    data['subscriptionPeriodNumberIOS'] = this.subscriptionPeriodNumberIOS;
    data['subscriptionPeriodUnitIOS'] = this.subscriptionPeriodUnitIOS;
    data['introductoryPricePaymentModeIOS'] =
        this.introductoryPricePaymentModeIOS;
    data['introductoryPriceNumberOfPeriodsIOS'] =
        this.introductoryPriceNumberOfPeriodsIOS;
    data['introductoryPriceSubscriptionPeriodIOS'] =
        this.introductoryPriceSubscriptionPeriodIOS;

    data['subscriptionPeriodAndroid'] = this.subscriptionPeriodAndroid;
    data['introductoryPriceCyclesAndroid'] =
        this.introductoryPriceCyclesAndroid;
    data['introductoryPricePeriodAndroid'] =
        this.introductoryPricePeriodAndroid;
    data['freeTrialPeriodAndroid'] = this.freeTrialPeriodAndroid;
    data['signatureAndroid'] = this.signatureAndroid;

    data['iconUrl'] = this.iconUrl;
    data['originalJson'] = this.originalJson;
    data['originalPrice'] = this.originalPrice;
    data['discounts'] = this.discountsIOS;
    return data;
  }

  /// Return the contents of this class as a string
  @override
  String toString() {
    return 'productId: $productId, '
        'price: $price, '
        'currency: $currency, '
        'localizedPrice: $localizedPrice, '
        'title: $title, '
        'description: $description, '
        'introductoryPrice: $introductoryPrice, '
        'introductoryPricePaymentModeIOS: $introductoryPrice, '
        'subscriptionPeriodNumberIOS: $subscriptionPeriodNumberIOS, '
        'subscriptionPeriodUnitIOS: $subscriptionPeriodUnitIOS, '
        'introductoryPricePaymentModeIOS: $introductoryPricePaymentModeIOS, '
        'introductoryPriceNumberOfPeriodsIOS: $introductoryPriceNumberOfPeriodsIOS, '
        'introductoryPriceSubscriptionPeriodIOS: $introductoryPriceSubscriptionPeriodIOS, '
        'subscriptionPeriodAndroid: $subscriptionPeriodAndroid, '
        'introductoryPriceCyclesAndroid: $introductoryPriceCyclesAndroid, '
        'introductoryPricePeriodAndroid: $introductoryPricePeriodAndroid, '
        'freeTrialPeriodAndroid: $freeTrialPeriodAndroid, '
        'iconUrl: $iconUrl, '
        'originalJson: $originalJson, '
        'originalPrice: $originalPrice, '
        'discounts: $discountsIOS, ';
  }

  static List<DiscountIOS>? _extractDiscountIOS(dynamic json) {
    List? list = json as List?;
    List<DiscountIOS>? discounts;

    if (list != null) {
      discounts = list
          .map<DiscountIOS>(
            (dynamic discount) =>
                DiscountIOS.fromJSON(discount as Map<String, dynamic>),
          )
          .toList();
    }

    return discounts;
  }
}

class DiscountIOS {
  String? identifier;
  String? type;
  String? numberOfPeriods;
  double? price;
  String? localizedPrice;
  String? paymentMode;
  String? subscriptionPeriod;

  /// Create [DiscountIOS] from a Map that was previously JSON formatted
  DiscountIOS.fromJSON(Map<String, dynamic> json)
      : identifier = json['identifier'] as String?,
        type = json['type'] as String?,
        numberOfPeriods = json['numberOfPeriods'] as String?,
        price = json['price'] as double?,
        localizedPrice = json['localizedPrice'] as String?,
        paymentMode = json['paymentMode'] as String?,
        subscriptionPeriod = json['subscriptionPeriod'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['type'] = this.type;
    data['numberOfPeriods'] = this.numberOfPeriods;
    data['price'] = this.price;
    data['localizedPrice'] = this.localizedPrice;
    data['paymentMode'] = this.paymentMode;
    data['subscriptionPeriod'] = this.subscriptionPeriod;
    return data;
  }

  /// Return the contents of this class as a string
  @override
  String toString() {
    return 'identifier: $identifier, '
        'type: $type, '
        'numberOfPeriods: $numberOfPeriods, '
        'price: $price, '
        'localizedPrice: $localizedPrice, '
        'paymentMode: $paymentMode, '
        'subscriptionPeriod: $subscriptionPeriod, ';
  }
}

/// An item which was purchased from either the `Google Play Store` or `iOS AppStore`
class PurchasedItem {
  final String? productId;
  final String? transactionId;
  final DateTime? transactionDate;
  final String? transactionReceipt;
  final String? purchaseToken;
  final String? orderId;

  // Android only
  final String? dataAndroid;
  final String? signatureAndroid;
  final bool? autoRenewingAndroid;
  final bool? isAcknowledgedAndroid;
  final PurchaseState? purchaseStateAndroid;
  final String? originalJsonAndroid;

  // iOS only
  final DateTime? originalTransactionDateIOS;
  final String? originalTransactionIdentifierIOS;
  final TransactionState? transactionStateIOS;

  /// Create [PurchasedItem] from a Map that was previously JSON formatted
  PurchasedItem.fromJSON(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        transactionId = json['transactionId'] as String?,
        transactionDate = _extractDate(json['transactionDate']),
        transactionReceipt = json['transactionReceipt'] as String?,
        purchaseToken = json['purchaseToken'] as String?,
        orderId = json['orderId'] as String?,
        dataAndroid = json['dataAndroid'] as String?,
        signatureAndroid = json['signatureAndroid'] as String?,
        isAcknowledgedAndroid = json['isAcknowledgedAndroid'] as bool?,
        autoRenewingAndroid = json['autoRenewingAndroid'] as bool?,
        purchaseStateAndroid =
            _decodePurchaseStateAndroid(json['purchaseStateAndroid'] as int?),
        originalJsonAndroid = json['originalJsonAndroid'] as String?,
        originalTransactionDateIOS =
            _extractDate(json['originalTransactionDateIOS']),
        originalTransactionIdentifierIOS =
            json['originalTransactionIdentifierIOS'] as String?,
        transactionStateIOS =
            _decodeTransactionStateIOS(json['transactionStateIOS'] as int?);

  /// This returns transaction dates in ISO 8601 format.
  @override
  String toString() {
    return 'productId: $productId, '
        'transactionId: $transactionId, '
        'transactionDate: ${transactionDate?.toIso8601String()}, '
        'transactionReceipt: $transactionReceipt, '
        'purchaseToken: $purchaseToken, '
        'orderId: $orderId, '

        /// android specific
        'dataAndroid: $dataAndroid, '
        'signatureAndroid: $signatureAndroid, '
        'isAcknowledgedAndroid: $isAcknowledgedAndroid, '
        'autoRenewingAndroid: $autoRenewingAndroid, '
        'purchaseStateAndroid: $purchaseStateAndroid, '
        'originalJsonAndroid: $originalJsonAndroid, '

        /// ios specific
        'originalTransactionDateIOS: ${originalTransactionDateIOS?.toIso8601String()}, '
        'originalTransactionIdentifierIOS: $originalTransactionIdentifierIOS, '
        'transactionStateIOS: $transactionStateIOS';
  }

  /// Coerce miliseconds since epoch in double, int, or String into DateTime format
  static DateTime? _extractDate(dynamic timestamp) {
    if (timestamp == null) return null;

    int _toInt() => double.parse(timestamp.toString()).toInt();
    return DateTime.fromMillisecondsSinceEpoch(_toInt());
  }
}

class PurchaseResult {
  final int? responseCode;
  final String? debugMessage;
  final String? code;
  final String? message;

  PurchaseResult({
    this.responseCode,
    this.debugMessage,
    this.code,
    this.message,
  });

  PurchaseResult.fromJSON(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as int?,
        debugMessage = json['debugMessage'] as String?,
        code = json['code'] as String?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode ?? 0,
        "debugMessage": debugMessage ?? '',
        "code": code ?? '',
        "message": message ?? '',
      };

  @override
  String toString() {
    return 'responseCode: $responseCode, '
        'debugMessage: $debugMessage, '
        'code: $code, '
        'message: $message';
  }
}

class ConnectionResult {
  final bool? connected;

  ConnectionResult({
    this.connected,
  });

  ConnectionResult.fromJSON(Map<String, dynamic> json)
      : connected = json['connected'] as bool?;

  Map<String, dynamic> toJson() => {
        "connected": connected ?? false,
      };

  @override
  String toString() {
    return 'connected: $connected';
  }
}

/// See also https://developer.apple.com/documentation/storekit/skpaymenttransactionstate
enum TransactionState {
  /// A transaction that is being processed by the App Store.
  purchasing,

  /// A successfully processed transaction.
  purchased,

  /// A failed transaction.
  failed,

  /// A transaction that restores content previously purchased by the user.
  restored,

  /// A transaction that is in the queue, but its final status is pending external action such as Ask to Buy.
  deferred,
}

TransactionState? _decodeTransactionStateIOS(int? rawValue) {
  switch (rawValue) {
    case 0:
      return TransactionState.purchasing;
    case 1:
      return TransactionState.purchased;
    case 2:
      return TransactionState.failed;
    case 3:
      return TransactionState.restored;
    case 4:
      return TransactionState.deferred;
    default:
      return null;
  }
}

/// See also https://developer.android.com/reference/com/android/billingclient/api/Purchase.PurchaseState
enum PurchaseState {
  pending,

  purchased,

  unspecified,
}

PurchaseState? _decodePurchaseStateAndroid(int? rawValue) {
  switch (rawValue) {
    case 0:
      return PurchaseState.unspecified;
    case 1:
      return PurchaseState.purchased;
    case 2:
      return PurchaseState.pending;
    default:
      return null;
  }
}
