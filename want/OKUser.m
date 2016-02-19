//
//  OKUser.m
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKUser.h"

@implementation OKUser

- (id) init
{
    if (self = [super init])
    {
        //Do any custom initialization here.
    }
    return self;
}

+ (id)currentUser
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

@end
