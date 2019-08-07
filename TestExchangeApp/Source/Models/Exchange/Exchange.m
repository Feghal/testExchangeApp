//
//  Exchange.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "Exchange.h"

#import "CurrencyPrice.h"

@implementation Exchange

- (instancetype)initWithId:(NSString *)orgId json:(NSDictionary *)jsonData {
    self = [super init];
    if (self) {
        self.orgId = orgId;
        self.title = jsonData[@"title"];
        
        self.cashPrices = [self getPricesByType:CashTypeYes from:jsonData];
        self.nonCashPrices = [self getPricesByType:CashTypeNo from:jsonData];
    }
    return self;
}

/*----------------------------------*/
#pragma mark - private methods -
/*----------------------------------*/

- (NSArray<CurrencyPrice *> *)getPricesByType:(CashType)type from:(NSDictionary *)jsonData {
    NSMutableArray<CurrencyPrice *> *pricesArray = [NSMutableArray<CurrencyPrice *> new];
    
    NSDictionary *list = jsonData[@"list"];
    for (NSString *currency in list) {
        NSDictionary *prices = list[currency];
        CurrencyPrice *price = [self getExchangePricesForType:[self stringFromCashType:type] currency:currency from:prices];
        [pricesArray addObject:price];
    }
    return pricesArray;
}

- (CurrencyPrice *)getExchangePricesForType:(NSString *)type
                                   currency:(NSString *)currency
                                       from:(NSDictionary *)json {
    NSDictionary *subJson = json[type];
    CurrencyPrice *price = [[CurrencyPrice alloc] initWithCurrency:currency json:subJson];
    return price;
}

- (NSString *)stringFromCashType:(CashType)cashType {
    switch (cashType) {
            case CashTypeNo:
            return @"0";
        default:
            return @"1";
    }
}

@end
