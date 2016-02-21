//
//  OKHomeViewController.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKHomeViewController.h"
#import "RZTransitions.h"
#import "Chameleon.h"
#import "OKUser.h"
#import "RESideMenu.h"
#import "OKCategoryCollectionViewCell.h"
#import "OKProductListViewController.h"
#import "OKConsulate.h"
#import "OKProductCategory.h"
#import "UIButton+Badge.h"
#import "UIBarButtonItem+Badge.h"
#import "OKCart.h"

#define TABLE_VIEW_HEIGHT self.view.frame.size.height
#define SCREEN_WIDTH self.view.frame.size.width
#define TABLE_VIEW_HEADER_HEIGHT 320.0f


@implementation OKHomeViewController

- (void) viewDidLoad
{
    self.title = NSLocalizedString(@"Want", @"Want");

    
    [self.view setBackgroundColor:[UIColor flatRedColor]];
    
    [[RZTransitionsManager shared] setDefaultPresentDismissAnimationController:[[RZZoomAlphaAnimationController alloc] init]];

    [[RZTransitionsManager shared] setAnimationController:[[RZZoomAlphaAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_Present];
    
    [self setTransitioningDelegate:[RZTransitionsManager shared]];
    
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"1180-align-justify-toolbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self.sideMenuViewController action:@selector(presentLeftMenuViewController)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    
    UIImage *image = [[UIImage imageNamed:@"762-shopping-bag-toolbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,image.size.width, image.size.height);
    [button addTarget:self.sideMenuViewController action:@selector(presentRightMenuViewController) forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = cartButton;
    self.navigationItem.rightBarButtonItem.shouldAnimateBadge = YES;
    self.navigationItem.rightBarButtonItem.shouldHideBadgeAtZero = YES;
    self.navigationItem.rightBarButtonItem.badgeValue = @"0";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.badgeTextColor = [UIColor flatRedColor];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    [OKConsulate fetchProductCategoriesWithCompletionBlock:^(BOOL succeeded, NSError *error, NSArray *result) {
        productCategories = result;
        [self.collectionView reloadData];
    }];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cartUpdated:)
                                                 name:@"kCartUpdated"
                                               object:nil];
    
}

- (void) cartUpdated:(NSNotification *) notification
{
    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)[[[OKCart currentCart] productsInCart] count]];
}


- (void) viewWillAppear:(BOOL)animated
{
    [self setupCollectionView];
    [self setupMapView];
    
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (!willPresentAuthView) {
        if (![[OKUser currentUser] userSessionToken]) {
            
            OKLoginViewController *loginView = [[OKLoginViewController alloc] init];
            
            loginView.delegate = self;
            
            [loginView setTransitioningDelegate:[RZTransitionsManager shared]];
            
            [self presentViewController:loginView animated:YES completion:^{
                
            }];
        }
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (!firstLocationUpdate_) {
        MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = self.locationManager.location.coordinate.latitude;
        region.center.longitude = self.locationManager.location.coordinate.longitude;
        region.span.longitudeDelta = 0.05f;
        region.span.longitudeDelta = 0.05f;
        [self.mapView setRegion:region animated:YES];
        
     
    
        //User location changed.
        CLGeocoder *ceo = [[CLGeocoder alloc]init];
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude]; //insert your coordinates
        
        [ceo reverseGeocodeLocation:loc
                  completionHandler:^(NSArray *placemarks, NSError *error) {
                      CLPlacemark *placemark = [placemarks objectAtIndex:0];
                      
                      locationLabel.text = [NSString stringWithFormat:@"%@, %@",placemark.name,placemark.locality];
                      /*
                      NSLog(@"placemark %@",placemark);
                      //String to hold address
                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                      NSLog(@"addressDictionary %@", placemark.addressDictionary);
                      
                      NSLog(@"placemark %@",placemark.region);
                      NSLog(@"placemark %@",placemark.country);  // Give Country Name
                      NSLog(@"placemark %@",placemark.locality); // Extract the city name
                      NSLog(@"location %@",placemark.name);
                      NSLog(@"location %@",placemark.ocean);
                      NSLog(@"location %@",placemark.postalCode);
                      NSLog(@"location %@",placemark.subLocality);
                      
                      NSLog(@"location %@",placemark.location);
                      //Print the location to console
                      NSLog(@"I am currently at %@",locatedAt);
                       */
                  }
         ];
        
        firstLocationUpdate_ = YES;
    }
}


- (void) presentSignupView
{
    willPresentAuthView = YES;
    
    [self dismissViewControllerAnimated:YES completion:^{
        //Present Signup
    }];
}

- (void) presentForgotPasswordView
{
    willPresentAuthView = YES;

    [self dismissViewControllerAnimated:YES completion:^{
        //Present Forgot
    }];
}

- (void) loginFinished
{
    willPresentAuthView = NO;

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupCollectionView{
    if (!self.collectionView) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];

        self.collectionView = [[UICollectionView alloc]  initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) collectionViewLayout:layout];
        
        [self.collectionView registerClass:[OKCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        
        [self.collectionView registerClass:[UICollectionReusableView class]
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                       withReuseIdentifier:@"HeaderView"];
        
        [self.collectionView registerClass:[UICollectionReusableView class]
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                       withReuseIdentifier:@"CategoriesView"];
        
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        
        self.collectionView.dataSource   = self;
        self.collectionView.delegate     = self;
        [self.view addSubview:self.collectionView];
        
    }
}

-(void)setupMapView{
    if (!self.mapView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABLE_VIEW_HEIGHT)];
        
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABLE_VIEW_HEADER_HEIGHT)];
        [self.mapView.layer setMasksToBounds:NO];
        [self.mapView setShowsUserLocation:YES];
        self.mapView.mapType = MKMapTypeStandard;
        self.mapView.showsPointsOfInterest = NO;
        self.mapView.tintColor = [UIColor flatMintColor];
        self.mapView.delegate = self;
        
        [view addSubview:self.mapView];
        
        //Main Button
        UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainButton setTitle:@"" forState:UIControlStateNormal];
        [mainButton setFrame:CGRectMake(5, 5, SCREEN_WIDTH - 10, 50)];
        [mainButton setBackgroundColor:[UIColor whiteColor]];
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:mainButton.bounds];
        mainButton.layer.masksToBounds = NO;
        mainButton.layer.shadowColor = [UIColor grayColor].CGColor;
        mainButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        mainButton.layer.shadowOpacity = 0.4f;
        mainButton.layer.shadowPath = shadowPath.CGPath;
        
        //Detail Disclosure button
        UITableViewCell *disclosure = [[UITableViewCell alloc] init];
        [mainButton addSubview:disclosure];
        disclosure.frame = mainButton.bounds;
        disclosure.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        disclosure.userInteractionEnabled = NO;
        
        //Add Texts
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 60, 15)];
        [headerLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]];
        [headerLabel setText:NSLocalizedString(@"DELIVERY ADDRESS", @"DELIVERY ADDRESS")];
        [headerLabel setTextColor:[UIColor flatRedColor]];
        
        locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, SCREEN_WIDTH - 60, 20)];
        [locationLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightLight]];
        [locationLabel setText:NSLocalizedString(@"Locating your address", @"Locating your address")];
        [locationLabel setTextColor:[UIColor flatRedColor]];
        
        [mainButton addSubview:headerLabel];
        [mainButton addSubview:locationLabel];
        
        [view addSubview:mainButton];
        
        [self.collectionView setBackgroundView:view];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    [self animationForScroll:offset];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGFloat offset = self.collectionView.contentOffset.y;
    [self animationForScroll:offset];
}


