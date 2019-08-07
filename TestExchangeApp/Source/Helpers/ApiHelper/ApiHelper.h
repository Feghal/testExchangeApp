//
//  ApiHelper.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NetworkCallback) (id _Nullable result, NSError * _Nullable error);

@interface ApiHelper : NSObject


/**
 Perform GET request and return with callback error OR result
 @warning callback is always in main thread
 
 @param url Stringified url of request
 @param params Url parameters
 @param headers header fields, default is set - Content-Type: application/json
 @param completion handler of request
 */
+ (void)getRequestWithUrl:(NSString *)url
                   params:(NSDictionary *)params
                  headers:(NSDictionary *)headers
               completion:(NetworkCallback)completion;

@end

NS_ASSUME_NONNULL_END
