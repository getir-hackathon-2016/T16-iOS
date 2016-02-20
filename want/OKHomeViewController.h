//
//  OKHomeViewController.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKLoginViewController.h"

@import MapKit;

@interface OKHomeViewController : UIViewController <OKLoginViewControllerDelegate,MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource,UICollectionViewDelegate>
{
    BOOL willPresentAuthView;
    BOOL firstLocationUpdate_;
    CLLocationCoordinate2D storedLocation;
    NSMutableArray *productCategories;
}


@property(nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MKMapView *mapView;

@end
