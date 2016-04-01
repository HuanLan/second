//
//  ListModel.h
//  BeautifyClose
//
//  Created by 陈 on 16/3/28.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Action;
@interface ListModel : NSObject


@property (nonatomic, copy) NSString *descript;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *nationalFlag;

@property (nonatomic, copy) NSString *trackValue;

@property (nonatomic, assign) NSInteger publish_date;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *eventIcon;

@property (nonatomic, copy) NSString *stateMessage;

@property (nonatomic, copy) NSString *componentType;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *collectionCount;

@property (nonatomic, strong) Action *action;

@property (nonatomic, copy) NSString *origin_price;

@property (nonatomic, copy) NSString *sales;

@property (nonatomic, copy) NSString *country;


@end@interface Action : NSObject

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *actionType;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *sourceId;

@property (nonatomic, copy) NSString *trackValue;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *collectionCount;

@property (nonatomic, assign) NSInteger main_image;

@end

