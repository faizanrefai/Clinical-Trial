//
//  FirstViewController.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController
@synthesize srchBar,tblView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBarHidden=TRUE;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	classArray = [[NSMutableArray alloc] initWithArray:appDel.arrSearchData];
    ratingArry = [[NSMutableArray alloc] init];

    
    
    
    for (int i=0; [appDel.arrSearchData count]>i; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%@",[[appDel.arrSearchData objectAtIndex:i] valueForKey:@"rating"]];
        [ratingArry addObject:str];
    }
    
    
    
	//self.navigationItem.title=@"Search";
	
}
- (void)viewWillAppear:(BOOL)animated
{
}

-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//	return YES;
//}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//	if ([srchBar.text length]>0) 
//	{
//		tblView.hidden=FALSE;
//	}
//}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//	if ([srchBar.text length]>0) 
//	{
//		tblView.hidden=FALSE;
//	}
//}
#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDel.arrSearchData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        [[NSBundle mainBundle]loadNibNamed:@"ListViewCell" owner:self options:nil];
        cell = custmCell;
        
    }
     
    switch ([[ratingArry objectAtIndex:indexPath.row] intValue]) {
    
        case 0:{
            
            strBtn1.selected=FALSE;
            strBtn2.selected=FALSE;
            strBtn3.selected=FALSE;
            strBtn4.selected=FALSE;
            strBtn5.selected=FALSE;

            
            break;
        }
        case 1:{
            
            strBtn1.selected=TRUE;
            strBtn2.selected=FALSE;
            strBtn3.selected=FALSE;
            strBtn4.selected=FALSE;
            strBtn5.selected=FALSE;

            
            break;
        }
        case 2:{
            
            strBtn1.selected=TRUE;
            strBtn2.selected=TRUE;
            strBtn3.selected=FALSE;
            strBtn4.selected=FALSE;
            strBtn5.selected=FALSE;

            
            break;
        }
        case 3:{
            
            strBtn1.selected=TRUE;
            strBtn2.selected=TRUE;
            strBtn3.selected=TRUE;
            strBtn4.selected=FALSE;
            strBtn5.selected=FALSE;
            
            break;
        }
        case 4:{
            
            strBtn1.selected=TRUE;
            strBtn2.selected=TRUE;
            strBtn3.selected=TRUE;
            strBtn4.selected=TRUE;
            strBtn5.selected=FALSE;
            
            break;
        }
        case 5:{
            
            strBtn1.selected=TRUE;
            strBtn2.selected=TRUE;
            strBtn3.selected=TRUE;
            strBtn4.selected=TRUE;
            strBtn5.selected=TRUE;
            
            break;
        }
            
        default:
            break;
    }
    
    ratingView.tag=indexPath.row;
    
	// Configure the cell.
	NSString *str = [NSString stringWithFormat:@"%@",[[appDel.arrSearchData objectAtIndex:indexPath.row] valueForKey:@"research_center_name"]];
	titleLabel.text=str;
	//[cell setTextColor:[UIColor brownColor]];
	[titleLabel setTextColor:[UIColor brownColor]];
	[titleLabel setLineBreakMode:UILineBreakModeWordWrap];
	[titleLabel setNumberOfLines:3];
	[titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    //[cell.contentView addSubview:ratingView];
    //[ratingView release];
    return cell;
}

#pragma mark -
#pragma mark search methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
	[searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	//NSString *searchText = [NSString stringWithString:dataSearchBar.text];
	
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[self searchStringWithString:searchText];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}
-(void)searchStringWithString:(NSString*)search{
	
    if (search>0) {
        
        [appDel.arrSearchData removeAllObjects];
        NSDictionary *dic;
        for(dic in classArray)
        {
            NSString *st = [[NSString alloc] initWithFormat:@"%@",[dic valueForKey:@"research_center_name"]];
			
            NSRange rang =[st rangeOfString:search options:NSCaseInsensitiveSearch];
            
            if (rang.length == [search length]) 
			{
                [appDel.arrSearchData addObject:dic];
            }
			else
			{
                [appDel.arrSearchData removeObject:dic];
            }
        }
        [tblView reloadData];
    }else {
        [appDel.arrSearchData removeAllObjects];
        [appDel.arrSearchData addObjectsFromArray:classArray];
        [tblView reloadData];
    }
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[[NSUserDefaults standardUserDefaults] setValue:[[appDel.arrSearchData objectAtIndex:indexPath.row] valueForKey:@"research_center_id"] forKey:@"selectedUser"];
	[[NSUserDefaults standardUserDefaults] synchronize];

    [srchBar resignFirstResponder];
	
	DetailViewController *obj = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
	[self.navigationController pushViewController:obj animated:YES];
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [indicator release];
    indicator = nil;
    [titleLabel release];
    titleLabel = nil;
    [custmCell release];
    custmCell = nil;
    [strBtn5 release];
    strBtn5 = nil;
    [strBtn4 release];
    strBtn4 = nil;
    [strBtn3 release];
    strBtn3 = nil;
    [strBtn2 release];
    strBtn2 = nil;
    [strBtn1 release];
    strBtn1 = nil;
    [ratingView release];
    ratingView = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [ratingView release];
    [strBtn1 release];
    [strBtn2 release];
    [strBtn3 release];
    [strBtn4 release];
    [strBtn5 release];
    [custmCell release];
    [titleLabel release];
    [indicator release];
    [super dealloc];
}

- (IBAction)starBtnPressed:(UIButton*)sender {
    
    switch (sender.tag) {
            
        case 1:{
          
            [ratingArry replaceObjectAtIndex:[sender superview].tag withObject:@"1"];

            break;
        }
            
        case 2:{
           
            [ratingArry replaceObjectAtIndex:[sender superview].tag withObject:@"2"];

            break;
        }
            
        case 3:{
           
            [ratingArry replaceObjectAtIndex:[sender superview].tag withObject:@"3"];

            break;
        }
            
        case 4:{
          
            [ratingArry replaceObjectAtIndex:[sender superview].tag withObject:@"4"];

            break;
        }
            
        case 5:{
          
            [ratingArry replaceObjectAtIndex:[sender superview].tag withObject:@"5"];

            break;
        }
            
        default:
            break;
    }

    
    NSString *str = [NSString stringWithFormat:@"%@",[[appDel.arrSearchData objectAtIndex:[sender superview].tag] valueForKey:@"research_center_id"]];
    
    NSLog(@" %@ reteView  %d    sender   %d",str,[sender superview].tag,sender.tag);

    [indicator startAnimating];
    
    NSURL *urlSt = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/add_rating.php?research_center_id=%@&urating=%d",str,sender.tag]];
    
    [tblView reloadData];
    [self performSelectorInBackground:@selector(ratingWSCall:) withObject:urlSt];
    
}

-(void)ratingWSCall:(NSURL*)url
{

    NSString *strUrl = [NSString   stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];    
    [indicator stopAnimating];
    NSLog(@"%@",strUrl);

}

@end
