//
//  ExchangesViewController.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "ExchangesViewController.h"

#import "ExchangeDetailViewController.h"
#import "UIViewController+Alert.h"
#import "ExchangeTableViewCell.h"
#import "ExchangesManager.h"
#import "CurrencyManager.h"
#import "Exchange.h"

NSString *const kCellReuseIdenifier = @"ExchangeTableViewCell";

@interface ExchangesViewController () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *cashButton;
@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet UIView *pickerHiddingView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) ExchangesManager *exchangeManager;

@property (strong, nonatomic) NSArray<Exchange *> *exchanges;
@property (strong, nonatomic) NSArray *pickerDataSource;
@property (strong, nonatomic) NSString *selectedItem;
@end

@implementation ExchangesViewController

/*----------------------------------*/
#pragma mark - lifecycle -
/*----------------------------------*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupManagers];
    [self fetchDataSource];
    [self updateButtonStates];
    [self initialSetupPicker];
}

/*----------------------------------*/
#pragma mark - setup -
/*----------------------------------*/

- (void)updateButtonStates {
    [self.currencyButton setTitle:[CurrencyManager sharedInstance].currentCurrency forState:UIControlStateNormal];
    [self.cashButton setTitle:[CurrencyManager sharedInstance].cashType forState:UIControlStateNormal];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self addRefreshControl];
}

- (void)addRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshTable {
    [self fetchDataSource];
}

- (void)setupManagers {
    self.exchangeManager = [ExchangesManager new];
}

- (void)initialSetupPicker {
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

/*----------------------------------*/
#pragma mark - data -
/*----------------------------------*/

- (void)fetchDataSource {
    [self.exchangeManager fetchExchangesWithRatesWithCallback:^(NSArray<Exchange *> * _Nullable result, NSError * _Nullable error) {
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
        if(!error) {
            [CurrencyManager sharedInstance].reservedExchanges = result;
            [self reloadViewWithValues];
        } else {
            [self showError:error];
        }
    }];
}

/*----------------------------------*/
#pragma mark - actions -
/*----------------------------------*/

- (IBAction)cashButtonTapped:(UIButton *)sender {
    self.pickerHiddingView.hidden = NO;
    self.pickerDataSource = [[CurrencyManager sharedInstance] getCashTypes];
    self.pickerView.tag = 999;
    [self.pickerView reloadAllComponents];
}

- (IBAction)currencyButtonTapped:(UIButton *)sender {
    self.pickerHiddingView.hidden = NO;
    self.pickerDataSource = [[CurrencyManager sharedInstance] getCurrencies];
    self.pickerView.tag = 998;
    [self.pickerView reloadAllComponents];
}

- (IBAction)pickerDoneButtonTapped:(UIButton *)sender {
    self.pickerHiddingView.hidden = YES;
    if(self.pickerView.tag == 999) {
        [CurrencyManager sharedInstance].cashType = self.selectedItem;
    } else {
        [CurrencyManager sharedInstance].currentCurrency = self.selectedItem;
    }
    [self reloadViewWithValues];
}

- (void)reloadViewWithValues {
    [self updateButtonStates];
    self.exchanges = [[CurrencyManager sharedInstance] getExchangesForState];
    [self.tableView reloadData];
}

/*----------------------------------*/
#pragma mark - tableView delegate -
/*----------------------------------*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exchanges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Exchange *exchange = self.exchanges[indexPath.row];
    
    ExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdenifier];
    cell.exchange = exchange;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Exchange *exchange = self.exchanges[indexPath.row];
    ExchangeDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ExchangeDetailViewController class])];
    vc.exchange = exchange;
    [self.navigationController pushViewController:vc animated:YES];
}

/*----------------------------------*/
#pragma mark - picker delegate -
/*----------------------------------*/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return self.pickerDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *item = self.pickerDataSource[row];
    self.selectedItem = item;
}

@end
