//
//  OKConfirmOrderViewController.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKConfirmOrderViewController.h"
#import "OKConsulate.h"
#import "OKProduct.h"
#import "UIView+AutoLayout.h"
#import "Chameleon.h"
#import "UIBarButtonItem+Badge.h"
#import "UIButton+Badge.h"
#import "OKCart.h"
#import "RESideMenu.h"
#import "HGMovingAnnotationSampleViewController.h"


@implementation OKConfirmOrderViewController

- (void) viewDidLoad
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.title = NSLocalizedString(@"Checkout", @"Checkout");
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor flatWhiteColor]];
    
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
    return 5;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(10, 0, 320, 20);
    myLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightLight];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Delivery Address", @"Delivery Address");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Delivery Time", @"Delivery Time");
            break;
        case 2:
            sectionName = NSLocalizedString(@"Payment Method", @"Payment Method");
            break;
        case 3:
            sectionName = NSLocalizedString(@"Order Details", @"Order Details");
            break;
        case 4:
            sectionName = @"";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *MyIdentifier = @"addressCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier] ;
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            
        }
        
        
        cell.imageView.image = [UIImage imageNamed:@"750-home-toolbar"];
        cell.textLabel.text = NSLocalizedString(@"Choose an address", @"Choose and address");
        
        return cell;

    }else if (indexPath.section == 1)
    {
        static NSString *MyIdentifier = @"dateCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier] ;
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
        }
        
        
        cell.imageView.image = [UIImage imageNamed:@"851-calendar-toolbar"];
        cell.textLabel.text = NSLocalizedString(@"Pick a date", @"Pick a date");
        
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString *MyIdentifier = @"paymentCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier] ;
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
        }
        
        
        cell.imageView.image = [UIImage imageNamed:@"752-credit-card-toolbar"];
        cell.textLabel.text = NSLocalizedString(@"Choose a payment method", @"Choose a payment method");
        
        return cell;
    }else if (indexPath.section == 3)
    {
        static NSString *MyIdentifier = @"detailCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier] ;
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            //[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            
        }
        
        NSDecimalNumber *cartTotal = [NSDecimalNumber zero];
        
        for (int i = 0; i < [[[OKCart currentCart] productsInCart] count]; i++) {
            OKProduct *product = [[[OKCart currentCart] productsInCart] objectAtIndex:i];
            cartTotal = [cartTotal decimalNumberByAdding:product.productPriceValue];
        }

        
        cell.imageView.image = [UIImage imageNamed:@"826-money-1-toolbar"];
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total: $%@", @"Total: $%@"),cartTotal];
        
        return cell;
    }else if (indexPath.section == 4)
    {
        static NSString *MyIdentifier = @"payButtonCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier] ;
            
            //[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            
            UIButton *orderButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
            [orderButton setBackgroundColor:[UIColor flatRedColor]];
            [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [orderButton addTarget:self action:@selector(checkout:) forControlEvents:UIControlEventTouchUpInside];
            [orderButton setTitle:NSLocalizedString(@"Place Order", @"Place Order") forState:UIControlStateNormal];
            [cell addSubview:orderButton];
            
        }
        
        
        //cell.imageView.image = [UIImage imageNamed:@"826-money-1-toolbar"];
        //cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total: %@", @"Total: %@"),cartTotal];
        
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            return 40;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 80;
            break;
        case 4:
            return 40;
            break;
        default:
            return 0;
            break;
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void) checkout: (UIButton *)sender
{
    HGMovingAnnotationSampleViewController *movingDot = [[HGMovingAnnotationSampleViewController alloc] initWithNibName:@"HGMovingAnnotationSampleViewController" bundle:nil];
    [self.navigationController pushViewController:movingDot animated:YES];
}


@end
