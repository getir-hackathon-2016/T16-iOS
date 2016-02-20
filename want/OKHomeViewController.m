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

@implementation OKHomeViewController

- (void) viewDidLoad
{
    [self.view setBackgroundColor:[UIColor flatWatermelonColor]];
    
    [[RZTransitionsManager shared] setDefaultPresentDismissAnimationController:[[RZZoomAlphaAnimationController alloc] init]];
    
    [[RZTransitionsManager shared] setAnimationController:[[RZZoomAlphaAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_Present];
    
    
    [self setTransitioningDelegate:[RZTransitionsManager shared]];
    
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
