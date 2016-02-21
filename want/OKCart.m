//
//  OKCart.m
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKCart.h"

@implementation OKCart

- (id) init
{
    if (self = [super init])
    {
        self.productsInCart = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id)currentCart
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (void) emptyCart
{
    self.productsInCart = [[NSMutableArray alloc] init];
}

@end
