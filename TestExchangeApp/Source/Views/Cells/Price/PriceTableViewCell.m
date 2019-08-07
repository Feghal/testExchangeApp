
//
//  PriceTableViewCell.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "PriceTableViewCell.h"

#import "CurrencyPrice.h"

@interface PriceTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel;
@end

@implementation PriceTableViewCell

- (void)setPrice:(CurrencyPrice *)price {
    self.nameLabel.text = price.currency;
    self.buyPriceLabel.text = [price.buyPrice stringValue];
    self.sellPriceLabel.text = [price.sellPrice stringValue];
}

@end
