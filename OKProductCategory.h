//
//  OKProductCategory.h
//  want
//
//  Created by Omer Karisman on 19/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKProductCategory : NSObject
@property (nonatomic) int categoryId;
@property (nonatomic,retain) NSString *categoryName;
@property (nonatomic,retain) NSString *categoryImageURL;
@end
