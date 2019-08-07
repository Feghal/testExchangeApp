
//
//  ExchangeTableViewCell.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "ExchangeTableViewCell.h"

#import "CurrencyManager.h"
#import "Exchange.h"
#import "CurrencyPrice.h"

@interface ExchangeTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel;
@end

@implementation ExchangeTableViewCell

- (void)setExchange:(Exchange *)exchange {
    _exchange = exchange;
    [self setupViewWithExchange:exchange];
}

- (void)setupViewWithExchange:(Exchange *)exchange {
    self.nameLabel.text = exchange.title;
    CurrencyPrice *price = [[CurrencyManager sharedInstance] getCurrentStatePriceFrom:exchange];
    self.buyPriceLabel.text = [price.buyPrice stringValue];
    self.sellPriceLabel.text = [price.sellPrice stringValue];
}

@end
