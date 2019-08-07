//
//  PriceTableViewCell.h
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CurrencyPrice;

@interface PriceTableViewCell : UITableViewCell

@property (strong, nonatomic) CurrencyPrice *price;

@end

NS_ASSUME_NONNULL_END
