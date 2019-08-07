//
//  BranchesManager.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Branch;

typedef void (^BranchesCallback) (NSArray<Branch *> * _Nullable result, NSError * _Nullable error);

@interface BranchesManager : NSObject

/**
 Fetch All branch of organization
 */
- (void)fetchBranchesForOrgId:(NSString *)orgId withCallback:(BranchesCallback)completion;

@end

NS_ASSUME_NONNULL_END
