//
//  CustomCellBackground.h
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellBackground : UIView {
    BOOL lastCell;
    BOOL selected;
    CGRect paperRect;

}
@property  BOOL lastCell;
@property  BOOL selected;
@end
