//
//  UIViewController+Alert.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showError:(NSError *)error {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error"
                                                                     message:error.localizedDescription
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:doneAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
