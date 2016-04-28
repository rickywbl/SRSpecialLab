//
//  SRSpecialObj.h
//  SRSpecialLabDemo
//
//  Created by 王保霖 on 16/4/27.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SRSpecialObj : NSObject

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)NSRange range;
@property(nonatomic,strong)NSArray *rects;
@property(nonatomic,strong)UIColor *HLBackgroundColor;
@end
