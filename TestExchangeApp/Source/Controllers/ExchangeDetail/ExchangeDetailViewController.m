//
//  ExchangeDetailViewController.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "ExchangeDetailViewController.h"

#import "CurrencyManager.h"
#import "BranchesManager.h"
#import "Exchange.h"
#import "Branch.h"
#import "UIViewController+Alert.h"
#import "PriceTableViewCell.h"
#import "BranchTableViewCell.h"
#import "MapViewController.h"

NSString *const kPriceCellReuseIdenifier = @"PriceTableViewCell";
NSString *const kBranchCellReuseIdenifier = @"BranchTableViewCell";

@interface ExchangeDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *workingDaysLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *seeOnMapButton;

@property (strong, nonatomic) BranchesManager *branchesManager;

@property (strong, nonatomic) NSArray *prices;
@property (strong, nonatomic) NSArray *branches;

@property (strong, nonatomic) Branch *currentSelectedBranch;

@end

@implementation ExchangeDetailViewController

/*----------------------------------*/
#pragma mark - lifecycle -
/*----------------------------------*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupManagers];
    [self setupTableView];
    [self getPrices];
    [self fetchBranches];
    [self setupSegmentControl];
}

/*----------------------------------*/
#pragma mark - setup -
/*----------------------------------*/

- (void)setupSegmentControl {
    if([[CurrencyManager sharedInstance].cashType isEqualToString:@"Cash"]) {
        self.segmentControl.selectedSegmentIndex = 0;
    } else {
        self.segmentControl.selectedSegmentIndex = 1;
    }
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupManagers {
    self.branchesManager = [BranchesManager new];
}

- (void)setupViewWithBranch:(Branch *)branch {
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.exchange.title, branch.title];
    self.addressLabel.text = branch.address;
    self.phoneLabel.text = branch.contacts;
    self.workingDaysLabel.text = branch.workhours;
    
    self.currentSelectedBranch = branch;
}

/*----------------------------------*/
#pragma mark - data -
/*----------------------------------*/

- (void)getPrices {
    self.prices = [[CurrencyManager sharedInstance] getCurrentStatePricesFrom:self.exchange];
    [self.tableView reloadData];
}

- (void)fetchBranches {
    [self.indicator startAnimating];
    self.seeOnMapButton.enabled = NO;
    [self.branchesManager fetchBranchesForOrgId:self.exchange.orgId
                                   withCallback:^(NSArray<Branch *> * _Nullable result, NSError * _Nullable error) {
                                       self.seeOnMapButton.enabled = YES;
                                       [self.indicator stopAnimating];
                                       if(!error) {
                                           self.branches = result;
                                           [self.tableView reloadData];
                                           if(result.count > 0) {
                                               [self setupViewWithBranch:result[0]];
                                           }
                                       } else {
                                           [self showError:error];
                                       }
                                   }];
}

/*----------------------------------*/
#pragma mark - actions -
/*----------------------------------*/

- (IBAction)cashSegmentValueChanged:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0) {
        [CurrencyManager sharedInstance].cashType = @"Cash";
    } else {
        [CurrencyManager sharedInstance].cashType = @"Non Cash";
    }
    [self getPrices];
}

- (IBAction)seeOnMapTapped:(UIButton *)sender {
    MapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MapViewController class])];
    vc.branch = self.currentSelectedBranch;
    [self.navigationController pushViewController:vc animated:YES];
}

/*----------------------------------*/
#pragma mark - tableView delegate -
/*----------------------------------*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return @"Branches";
    }
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return self.prices.count;
    }
    return self.branches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        CurrencyPrice *price = self.prices[indexPath.row];
        
        PriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPriceCellReuseIdenifier];
        cell.price = price;
        return cell;
    }
    Branch *branch = self.branches[indexPath.row];
    
    BranchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBranchCellReuseIdenifier];
    cell.branch = branch;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        Branch *branch = self.branches[indexPath.row];

        [self setupViewWithBranch:branch];
    }
}

@end
