//
//  IDTypeViewController.m
//  MPOS
//
//  Created by Meng Cheong on 6/3/13.
//  Copyright (c) 2013 Meng Cheong. All rights reserved.
//

#import "PriorityViewController.h"

@interface PriorityViewController ()

@end

@implementation PriorityViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"priority" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
        
        //_IDTypes = [NSMutableArray array];
        _IDTypes = [dict objectForKey:@"PriorityTypes"];//[NSMutableArray array];
        
        self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger rowsCount = [_IDTypes count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        

        CGFloat largestLabelWidth = 0;
        for (NSString *IDType in _IDTypes) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [IDType sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    //NSLog(@"QQQQ%@",_currentVal);
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_IDTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    // Configure the cell...
    
    NSLog(@"%@",_currentVal);
    cell.textLabel.text = [_IDTypes objectAtIndex:indexPath.row];
    
    if ([_currentVal isEqualToString:@"N/A"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if ([_currentVal isEqualToString:@"1"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection: 0];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if ([_currentVal isEqualToString:@"2"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection: 0];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if ([_currentVal isEqualToString:@"3"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection: 0];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if ([_currentVal isEqualToString:@"4"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection: 0];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if ([_currentVal isEqualToString:@"5"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection: 0];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    //[cell.textLabel setHighlighted:YES];
    
    //NSIndexPath = [NSIndexPath indexPathForRow:0 inSection:0]; // set to whatever you want to be selected first
    //[tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionNone];
    
    
    //NSLog(@"%@",_currentVal);
    
    return cell;
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//if (indexPath.row == 0)
	NSString *selectedIDType = [_IDTypes objectAtIndex:indexPath.row];
	NSLog(@"selected id :%@",selectedIDType);

    
    //Notify the delegate if it exists.
    if (_delegate != nil) {
        [_delegate selectedIDType:selectedIDType];
		//[_delegate selectedIDType2:selectedIDType priority:indexPath.row+1];
		//[_delegate selectedIDType3:selectedIDType priority:indexPath.row+1];
		//[_delegate selectedIDType4:selectedIDType priority:indexPath.row+1];
		//[_delegate selectedIDType5:selectedIDType priority:indexPath.row+1];
    }
    
    
    
}

@end
