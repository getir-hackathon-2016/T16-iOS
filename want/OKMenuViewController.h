//
//  OKMenuViewController.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface OKMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, readwrite, nonatomic) UITableView *tableView;
@end
