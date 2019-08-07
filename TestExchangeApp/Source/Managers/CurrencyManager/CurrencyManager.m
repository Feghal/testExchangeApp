//
//  CurrencyManager.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "CurrencyManager.h"

#import "CurrencyPrice.h"
#import "Exchange.h"

@interface CurrencyManager()

@end

@implementation CurrencyManager

/*----------------------------------*/
#pragma mark - lifecycle -
/*----------------------------------*/

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentCurrency = @"USD";
        self.cashType = @"Cash";
    }
    return self;
}

/*----------------------------------*/
#pragma mark - public methods -
/*----------------------------------*/

- (NSArray<Exchange *> *)getExchangesForState {
    NSMutableArray<Exchange *> *array = [NSMutableArray<Exchange *> new];
    
    for(Exchange *exchange in self.reservedExchanges) {
        CurrencyPrice *price = [self getCurrentStatePriceFrom:exchange];
        if(price) {
            [array addObject:exchange];
        }
    }
    return array;
}

- (CurrencyPrice *)getCurrentStatePriceFrom:(Exchange *)exchange {
    if([self.cashType isEqualToString:@"Cash"]) {
        return [self getCurrencyPriceFrom:exchange.cashPrices];
    } else {
        return [self getCurrencyPriceFrom:exchange.nonCashPrices];
    }
}

- (NSArray<CurrencyPrice *> *)getCurrentStatePricesFrom:(Exchange *)exchange {
    if([self.cashType isEqualToString:@"Cash"]) {
        return [self getNonNullPriceFrom:exchange.cashPrices];
    } else {
        return [self getNonNullPriceFrom:exchange.nonCashPrices];
    }
}

- (NSArray *)getCashTypes {
    return @[@"Cash", @"Non Cash"];
}

- (NSArray *)getCurrencies {
    return @[@"USD", @"EUR", @"RUR", @"GEL", @"GBP", @"AUD", @"CAD", @"CHF", @"JPY", @"XAU"];
}

/*----------------------------------*/
#pragma mark - private methods -
/*----------------------------------*/

- (CurrencyPrice *)getCurrencyPriceFrom:(NSArray<CurrencyPrice *> *)prices {
    for (CurrencyPrice *price in prices) {
        if([price.currency isEqualToString:self.currentCurrency]) {
            if(price.buyPrice && price.sellPrice) {
                return price;
            }
        }
    }
    return nil;
}

- (NSArray<CurrencyPrice *> *)getNonNullPriceFrom:(NSArray<CurrencyPrice *> *)prices {
    NSMutableArray<CurrencyPrice *> *actualPrices = [NSMutableArray<CurrencyPrice *> new];
    
    for (CurrencyPrice *price in prices) {
        if(price.buyPrice && price.sellPrice) {
             [actualPrices addObject:price];
        }
    }
    return actualPrices;
}

@end
