//
//  OKConstants.h
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int kCartStatusNew = 0;
static const int kCartStatusOrdered = 1;
static const int kCartStatusConfirmed = 2;
static const int kCartStatusInTransit = 3;
static const int kCartStatusDelivered = 4;

static const int kAuthUsernameMissing = 410;
static const int kAuthPasswordMissing = 411;
static const int kAuthUserNotFound = 412;
static const int kAuthPasswordIsWrong = 413;
static const int kAuthSuccess = 420;

@interface OKConstants : NSObject

//Base API URL
extern NSString* const kBaseAPIUrl;

@end
