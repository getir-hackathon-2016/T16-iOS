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

@implementation OKHomeViewController

- (void) viewDidLoad
{
    [self.view setBackgroundColor:[UIColor flatWatermelonColor]];
    
    [[RZTransitionsManager shared] setDefaultPresentDismissAnimationController:[[RZZoomAlphaAnimationController alloc] init]];
    
    [[RZTransitionsManager shared] setAnimationController:[[RZZoomAlphaAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_Present];
    
    
    [self setTransitioningDelegate:[RZTransitionsManager shared]];
    
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"1180-align-justify-toolbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self.sideMenuViewController action:@selector(presentLeftMenuViewController)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    
    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"762-shopping-bag-toolbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(showCart)];
    
    self.navigationItem.rightBarButtonItem = cartButton;
    
    [super viewDidLoad];
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
    
    [super viewDidAppear:animated];
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

@end
