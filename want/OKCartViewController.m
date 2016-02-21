//
//  OKCartViewController.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKCartViewController.h"
#import "OKProduct.h"
#import "Chameleon.h"

@implementation OKCartViewController
- (void) viewDidLoad
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width /4, 0, self.view.frame.size.width * 3/4, self.view.frame.size.height * 3/4)];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setContentInset:UIEdgeInsetsMake(self.view.frame.size.height * 1/8, 0, self.view.frame.size.height * 1/8, 0)];
    
    [self.view addSubview:self.tableView];

    NSDecimalNumber *cartTotal = [NSDecimalNumber zero];

    for (int i = 0; i < [[[OKCart currentCart] productsInCart] count]; i++) {
        OKProduct *product = [[[OKCart currentCart] productsInCart] objectAtIndex:i];
        cartTotal = [cartTotal decimalNumberByAdding:product.productPriceValue];
        NSLog(@"Prodcut Pr:%@, Total:%@",product.productPriceValue,cartTotal);
    }
    

    orderButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -50, self.view.frame.size.width, 50)];
    [orderButton setBackgroundColor:[UIColor flatRedColor]];
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderButton addTarget:self action:@selector(orderCart:) forControlEvents:UIControlEventTouchUpInside];
    [orderButton setTitle:[NSString stringWithFormat:@"Checkout ($%@)",cartTotal] forState:UIControlStateNormal];
    [self.view addSubview:orderButton];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //[self.tableView pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];
    [self.view setBackgroundColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"icons-red"]] colorWithAlphaComponent:0.6]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cartUpdated:)
                                                 name:@"kCartUpdated"
                                               object:nil];
    
}

- (void) cartUpdated:(NSNotification *) notification
{
    [self.tableView reloadData];
    
    NSDecimalNumber *cartTotal = [NSDecimalNumber zero];
    
    for (int i = 0; i < [[[OKCart currentCart] productsInCart] count]; i++) {
        OKProduct *product = [[[OKCart currentCart] productsInCart] objectAtIndex:i];
        cartTotal = [cartTotal decimalNumberByAdding:product.productPriceValue];
        NSLog(@"Prodcut Pr:%@, Total:%@",product.productPriceValue,cartTotal);
    }
    
    [orderButton setTitle:[NSString stringWithFormat:@"Checkout ($%@)",cartTotal] forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[OKCart currentCart] productsInCart] count];    //count number of row from counting array hear cataGorry is An Array
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
        
        [cell.textLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
        UIButton *removeFromCartButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60, 10, 50, 30)];
        
        [removeFromCartButton addTarget:self action:@selector(removeFromCart:) forControlEvents:UIControlEventTouchUpInside];
        
        [removeFromCartButton setTitle:NSLocalizedString(@"Remove", @"Remove") forState:UIControlStateNormal];
        [removeFromCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [removeFromCartButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [removeFromCartButton.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]];
        [removeFromCartButton.layer setCornerRadius:2];
        [removeFromCartButton.layer setBorderWidth:1];
        [cell addSubview:removeFromCartButton];
        
    }
    
    OKProduct *product = [[[OKCart currentCart] productsInCart] objectAtIndex:indexPath.row];
    
    //[cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"product-%i.jpeg",arc4random_uniform(128) + 1]]];
    
    cell.textLabel.text = product.productName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@$",product.productPriceValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void) removeFromCart: (UIButton *)sender
{
    OKCart *currentCart = [OKCart currentCart];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    [currentCart.productsInCart removeObject:[[[OKCart currentCart] productsInCart] objectAtIndex:indexPath.row]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"kCartUpdated" object:nil userInfo:nil];

}


@end
