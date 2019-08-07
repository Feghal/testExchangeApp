//
//  BranchesTableViewCell.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "BranchTableViewCell.h"

#import "Branch.h"

@interface BranchTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation BranchTableViewCell

- (void)setBranch:(Branch *)branch {
    _branch = branch;
    [self setupViewWithBranch:branch];
}

- (void)setupViewWithBranch:(Branch *)branch {
    self.nameLabel.text = branch.title;
    self.addressLabel.text = branch.address;
}

@end
