//
//  CurrencyManager.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CurrencyPrice, Exchange;

@interface CurrencyManager : NSObject

/**
 Holding current currency string value
 */
@property (strong, nonatomic) NSString *currentCurrency;

/**
 Holding the state is selected cash or noncash type
 */
@property (strong, nonatomic) NSString *cashType;

@property (strong, nonatomic) NSArray<Exchange *> *reservedExchanges;

/**
 returns CurrencyPrice related to current currency and cash/nonCash state
 */
- (CurrencyPrice *)getCurrentStatePriceFrom:(Exchange *)exchange;

/**
 Filter exchanges list with price for currency and cash type exist
 */
- (NSArray<Exchange *> *)getExchangesForState;

/**
 Get Cash or non cash prices from exchange
 */
- (NSArray<CurrencyPrice *> *)getCurrentStatePricesFrom:(Exchange *)exchange ;

- (NSArray *)getCashTypes;
- (NSArray *)getCurrencies;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
