//
//  ExchangesManager.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Exchange;

typedef void (^ExchangesCallback) (NSArray<Exchange *> * _Nullable result, NSError * _Nullable error);

@interface ExchangesManager : NSObject

/**
 Fetch Exchanges and return with callback, nil if error exists

 @param completion error or result
 */
- (void)fetchExchangesWithRatesWithCallback:(ExchangesCallback)completion;

@end

NS_ASSUME_NONNULL_END
