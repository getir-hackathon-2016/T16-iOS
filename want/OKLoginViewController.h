//
//  OKLoginViewController.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@protocol OKLoginViewControllerDelegate <NSObject>
@optional

- (void) presentSignupView;
- (void) presentForgotPasswordView;
- (void) loginFinished;

@end


@interface OKLoginViewController : UIViewController
{
    UIView *loginContainerView;
    
    JVFloatLabeledTextField *usernameTextField;
    JVFloatLabeledTextField *passwordTextField;
    
    UIButton *loginButton;
    UIButton *signupButton;
    UIButton *forgotPasswordButton;
}

@property (nonatomic, weak) id <OKLoginViewControllerDelegate> delegate;

@end