- (void) animationForScroll:(CGFloat) offset {
    
    CATransform3D headerTransform = CATransform3DIdentity;
    
    // DOWN -----------------
    
    if (offset < 0) {
        
        CGFloat headerScaleFactor = -(offset) / self.mapView.bounds.size.height;
        CGFloat headerSizevariation = ((self.mapView.bounds.size.height * (1.0 + headerScaleFactor)) - self.mapView.bounds.size.height)/2.0;
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0);
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);
        self.mapView.layer.transform = headerTransform;
        
        
    }else{
        self.mapView.layer.transform = CATransform3DIdentity;
        
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return productCategories.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OKCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    OKProductCategory *category = [productCategories objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:category.categoryImageURL];
    cell.titleLabel.text = category.categoryName;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableview = nil;
    
    if (indexPath.section == 0) {
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [reusableview setUserInteractionEnabled:NO];
        
    }else if (indexPath.section == 1) {
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CategoriesView" forIndexPath:indexPath];
        
        [reusableview setBackgroundColor:[UIColor whiteColor]];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, reusableview.frame.size.height - .4f, reusableview.frame.size.width, .4f);
        bottomBorder.backgroundColor = [UIColor flatRedColor].CGColor;
        [reusableview.layer addSublayer:bottomBorder];
        
        UILabel *categoriesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
        [categoriesLabel setTextColor:[UIColor flatRedColor]];
        [categoriesLabel setText:NSLocalizedString(@"Categories", @"Categories")];
        [categoriesLabel setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
        
        [reusableview addSubview:categoriesLabel];
        
        UILabel *estimatedDeliveryTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 0, 80, 40)];
        [estimatedDeliveryTimeLabel setTextAlignment:NSTextAlignmentRight];
        [estimatedDeliveryTimeLabel setTextColor:[UIColor flatRedColor]];
        [estimatedDeliveryTimeLabel setText:@"9mn"];
        [estimatedDeliveryTimeLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
        
        [reusableview addSubview:estimatedDeliveryTimeLabel];
    }
    
    
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, TABLE_VIEW_HEADER_HEIGHT);
    }else {
        return CGSizeMake(self.view.frame.size.width, 40);
    }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width/3 - 0.4, self.view.bounds.size.width/3 - 0.4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.2f,0.2f,0.2f,0.2f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.2;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OKProductListViewController *productList = [[OKProductListViewController alloc] init];
    OKProductCategory *category = [productCategories objectAtIndex:indexPath.row];
    productList.categoryId = category.categoryId;
    productList.title = category.categoryName;

    [self.navigationController pushViewController:productList animated:YES];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    for (aV in views) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.45];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [aV setAlpha:1];
        [UIView commitAnimations];
        
    }
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
