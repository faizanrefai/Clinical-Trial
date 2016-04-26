//
//  ListTrails.m
//  ClinicalRecuiter
//
//  Created by Hirak on 1/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ListTrails.h"


@implementation ListTrails
@synthesize tblView,myCell,txtTitle;
@synthesize detailDic;

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
	//self.navigationItem.title=@"Trails";
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
    
    appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication] delegate];

    detailDic = [[NSMutableDictionary alloc]init];
    
	NSString *centerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userProfileID"];
	centerName = [[NSUserDefaults standardUserDefaults] valueForKey:@"centerName"];
	
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
-(void)searchResult:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
    
  
    


   // [appDel.dictTrailsList  removeAllObjects];
    
    appDel.dictTrailsList= [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    [detailDic removeAllObjects];
    
    [detailDic addEntriesFromDictionary:dictionary];
    
   // NSLog(@"appDel.dictTrailsList  %@",appDel.dictTrailsList);
    
  //  NSLog(@"%d",[[[appDel.dictTrailsList valueForKey:@"trials"] allKeys] count]);

	[tblView reloadData];
}
-(IBAction)detailClicked:(id)sender
{
	UIButton *btnE = (UIButton*)sender;
	
    [[NSUserDefaults standardUserDefaults] setInteger:btnE.tag forKey:@"editTag"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	TrialDetailsView *objTrial = [[TrialDetailsView alloc] initWithNibName:@"TrialDetailsView" bundle:nil];
	[self.navigationController pushViewController:objTrial animated:YES];
	//[objTrial release];
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[detailDic valueForKey:@"trials"] allKeys] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[[NSBundle mainBundle] loadNibNamed:@"newCustCell" owner:self options:nil];
		cell=self.myCell;
		self.myCell=nil;
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	btnDisclosure.tag = indexPath.row;
    
    
    if ([[[detailDic valueForKey:@"trials"] allKeys] count]) {
        
        
        NSString *key = [NSString stringWithFormat:@"trail%d",indexPath.row+1];
        NSString *str = [NSString stringWithFormat:@"%@",[[[detailDic valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"]];
        txtTitle.text=str;
        [txtTitle setTextColor:[UIColor brownColor]];

    }
	
		
	// Configure the cell.
    return cell;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
