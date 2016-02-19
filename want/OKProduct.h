//
//  OKProduct.h
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKProduct : NSObject

@property (nonatomic) int productId;

@property (nonatomic,retain) NSString *productName;

@property (nonatomic,retain) NSString *productDescription;

@property (nonatomic,retain) NSString *productImageThumbnailURL;

@property (nonatomic,retain) NSString *productImageURL;

@property (nonatomic) int purchasedQuantity;

//Must be returned localized from server as a string.
@property (nonatomic,retain) NSString *productPriceString;

//e.g. 12.40
@property (nonatomic,retain) NSDecimalNumber *productPriceValue;


/*
productDiscountRate and productDiscountAmount can't exist at the same time.
*/

//Discount rate must be applied as percentage. Can be null.
@property (nonatomic,retain) NSString *productDiscountRate;

//Discount rate must be applied as reduction. Can be null.
@property (nonatomic,retain) NSString *productDiscountAmount;

@end
