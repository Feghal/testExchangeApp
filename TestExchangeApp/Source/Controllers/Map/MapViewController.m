//
//  MapViewController.m
//  TestExchangeApp
//
//  Created by Artur Sahakyan on 8/7/19.
//  Copyright © 2019 feghal. All rights reserved.
//

#import "MapViewController.h"

#import <MapKit/MapKit.h>
#import "Branch.h"

@interface MapViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *manager;

@property (strong, nonatomic) MKPointAnnotation *userPin;

@end

@implementation MapViewController

/*----------------------------------*/
#pragma mark - lifecycle -
/*----------------------------------*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMap];
    [self setupManagers];
    [self addMarkerTo:self.branch];
}

/*----------------------------------*/
#pragma mark - location -
/*----------------------------------*/

- (void)addMarkerTo:(Branch *)branch {
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([branch.lat doubleValue], [branch.lng doubleValue]);
    self.userPin = [MKPointAnnotation new];
    self.userPin.coordinate = loc;
    self.userPin.title = branch.title;
    [self.mapView addAnnotation:self.userPin];

}

- (void)setupMap {
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
}

- (void)setupManagers {
    self.manager = [CLLocationManager new];
    self.manager.delegate = self;
    
    if ([self isAuthorized:[CLLocationManager authorizationStatus]]) {
        [self.manager startUpdatingLocation];
    } else {
        [self.manager requestAlwaysAuthorization];
    }
}

- (BOOL)isAuthorized:(CLAuthorizationStatus)status {
    if(status == (kCLAuthorizationStatusAuthorizedAlways | kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    }
    return NO;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ([self isAuthorized:status]) {
        [self.manager startUpdatingLocation];
    } else {
        [self.manager stopUpdatingLocation];
    }
}

/*----------------------------------*/
#pragma mark - CLLocationManagerDelegate -
/*----------------------------------*/

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = locations[0];
    [self.mapView setCenterCoordinate:loc.coordinate animated:YES];
}


@end
