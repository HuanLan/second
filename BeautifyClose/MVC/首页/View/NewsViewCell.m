//
//  NewsViewCell.m
//  BeautifyClose
//
//  Created by 陈 on 16/3/9.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import "NewsViewCell.h"

@implementation NewsViewCell


- (void)config{
    
    self.layer.cornerRadius = self.raidus;
    self.layer.borderColor = self.wColor.CGColor;
    self.layer.borderWidth = self.bWidth;
    [self layoutIfNeeded];

}

- (void)awakeFromNib {
    // Initialization code
    [self config];
}

-(void)prepareForInterfaceBuilder{
    [self config];
}

-(void)setModel:(ListModel *)model{
    
    _model = model;
    self.goodPrice.attributedText = [self joinStr:model.price withStr:model.origin_price ];
    NSString *imgPath = model.picUrl;
    NSRange range = [model.picUrl rangeOfString:@"?"];
    if(range.length > 0){
        
         imgPath = [model.picUrl substringWithRange:NSMakeRange(0, range.location)];
        
    }
   
    [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:imgPath]];
    self.goodName.text = model.descript;


    
}

- (NSMutableAttributedString *)joinStr:(NSString *)price withStr:(NSString *)origin_str{
    
    NSDictionary *priceDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont systemFontOfSize:16.0],NSFontAttributeName,
                               [UIColor magentaColor],NSForegroundColorAttributeName,
                               nil];
    NSDictionary *originDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont systemFontOfSize:13.0],NSFontAttributeName,
                                [UIColor grayColor],NSForegroundColorAttributeName,
                                @(NSUnderlinePatternSolid | NSUnderlineStyleSingle) ,NSStrikethroughStyleAttributeName,
                                
                                nil];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"$%@", price] attributes:priceDict];
    NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"$%@",origin_str] attributes:originDict];
    
    
    
    [attrStr appendAttributedString:str2];
    
    return attrStr;
}


@end
