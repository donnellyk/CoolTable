//
//  CustomCellBackground.m
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import "CustomCellBackground.h"
#import "Common.h"

@implementation CustomCellBackground
@synthesize lastCell, selected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews {
    CGFloat paperMargin = 9.0;
    paperRect = CGRectMake(paperMargin, 
                           self.bounds.origin.y, 
                           self.bounds.size.width-paperMargin*2, 
                           self.bounds.size.height);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //CGContextSetFillColor(context, [UIColor whiteColor].CGColor);
    //CGContextFillRect(context, self.bounds);
    
    //Gradient
    CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor; 
    CGColorRef lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
    CGColorRef separatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0].CGColor;

    //CGRect paperRect = self.bounds;
    
    if (selected) {
        drawLinearGradient(context, paperRect, lightGrayColor, separatorColor);
    } else {
        drawLinearGradient(context, paperRect, whiteColor, lightGrayColor);
    }
    
    if (!lastCell) {
        // Add white 1 px stroke
        CGRect strokeRect = paperRect;
        strokeRect.size.height -= 1;
        strokeRect = rectFor1PxStroke(strokeRect);
        
        CGContextSetStrokeColorWithColor(context, whiteColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextStrokeRect(context, strokeRect);
        
        // Add separator
        CGPoint startPoint = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        draw1PxStroke(context, startPoint, endPoint, separatorColor); 
        
    } else {
        
        CGContextSetStrokeColorWithColor(context, whiteColor);
        CGContextSetLineWidth(context, 1.0);
        
        CGPoint pointA = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint pointB = CGPointMake(paperRect.origin.x, paperRect.origin.y);
        CGPoint pointC = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y);
        CGPoint pointD = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        
        draw1PxStroke(context, pointA, pointB, whiteColor);
        draw1PxStroke(context, pointB, pointC, whiteColor);
        draw1PxStroke(context, pointC, pointD, whiteColor);
        
    }
    
    
}


@end
