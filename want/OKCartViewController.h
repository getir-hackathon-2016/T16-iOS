//
//  OKCartViewController.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKCart.h"

@interface OKCartViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UIButton *orderButton;
}
@property (nonatomic,retain) NSString *cartId;
@property (nonatomic,retain) UITableView *tableView;

@end
