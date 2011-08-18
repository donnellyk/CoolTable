//
//  CustomHeader.h
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeader : UIView {
    UILabel *titleLabel;
    UIColor *lightColor;
    UIColor *darkColor;
    CGRect coloredBoxRect;
    CGRect paperRect;
}

// After @interface
@property (retain) UILabel *titleLabel;
@property (retain) UIColor *lightColor;
@property (retain) UIColor *darkColor;
@end
