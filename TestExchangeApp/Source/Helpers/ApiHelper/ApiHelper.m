//
//  ApiHelper.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "ApiHelper.h"

@implementation ApiHelper

/*----------------------------------*/
#pragma mark - public methods -
/*----------------------------------*/

+ (void)getRequestWithUrl:(NSString *)url
                   params:(NSDictionary *)params
                  headers:(NSDictionary *)headers
               completion:(NetworkCallback)completion {
    
    if (params) {
        url = [NSString stringWithFormat:@"%@?%@",url , [self buildQuerryStringFromDictionary:params]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    if (headers) {
        for (NSString *key in headers) {
            [request setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    request.timeoutInterval = 20;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSError* err;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&err];
                if (!err) {
                    completion(json, nil);
                } else {
                    completion(nil, err);
                }
            } else {
                completion(nil, error);
            }
        });
    }] resume];
    [session finishTasksAndInvalidate];
}

/*----------------------------------*/
#pragma mark - private methods -
/*----------------------------------*/

+ (NSString *)buildQuerryStringFromDictionary:(NSDictionary *)params {
    
    NSMutableArray *urlVals = [[NSMutableArray alloc] init];
    for (NSString *key in params) {
        NSString *value = [[NSString stringWithFormat:@"%@",params[key]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [urlVals addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    return urlVals.count == 0 ? @"" : [urlVals componentsJoinedByString:@"&"];
}

@end
