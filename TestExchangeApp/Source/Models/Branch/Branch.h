//
//  Branch.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Branch : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *contacts;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *lat;
@property (strong, nonatomic) NSNumber *lng;
@property (strong, nonatomic) NSString *workhours;
@property (nonatomic) BOOL head;

- (instancetype)initWithJson:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
