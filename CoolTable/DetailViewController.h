//
//  DetailViewController.h
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
