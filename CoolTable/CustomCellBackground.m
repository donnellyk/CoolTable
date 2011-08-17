//
//  CustomCellBackground.m
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import "CustomCellBackground.h"

@implementation CustomCellBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    
    CGContextSetFillColorWithColor(context, redColor);
    CGContextFillRect(context, self.bounds);
    
}


@end
