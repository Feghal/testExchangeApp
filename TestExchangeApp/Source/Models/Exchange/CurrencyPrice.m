//
//  CurrencyPrice.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "CurrencyPrice.h"

@implementation CurrencyPrice

- (instancetype)initWithCurrency:(NSString *)currency json:(NSDictionary *)jsonData {
    self = [super init];
    if (self) {
        self.currency = currency;
        self.buyPrice = jsonData[@"buy"];
        self.sellPrice = jsonData[@"sell"];
    }
    return self;
}

@end
