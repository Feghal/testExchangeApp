//
//  NSString+MakeUrl.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "NSString+MakeUrl.h"

extern NSString * const HostBase;
extern NSString * const ApiVersion;

@implementation NSString (MakeUrl)

- (NSString *)makeFullUrlFromPath {
    return [NSString stringWithFormat:@"%@%@%@", HostBase, ApiVersion, self];
}

@end
