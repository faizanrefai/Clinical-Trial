//
//  AvailableClinical.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailableClinical.h"


@implementation AvailableClinical
@synthesize srchBar,tblView,myCell,txtView;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	self.navigationController.navigationBarHidden = TRUE;
	//self.navigationItem.title = @"Clinical Trials";
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	NSString *centerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedUser"];
	[AlertHandler showAlertForProcess];
    
	NSString *urlString = [NSString stringWithFormat:@"http://openxcelluk.info/clinical/web_services/list_trial.php?research_center_id=%@",centerID];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
    parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
}
-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)detailClicked:(id)sender;
{
	UIButton *btn = (UIButton *)sender;
	
	[srchBar resignFirstResponder];
	
	[[NSUserDefaults standardUserDefaults] setInteger:btn.tag forKey:@"clinicalTag"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	clinicalDetail *obj = [[clinicalDetail alloc] initWithNibName:@"clinicalDetail" bundle:nil];
	[self.navigationController pushViewController:obj animated:YES];
	[obj release];
}


-(void)searchResult:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
	//NSLog(@"%@",dictionary);
	dataDict = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
	appDel.dictTrailsListMain = [dictionary copy];
	[tblView reloadData];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [[[appDel.dictTrailsListMain valueForKey:@"trials"] allKeys] count];;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[[NSBundle mainBundle] loadNibNamed:@"custTrailCell" owner:self options:nil];
		cell=self.myCell;
		self.myCell=nil;
    }
	
	btnDisclosure.tag = indexPath.row;
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	NSString *key = [NSString stringWithFormat:@"trail%d",indexPath.row+1];
    NSString *str = [NSString stringWithFormat:@"%@",[[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"]];
	txtView.text=str;
	[txtView setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
	[txtView setTextColor:[UIColor brownColor]];
	
	//cell.textLabel.text=str;
//	cell.textColor = [UIColor brownColor];
//	[cell.textLabel setLineBreakMode:UILineBreakModeWordWrap];
//	[cell.textLabel setNumberOfLines:3];
//	[cell.textLabel setFont:[UIFont fontWithName:@"Marker Felt" size:19]];
	// Configure the cell.
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [srchBar resignFirstResponder];
	
	[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"clinicalTag"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	clinicalDetail *obj = [[clinicalDetail alloc] initWithNibName:@"clinicalDetail" bundle:nil];
	[self.navigationController pushViewController:obj animated:YES];
	[obj release];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[srchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
