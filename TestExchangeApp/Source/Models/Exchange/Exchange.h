//
//  Exchange.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CurrencyPrice;

typedef enum {
    CashTypeNo,
    CashTypeYes
} CashType;

@interface Exchange : NSObject

@property (strong, nonatomic) NSString *orgId;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSArray<CurrencyPrice *> *cashPrices;
@property (strong, nonatomic) NSArray<CurrencyPrice *> *nonCashPrices;

- (instancetype)initWithId:(NSString *)orgId
                      json:(NSDictionary *)jsonData;
@end

NS_ASSUME_NONNULL_END
