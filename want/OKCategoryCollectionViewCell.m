//
//  OKCategoryCollectionViewCell.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKCategoryCollectionViewCell.h"
#import "Chameleon.h"

@implementation OKCategoryCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageChanged:) name:@"image" object:nil];
                
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height * 1/4, frame.size.width, frame.size.height * 3/4)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, frame.size.width, 20)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];
        [self.titleLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:self.titleLabel];
        
        
        
    }
    return self;
}

- (void) prepareForReuse
{
    self.imageView.image = nil;
    self.titleLabel.text = @"";
}

@end
