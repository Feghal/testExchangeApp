//
//  ExchangeTableViewCell.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Exchange;

@interface ExchangeTableViewCell : UITableViewCell

@property (strong, nonatomic) Exchange *exchange;
@end

NS_ASSUME_NONNULL_END
