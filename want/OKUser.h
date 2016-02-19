//
//  OKUser.h
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKUser : NSObject

@property (nonatomic) int userId;

@property (nonatomic,retain) NSString *userName;

@property (nonatomic,retain) NSString *userSurname;

@property (nonatomic,retain) NSString *userImageThumbnailURL;

@property (nonatomic,retain) NSString *userImageURL;

//MD5 Hash
@property (nonatomic,retain) NSString *userSessionToken;

@property (nonatomic,retain) NSMutableArray *userAddress;

@property (nonatomic,retain) NSMutableArray *userCreditCards;

@property (nonatomic,retain) NSMutableArray *userActiveOrders;

@property (nonatomic,retain) NSMutableArray *userPreviousOrders;

+ (id) currentUser;

@end
