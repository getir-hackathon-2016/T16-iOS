//
//  OKProductListViewController.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKProductListViewController.h"
#import "OKConsulate.h"
#import "OKProduct.h"
#import "UIView+AutoLayout.h"
#import "Chameleon.h"
#import "UIBarButtonItem+Badge.h"
#import "UIButton+Badge.h"
#import "OKCart.h"
#import "RESideMenu.h"

@implementation OKProductListViewController

- (void) viewDidLoad
{
    [OKConsulate fetchProductsWithCategory:self.categoryId skip:0 withCompletionBlock:^(BOOL succeeded, NSError *error, NSArray *result) {
    
        products = result;
        [self.tableView reloadData];
    }];
    
    UIImage *image = [[UIImage imageNamed:@"762-shopping-bag-toolbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,image.size.width, image.size.height);
    [button addTarget:self.sideMenuViewController action:@selector(presentRightMenuViewController) forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    cartButton = [[UIBarButtonItem alloc] initWithCustomView:button];

    self.navigationItem.rightBarButtonItem = cartButton;
    self.navigationItem.rightBarButtonItem.shouldAnimateBadge = YES;
    self.navigationItem.rightBarButtonItem.shouldHideBadgeAtZero = YES;
    self.navigationItem.rightBarButtonItem.badgeValue = @"0";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.badgeTextColor = [UIColor flatRedColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cartUpdated:)
                                                 name:@"kCartUpdated"
                                               object:nil];
    
}

- (void) cartUpdated:(NSNotification *) notification
{
    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)[[[OKCart currentCart] productsInCart] count]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [products count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"productCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:MyIdentifier] ;
        
        UIButton *addToCartButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60, 25, 50, 30)];
        
        [addToCartButton addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
        
        [addToCartButton setTitle:NSLocalizedString(@"Buy", @"Buy") forState:UIControlStateNormal];
        [addToCartButton setTitleColor:[UIColor flatRedColor] forState:UIControlStateNormal];
        [addToCartButton.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]];
        [addToCartButton.layer setBorderColor:[UIColor flatRedColor].CGColor];
        [addToCartButton.layer setCornerRadius:2];
        [addToCartButton.layer setBorderWidth:1];
        [cell addSubview:addToCartButton];

    }
    
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    OKProduct *product = [products objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"product-%i.jpeg",arc4random_uniform(128) + 1]]];
    cell.textLabel.text = product.productName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@$",product.productPriceValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
}

- (void) addToCart: (UIButton *)sender
{
 
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    
    [[[OKCart currentCart] productsInCart] addObject:[products objectAtIndex:indexPath.row]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"kCartUpdated" object:nil userInfo:nil];

}

@end
