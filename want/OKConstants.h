//
//  OKConstants.h
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKConstants : NSObject

//Base API URL
extern NSString* const kBaseAPIUrl;

//Used in OKCart as cartDeliveryStatus
extern int const kCartStatusNew;
extern int const kCartStatusOrdered;
extern int const kCartStatusConfirmed;
extern int const kCartStatusInTransit;
extern int const kCartStatusDelivered;

@end
