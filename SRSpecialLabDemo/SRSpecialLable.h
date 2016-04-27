//
//  SRSpecialLable.h
//  SRSpecialLabDemo
//
//  Created by 王保霖 on 16/4/27.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSpecialObj.h"
@protocol SRSpecialDelegate <NSObject>

- (void)SRSpecialDidSelectSpecialPoint:(SRSpecialObj *)point;

@end

@interface SRSpecialLable : UITextView
@property(nonatomic,strong)NSArray *specials;
@property(nonatomic,assign) id <SRSpecialDelegate> SRdelegate;


@end
