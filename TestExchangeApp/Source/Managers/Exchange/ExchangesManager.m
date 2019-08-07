//
//  ExchangesManager.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "ExchangesManager.h"

#import "ApiHelper.h"
#import "NSString+MakeUrl.h"
#import "Exchange.h"

extern NSString * const kExchangeRatesUrlPath;

@implementation ExchangesManager

/*----------------------------------*/
#pragma mark - public methods -
/*----------------------------------*/

- (void)fetchExchangesWithRatesWithCallback:(ExchangesCallback)completion {
    NSString *url = [kExchangeRatesUrlPath makeFullUrlFromPath];
    [ApiHelper getRequestWithUrl:url
                          params:@{@"lang": @"en"}
                         headers:@{}
                      completion:^(id  _Nullable result, NSError * _Nullable error) {
                          if(!error) {
                              NSArray<Exchange *> *response = [self parseToExchangesArray:result];
                              completion(response, nil);
                          } else {
                              completion(nil, error);
                          }
                      }];
}

/*----------------------------------*/
#pragma mark - private methods -
/*----------------------------------*/

- (NSArray<Exchange *> *)parseToExchangesArray:(NSDictionary *)json {
    NSMutableArray<Exchange *> *exchanges = [NSMutableArray<Exchange *> new];
    
    for (NSString *key in json) {
        NSDictionary *subJson = json[key];
        Exchange *exchange = [[Exchange alloc] initWithId:key json:subJson];
        [exchanges addObject:exchange];
    }
    return exchanges;
}

@end
