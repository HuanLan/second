//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageButton.h"
#import "SDWebImageManager.h"


@implementation UrlImageButton

@synthesize iconIndex;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
		iconIndex = -1;

		isScale = NO;
    
	}
    return self;
}


- (void)setImage:(BOOL)animated withUrl:(NSString *)iconUrl withIsBkg:(BOOL)isBkg
{       
	_animated = animated;
	_isBackgroundImage = isBkg;
	NSURL* tempUrl = [NSURL URLWithString:iconUrl];
	if(isBkg)
	{
        [self sd_setBackgroundImageWithURL:tempUrl forState:UIControlStateNormal placeholderImage: [UIImage imageNamed:@"rr_side.png"]];
	}
	else {
        
		[self sd_setImageWithURL:tempUrl  forState:UIControlStateNormal];
	}

	
	
	}

- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl
{       
	[self setImage:animated withUrl:iconUrl withIsBkg:YES];
}	

- (void) setImageFromUrl:(BOOL) animated withUrl:(NSString *)iconUrl
{       
	
	[self setImage:animated withUrl:iconUrl withIsBkg:NO];
}	

	
- (void)cancelCurrentImageLoad
{
	
}





@end
