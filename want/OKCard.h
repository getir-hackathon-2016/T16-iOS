//
//  OKCard.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKCard : NSObject

@property (nonatomic) int cardId;

@property (nonatomic,retain) NSString *cardName;

@property (nonatomic,retain) NSString *cardOwnerName;

@property (nonatomic,retain) NSString *cardNumber;

@property (nonatomic,retain) NSString *cardExpirationDate;

@property (nonatomic,retain) NSString *cardCVC2;


@end
