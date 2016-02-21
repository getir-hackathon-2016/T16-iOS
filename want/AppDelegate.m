//
//  AppDelegate.m
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "AppDelegate.h"
#import "Chameleon.h"
#import "RESideMenu.h"

#import "OKMainNavigationController.h"
#import "OKHomeViewController.h"
#import "OKMenuViewController.h"
#import "OKCartViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Theme the app here.
    NSDictionary *textTitleOptions =
    [NSDictionary dictionaryWithObjectsAndKeys:[UIColor flatWhiteColor],
     NSForegroundColorAttributeName,
     [UIColor flatWhiteColor],
     NSForegroundColorAttributeName, nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    textTitleOptions =
    [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
     NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor flatRedColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
    
    [[UIToolbar appearance] setTintColor:[UIColor flatWhiteColor]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor flatRedColor]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class],nil] setTintColor:[UIColor flatWhiteColor]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor flatWhiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor flatRedColor]];
    
    [[UISegmentedControl appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UISearchBar appearance] setBarTintColor:[UIColor flatRedColor]];
    
    //Initializing main navigation and menu
    
    // Create content and menu controllers
    //
    OKMainNavigationController *navigationController = [[OKMainNavigationController alloc] initWithRootViewController:[[OKHomeViewController alloc] init]];
    OKMenuViewController *leftMenuViewController = [[OKMenuViewController alloc] init];
    OKCartViewController *rightMenuViewController = [[OKCartViewController alloc] init];
    // Create side menu controller
    //
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
    
    // Make it a root controller
    //
    self.window.rootViewController = sideMenuViewController;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
