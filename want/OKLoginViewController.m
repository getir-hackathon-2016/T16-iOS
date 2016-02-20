//
//  OKLoginViewController.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKLoginViewController.h"
#import "UIView+AutoLayout.h"
#import "Chameleon.h"
#import "OKUser.h"
#import "OKConsulate.h"

@implementation OKLoginViewController

- (void) viewDidLoad
{
    [self.view setBackgroundColor:[UIColor flatRedColor]];
    
    loginContainerView = [[UIView alloc] init];
    
    [loginContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:loginContainerView];

    
    usernameTextField = [[JVFloatLabeledTextField alloc] init];
    
    [usernameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];

    [usernameTextField setPlaceholder:NSLocalizedString(@"What is your name?", @"What is your name?") floatingTitle:NSLocalizedString(@"Your Name", @"Your Name")];
    
    [usernameTextField setTextAlignment:NSTextAlignmentCenter];
    
    [usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [usernameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [usernameTextField setFloatingLabelTextColor:[UIColor flatRedColor]];
    
    [usernameTextField setTintColor:[UIColor flatRedColor]];
    
    [usernameTextField setTextColor:[UIColor whiteColor]];
    
    [usernameTextField constrainToHeight:40];
    
    
    [loginContainerView addSubview:usernameTextField];
    
    passwordTextField = [[JVFloatLabeledTextField alloc] init];
    
    [passwordTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [passwordTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [passwordTextField setSecureTextEntry:YES];
    
    [passwordTextField setTextAlignment:NSTextAlignmentCenter];

    [passwordTextField setFloatingLabelTextColor:[UIColor flatRedColor]];

    [passwordTextField setTintColor:[UIColor flatRedColor]];
    
    [passwordTextField setTextColor:[UIColor whiteColor]];

    [passwordTextField constrainToHeight:40];
    
    
    
    [passwordTextField setPlaceholder:NSLocalizedString(@"What is your password?", @"What is your pasword?") floatingTitle:NSLocalizedString(@"Your Password", @"Your Password")];
    
    [loginContainerView addSubview:passwordTextField];
    
    loginButton = [[UIButton alloc] init];
    
    [loginButton addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [loginButton constrainToHeight:40];
    
    
    [loginButton setTitle:NSLocalizedString(@"Login", @"Login") forState:UIControlStateNormal];
    
    [loginButton.layer setBorderColor:[UIColor flatRedColor].CGColor];
    
    [loginButton.layer setBorderWidth:1];
    
    [loginContainerView addSubview:loginButton];
    
    
    signupButton = [[UIButton alloc] init];
    
    [signupButton addTarget:self.delegate action:@selector(presentSignupView) forControlEvents:UIControlEventTouchUpInside];
    
    [signupButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [signupButton constrainToHeight:40];
    
    
    [signupButton setTitle:NSLocalizedString(@"Signup", @"Signup") forState:UIControlStateNormal];
    
    [signupButton.layer setBorderColor:[UIColor flatRedColor].CGColor];
    
    [signupButton.layer setBorderWidth:1];
    
    [loginContainerView addSubview:signupButton];

    
    forgotPasswordButton = [[UIButton alloc] init];
    
    [forgotPasswordButton addTarget:self.delegate action:@selector(presentForgotPasswordView) forControlEvents:UIControlEventTouchUpInside];

    [forgotPasswordButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [forgotPasswordButton constrainToHeight:20];
    
    
    [forgotPasswordButton setTitle:NSLocalizedString(@"Forgot Password", @"Forgot Password") forState:UIControlStateNormal];
    
    [forgotPasswordButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [forgotPasswordButton setTitleColor:[UIColor flatRedColor] forState:UIControlStateNormal];
    
    [loginContainerView addSubview:forgotPasswordButton];
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLayoutConstraint *ratioConstraint = [NSLayoutConstraint
                                           constraintWithItem:loginContainerView
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:loginContainerView
                                           attribute:NSLayoutAttributeHeight
                                           multiplier:1.0
                                           constant:0.0f];
    
    [loginContainerView addConstraint:ratioConstraint];
    
    NSLayoutConstraint *verticallyCenterConstraint = [NSLayoutConstraint
                                                      constraintWithItem:loginContainerView
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                      toItem:self.view
                                                      attribute:NSLayoutAttributeCenterY
                                                      multiplier:1.0
                                                      constant:0.0f];
    
    [self.view addConstraint:verticallyCenterConstraint];
    
    NSArray *insetConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[loginView]-10-|" options:0 metrics:nil views:@{@"loginView":loginContainerView}];
    
    [self.view addConstraints:insetConstraint];

    [loginContainerView spaceViews:@[usernameTextField,passwordTextField,loginButton,signupButton,forgotPasswordButton] onAxis:UILayoutConstraintAxisVertical];
    
    [usernameTextField pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
    [usernameTextField pinToSuperviewEdges:JRTViewPinRightEdge inset:0];
    [passwordTextField pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
    [passwordTextField pinToSuperviewEdges:JRTViewPinRightEdge inset:0];
    [loginButton pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
    [loginButton pinToSuperviewEdges:JRTViewPinRightEdge inset:0];
    [signupButton pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
    [signupButton pinToSuperviewEdges:JRTViewPinRightEdge inset:0];
    [forgotPasswordButton pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
    [forgotPasswordButton pinToSuperviewEdges:JRTViewPinRightEdge inset:0];
    
    [super viewWillAppear:animated];
}

- (void) doLogin
{
    [OKConsulate loginUserWithUsername:usernameTextField.text andPassword:passwordTextField.text withCompletionBlock:^(BOOL succeeded, NSError *error) {        
        if (succeeded) {
            [self.delegate loginFinished];
        }
    }];
    
    
}

@end
