//
//  OKCart.h
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OKCart : NSObject

@property (nonatomic) int cartId;

@property (nonatomic,retain) NSMutableArray *productsInCart;

@property (nonatomic) int *selectedAddressId;

@property (nonatomic) int *selectedCardId;

@property (nonatomic,retain) NSString *cartDeliveryAdress;

@property (nonatomic,retain) NSDictionary *cartDeliveryCoordinates;

//See OKConstants.m for available values
@property (nonatomic) int *cartDeliveryStatus;

@end
