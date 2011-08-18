//
//  RootViewController.h
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSMutableArray *thingsToLearn;
    NSMutableArray *thingsLearned;
    
    BOOL showList;
}

-(void)toggleListsFromSender:(UITapGestureRecognizer *)sender;

@property (retain) NSMutableArray *thingsToLearn;
@property (retain) NSMutableArray *thingsLearned;

@property (retain) NSMutableArray *dataSourcesReserves;
@property (retain) NSMutableArray *dataSources;

@end