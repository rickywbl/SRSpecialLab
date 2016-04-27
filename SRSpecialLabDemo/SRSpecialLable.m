//
//  SRSpecialLable.m
//  SRSpecialLabDemo
//
//  Created by 王保霖 on 16/4/27.
//  Copyright © 2016年 Ricky. All rights reserved.
//


#define SRCoverViewTag  999

#import "SRSpecialLable.h"
#import "SRSpecialObj.h"

@implementation SRSpecialLable



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 默认的UITextView有内边距的  修改内边距
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        //必须设置
        self.scrollEnabled = NO;
        
        //设置UITextView为不能编辑状态
        self.editable = NO;

    }
    return self;
}

-(NSArray *)specials{

    if(_specials == nil){
    
        _specials = [[NSMutableArray alloc]init];
    }
    return _specials;
}


/**
 *  计算出每个有链接的字符串的CGRect
 */
-(void)setUpSRSpecial{

    for (SRSpecialObj *point in self.specials ) {
        
        self.selectedRange = point.range;
        NSArray * selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        
        for (UITextSelectionRect * selectionRect in selectionRects) {
            
            CGRect rect = selectionRect.rect;
            
            
            if(rect.size.width == 0 || rect.size.height == 0) continue;
            
            [rects addObject:[NSValue valueWithCGRect:rect]];
            
        }
        
        point.rects = rects;
        
        
    }
 
}


//判断当前点击的点是不是特殊的字符串

-(SRSpecialObj *)touchSpecialWithPoint:(CGPoint)point{

    
    for (SRSpecialObj *special in self.specials) {
        
        for (NSValue * rectValue in special.rects) {
            
            CGRect rect = rectValue.CGRectValue;
            
            
            if(CGRectContainsPoint(rect, point)){
            
                return special;
                
            }
            
        }
        
    }
    
    return nil;


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    [self setUpSRSpecial];

    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self];
    
    SRSpecialObj *point = [self  touchSpecialWithPoint:touchPoint];
    
    //cover 背景覆盖层
    
    for (NSValue * rectValue in point.rects) {
        
        UIView *cover =[[UIView alloc]init];
        
        cover.backgroundColor =[UIColor redColor];
        
        cover.frame = rectValue.CGRectValue;
        
        cover.tag =  SRCoverViewTag;
        
        [self insertSubview:cover atIndex:0];
        
    }
    
    //point!= nil 说明当前点击的位置是特殊的字符串位置 实现代理方法.
    
    if(point){
    
        
        if([self.SRdelegate respondsToSelector:@selector(SRSpecialDidSelectSpecialPoint:)]){
        
            [self.SRdelegate SRSpecialDidSelectSpecialPoint:point];
        }
    }

}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *child in self.subviews) {
        
        if (child.tag == SRCoverViewTag) [child removeFromSuperview];
    }
}


//判断当前点击事件谁来接受

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    [self setUpSRSpecial];
    
    SRSpecialObj *spoint = [self touchSpecialWithPoint:point];
    
    if(spoint){
    
        return YES;
    }
    
    return NO;
    
}

@end
