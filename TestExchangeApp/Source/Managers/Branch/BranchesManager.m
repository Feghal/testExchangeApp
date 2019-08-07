//
//  BranchesManager.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "BranchesManager.h"

#import "ApiHelper.h"
#import "NSString+MakeUrl.h"
#import "Branch.h"

extern NSString * const kBranchesUrlPath;

@implementation BranchesManager

- (void)fetchBranchesForOrgId:(NSString *)orgId withCallback:(BranchesCallback)completion {
    NSString *url = [kBranchesUrlPath makeFullUrlFromPath];
    [ApiHelper getRequestWithUrl:url
                          params:@{@"id": orgId}
                         headers:@{}
                      completion:^(id  _Nullable result, NSError * _Nullable error) {
                          if(!error) {
                              NSArray<Branch *> *response = [self parseToBranchesArray:result];
                              completion(response, nil);
                          } else {
                              completion(nil, error);
                          }
                      }];
}

- (NSArray<Branch *> *)parseToBranchesArray:(NSDictionary *)json {
    NSMutableArray<Branch *> *branches = [NSMutableArray<Branch *> new];
    
    NSDictionary *list = json[@"list"];
    for(NSString *key in list) {
        NSDictionary *item = list[key];
        Branch *branch = [[Branch alloc] initWithJson:item];
        if(branch.head) {
            [branches insertObject:branch atIndex:0];
        } else {
            [branches addObject:branch];
        }
    }
    return branches;
}


@end
