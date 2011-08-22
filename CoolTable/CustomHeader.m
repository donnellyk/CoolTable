//
//  CustomHeader.m
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import "CustomHeader.h"
#import "Common.h"

@implementation CustomHeader
@synthesize titleLabel, lightColor, darkColor, sectionNumber;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.opaque = NO;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:titleLabel];
        self.lightColor = [UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f 
                                           blue:216.0f/255.0f alpha:1.0];
        self.darkColor = [UIColor colorWithRed:21.0/255.0 green:92.0/255.0 
                                          blue:136.0/255.0 alpha:1.0];
    }
    return self;
}

-(void) layoutSubviews {
    
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    coloredBoxRect = CGRectMake(coloredBoxMargin, 
                                 coloredBoxMargin, 
                                 self.bounds.size.width-coloredBoxMargin*2, 
                                 coloredBoxHeight);
    
    CGFloat paperMargin = 9.0;
    paperRect = CGRectMake(paperMargin, 
                            CGRectGetMaxY(coloredBoxRect), 
                            self.bounds.size.width-paperMargin*2, 
                            self.bounds.size.height-CGRectGetMaxY(coloredBoxRect));
    
    titleLabel.frame = coloredBoxRect;
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    
    CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 
                                             blue:1.0 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 
                                              blue:0.2 alpha:0.5].CGColor;
    
    const CGFloat *components = CGColorGetComponents(darkColor.CGColor);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    
    CGColorRef foldColor = [UIColor colorWithRed:red-(8/255) green:green-(61/255) blue:blue-(91/255) alpha:1.0].CGColor;
    
    CGContextSetFillColorWithColor(context, whiteColor);
    //CGContextFillRect(context, paperRect);
    
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    CGContextSetFillColorWithColor(context, lightColor.CGColor);
    //CGContextFillRect(context, coloredBoxRect);
    CGContextRestoreGState(context);
    
    //drawGlossAndGradient(context, coloredBoxRect, lightColor.CGColor, darkColor.CGColor);  
    /*
    CGContextSetStrokeColorWithColor(context, darkColor.CGColor);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, rectFor1PxStroke(coloredBoxRect));
     */
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    //CGPathMoveToPoint(pathRef, CGAffineTransformIdentity, coloredBoxRect.origin.x, CGRectGetMaxY(coloredBoxRect))
    
    //CGPathMoveToPoint(pathRef, CGAffineTransformIdentity, coloredBoxRect.origin.x, CGRectGetMaxY(coloredBoxRect));
    CGContextMoveToPoint(context, coloredBoxRect.origin.x, CGRectGetMaxY(coloredBoxRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(paperRect), CGRectGetMaxY(paperRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(paperRect), CGRectGetMinX(paperRect));
    CGContextSetFillColorWithColor(context, foldColor);
}



@end
