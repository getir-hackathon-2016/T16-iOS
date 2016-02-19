//
//  OKAddress.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKAddress : NSObject

@property (nonatomic) int addressId;

@property (nonatomic,retain) NSString *addressName;

@property (nonatomic,retain) NSString *addressStreetAddress;

//Detailed description of the address for the courier to find easily.
@property (nonatomic,retain) NSString *addressDescription;

//Latitude and Longitude values are stored as key-value
@property (nonatomic,retain) NSDictionary *addressLocation;

@property (nonatomic,retain) NSString *cardExpirationDate;

//We must not store this. But we will for this hackathon.
@property (nonatomic,retain) NSString *cardCVC2;

@end
