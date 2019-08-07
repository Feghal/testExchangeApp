//
//  CurrencyPrice.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyPrice : NSObject

@property (strong, nonatomic) NSNumber *buyPrice;
@property (strong, nonatomic) NSNumber *sellPrice;
@property (strong, nonatomic) NSString *currency;

- (instancetype)initWithCurrency:(NSString *)currency
                            json:(NSDictionary *)jsonData;
@end

NS_ASSUME_NONNULL_END
