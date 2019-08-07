//
//  Branch.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "Branch.h"

@implementation Branch

- (instancetype)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.address = json[@"address"][@"en"];
        self.contacts = json[@"contacts"];
        self.title = json[@"title"][@"en"];
        self.lat = json[@"location"][@"lat"];
        self.lng = json[@"location"][@"lng"];

        NSArray *workhoursArray = json[@"workhours"];
        self.workhours = [self concatWorkhours:workhoursArray];
        
        self.head = [json[@"head"] boolValue];
    }
    return self;
}

- (NSString *)concatWorkhours:(NSArray *)workhours {
    NSMutableString *string = [NSMutableString new];
    for(NSDictionary *item in workhours) {
        NSString *sub = [NSString stringWithFormat:@"%@ %@\n", item[@"days"], item[@"hours"]];
        [string appendString:sub];
    }
    return string;
}

@end
