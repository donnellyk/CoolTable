//
//  RootViewController.m
//  CoolTable
//
//  Created by Kevin Donnelly on 8/17/11.
//  Copyright 2011 -. All rights reserved.
//

#import "RootViewController.h"

#import "DetailViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@implementation RootViewController
@synthesize thingsLearned, thingsToLearn;
@synthesize dataSources, dataSourcesReserves;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    showList = false;
	self.title = @"Core Graphics!";
    self.thingsToLearn = [NSMutableArray arrayWithObjects:@"Rectangles", @"Glossy!", @"Other stuff!", @"One more thing" nil];
    self.thingsLearned = [NSMutableArray arrayWithObjects:@"Table Views", 
                          @"UIKit", @"Objective-C", nil];
    
    //Good lord, this is ugly. But, need the deep copy.
    self.dataSourcesReserves = [NSMutableArray arrayWithObjects:[[NSMutableArray alloc] initWithArray:thingsToLearn copyItems:YES], [[NSMutableArray alloc] initWithArray:thingsLearned copyItems:YES], nil];
    self.dataSources = [NSMutableArray arrayWithObjects:[[NSMutableArray alloc] initWithArray:thingsToLearn copyItems:YES], [[NSMutableArray alloc] initWithArray:thingsLearned copyItems:YES], nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return YES;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSources objectAtIndex:section] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundView = [[CustomCellBackground alloc] init];
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
        ((CustomCellBackground *)cell.selectedBackgroundView).selected = YES;
    }
    
    NSMutableArray *data = [dataSources objectAtIndex:indexPath.section];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    ((CustomCellBackground *)cell.backgroundView).lastCell = indexPath.row == data.count - 1;
    ((CustomCellBackground *)cell.selectedBackgroundView).lastCell = indexPath.row == data.count - 1;

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Things in Need of Learning";
    } else {
        return @"Things Learned";
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    header.sectionNumber = [NSNumber numberWithInt:section];
    if (section == 1) {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 
                                             blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 
                                            blue:137.0/255.0 alpha:1.0];
    }
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleListsFromSender:)];
    [header addGestureRecognizer:gestureRecognizer];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[CustomFooter alloc] init];
}

-(void)toggleListsFromSender:(UITapGestureRecognizer *)sender {
    UIView *touchedView = [self.view hitTest:[sender locationInView:self.view] withEvent:nil];
    
    int section = [((CustomHeader *)touchedView).sectionNumber intValue];
    int count = [[dataSourcesReserves objectAtIndex:section] count];
    NSMutableArray * indexes = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexes addObject:newIndexPath];
    }
    
    if ([[dataSources objectAtIndex:section] count] != 0) {
        //Hide
        [[dataSources objectAtIndex:section] removeAllObjects];
        [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
    } else {
        //Show
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:[dataSourcesReserves objectAtIndex:section] copyItems:YES]; //Deep copy!
        [dataSources removeObjectAtIndex:section];
        [dataSources insertObject:tmp atIndex:section];
        
        [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
    }
    
    //[self.tableView reloadData];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    // Pass the selected object to the new view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
}

@end
