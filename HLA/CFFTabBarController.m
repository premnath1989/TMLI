//
//  FSVerticalTabBarController.m
//  iOS-Platform
//
//  Created by Błażej Biesiada on 4/6/12.
//  Copyright (c) 2012 Future Simple. All rights reserved.
//

#import "CFFTabBarController.h"
#import "Login.h"

#import "MainScreen.h"
#import "BasicPlanHandler.h"
#import "SIMenuViewController.h"
#import "NewLAViewController.h"
#import "PayorViewController.h"
#import "SecondLAViewController.h"
#import "BasicPlanViewController.h"
#import "RiderViewController.h"
#import "PremiumViewController.h"
#import "SIListing.h"
#import "AppDelegate.h"
#import "ProspectListing.h"
#import "SIListing.h"

#define DEFAULT_TAB_BAR_HEIGHT 60.0


@interface CFFTabBarController ()
- (void)_performInitialization;
@end

int rrr;

@implementation CFFTabBarController


@synthesize delegate = _delegate;
@synthesize tabBar = _tabBar;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarWidth = _tabBarWidth;


- (CFFTabBar *)tabBar
{
    if (_tabBar == nil)
    {
        _tabBar = [[CFFTabBar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _tabBar.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
        _tabBar.delegate = self;
    }
    return _tabBar;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = [viewControllers copy];
    
    // create tab bar items
    if (self.tabBar != nil)
    {
        NSMutableArray *tabBarItems = [NSMutableArray arrayWithCapacity:[self.viewControllers count]];
        for (UIViewController *vc in self.viewControllers)
        {
            [tabBarItems addObject:vc.tabBarItem];
        }
        self.tabBar.items = tabBarItems;
    }
    
    // select first VC from the new array
    // sets the value for the first time as -1 for the viewController to load itself properly
    _selectedIndex = -1;
    
    self.selectedIndex = [viewControllers count] > 0 ? 0 : INT_MAX;
}


- (UIViewController *)selectedViewController
{
    if (self.selectedIndex < [self.viewControllers count])
    {
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    }
    return nil;
}


- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    self.selectedIndex = [self.viewControllers indexOfObject:selectedViewController];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    
    if (selectedIndex != _selectedIndex && selectedIndex < [self.viewControllers count])
    {
        [self.view endEditing:YES];
        [self resignFirstResponder];
        
        Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
        id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
        [activeInstance performSelector:@selector(dismissKeyboard)];
        
        // add new view controller to hierarchy
        UIViewController *selectedViewController = [self.viewControllers objectAtIndex:selectedIndex];
        
        if (selectedIndex == 0) {
            
            [self presentViewController:selectedViewController animated:NO completion:Nil];
            [self updateTabBar];
        }
        else {
            
            if (selectedIndex == 1 || selectedIndex == 2) {
                
                [self addChildViewController:selectedViewController];
                selectedViewController.view.frame = CGRectMake(self.tabBarWidth,
                                                                   0,
                                                                   self.view.bounds.size.width-self.tabBarWidth,
                                                                   self.view.bounds.size.height);
                selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
                [self.view addSubview:selectedViewController.view];
                
                [self updateTabBar];
            }
            
        }
        selectedViewController = Nil;
    }
}

-(void)updateTabBar
{
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex:clickIndex];
    
    // set new selected index
    _selectedIndex = clickIndex;
    
    // update tab bar
    if (clickIndex < [self.tabBar.items count])
    {
        self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:clickIndex];
    }
    
    // inform delegate
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [self.delegate tabBarController:self didSelectViewController:selectedViewController];
    }
    selectedViewController = Nil;
}

-(void)updateTabBar2
{
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex:clickIndex];
    
    // set new selected index
    _selectedIndex = clickIndex;
    
    // update tab bar
    if (clickIndex < [self.tabBar.items count])
    {
        self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:clickIndex];
    }
    
    // inform delegate
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [self.delegate tabBarController:self didSelectViewController:selectedViewController];
    }
    selectedViewController = Nil;
}

- (void)_performInitialization
{
    self.tabBarWidth = DEFAULT_TAB_BAR_HEIGHT;
    self.selectedIndex = INT_MAX;
    _tabBarColor = [UIColor colorWithRed:250.0/255.0 green:175.0/255.0 blue:50.0/255.0 alpha:1.0];
}

#pragma mark -
#pragma mark UIViewController
- (id)init
{
    if ((self = [super init]))
    {
        [self _performInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self _performInitialization];
    }
    return self;
}


- (void)loadView
{
    UIView *layoutContainerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    layoutContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    layoutContainerView.autoresizesSubviews = YES;
    
    // create tab bar
    self.tabBar.frame = CGRectMake(0, 20, self.tabBarWidth, layoutContainerView.bounds.size.height);
    
    [layoutContainerView addSubview:self.tabBar];
    [layoutContainerView setBackgroundColor:[UIColor blackColor]];
    
    // return a ready view
    self.view = layoutContainerView;
}	


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController *selectedViewController = self.selectedViewController;
    if (selectedViewController != nil)
    {
        return [selectedViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
    return YES;
}


#pragma mark -
#pragma mark FSVerticalTabBarController
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    self.viewControllers = viewControllers;
}


#pragma mark -
#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(rrr != 2) {
		clickIndex = indexPath.row;
		if (indexPath.row == 2) {
			UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@" ",nil)
                              message: NSLocalizedString(@"Are you sure you want to log out?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
			[alert setTag:1001];
			[alert show];
			alert = Nil;
		}
		else {
			[self setSelectedIndex:indexPath.row];
		}
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
    {
        [self updateDateLogout];
    }
    else if (alertView.tag == 1001 && buttonIndex == 1)
    {
        //--edited by bob
        clickIndex = _selectedIndex;
        [self updateTabBar2];
    }
}

-(void)updateDateLogout
{
    NSString *databasePath;
    sqlite3 *contactDB;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
    mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainLogin animated:YES completion:NULL];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET LastLogoutDate= \"%@\" WHERE IndexNo=\"%d\"",dateString, 1];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_step(statement);
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    databasePath = Nil;
    contactDB = Nil, dirPaths = Nil, docsDir = Nil, databasePath= Nil, mainLogin = Nil, dateFormatter = Nil, dateString = Nil;
    dbpath = Nil, statement = Nil, contactDB = Nil;
    
    
    exit(0);
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = FALSE;
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        UIViewController *newController = [self.viewControllers objectAtIndex:indexPath.row];
        result = [self.delegate tabBarController:self shouldSelectViewController:newController];
    }
    
    if (result) {
		if (rrr == 2) {
			return tableView.indexPathForSelectedRow;
		}
		else{
			return indexPath;
		}
    }
    else {
        return tableView.indexPathForSelectedRow;
    }
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

-(void)Test{
	
	rrr = 2;
	
}

-(void)Reset{
	
	rrr = 0;
	
}

@end
