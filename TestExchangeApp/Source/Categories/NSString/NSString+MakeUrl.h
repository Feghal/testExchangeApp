//
//  NSString+MakeUrl.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MakeUrl)

/**
 Make and return url from Host Base url, api version and last path

 @return concated url
 */
- (NSString *)makeFullUrlFromPath;

@end

NS_ASSUME_NONNULL_END
