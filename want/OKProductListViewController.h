//
//  OKProductListViewController.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKProductListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *products;
}
@property (nonatomic) NSString *categoryId;
@property (nonatomic,retain) UITableView *tableView;
@end
