//
//  TrialDetailsView.m
//  ClinicalRecuiter
//
//  Created by Hirak on 1/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TrialDetailsView.h"


@implementation TrialDetailsView

@synthesize txtCreiteria,txtCompansation,scrlView,imgCriteriaBack,imgTitleBack,lblCriteria,imgMainBack,imgCom;

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
	appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication] delegate];
	self.navigationItem.title=@"Trail Details";
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	
}
- (void)viewWillAppear:(BOOL)animated
{
	NSString *centerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userProfileID"];
	[AlertHandler showAlertForProcess];
	NSString *urlString = [NSString stringWithFormat:@"http://openxcelluk.info/clinical/web_services/list_trial.php?research_center_id=%@",centerID];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
    parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
}

-(void)searchResult:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	appDel.dictTrailsList = [dictionary copy];
	
	int keyTag = [[[NSUserDefaults standardUserDefaults] valueForKey:@"editTag"] intValue];
	key = [[NSString stringWithFormat:@"trail%d",keyTag+1] retain];
	NSString *strTitle = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"];
	NSString *strDesc = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"title_description"];
	
	lblName.text= strTitle;
	txtCompansation.text=[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"compensation"];
	
	if ([txtCompansation.text length]==0 || [txtCompansation.text isEqualToString:@"(null)"])
	{
		txtCompansation.hidden=TRUE;
		labelCompnsatin.hidden=TRUE;
		imgCom.hidden=TRUE;
	}
	else
	{
		txtCompansation.hidden=FALSE;
		labelCompnsatin.hidden=FALSE;
		imgCom.hidden=FALSE;
	}
	
    
    NSString *imgUrlStr = [[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"upload_ad"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    irbAdimage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlStr]]];
    
    irbTxtFld.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"approveno"];
    
    
	lblDuration.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"duration"];
	lblVisit.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"study_visit"];
	lblInvestiName.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"investigator_name"];
	lblDesc.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"title_description"];
	
	NSString *baseCriteria = [NSString stringWithFormat:@"%@",[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"criteria"]];
	NSArray *arr = [baseCriteria componentsSeparatedByString:@","];
	txtCreiteria.text = [arr objectAtIndex:0];
	
	CGSize constraint = CGSizeMake(260.0, 20000.0f);
	
	CGSize size = [strTitle sizeWithFont:[UIFont systemFontOfSize:30] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	
	[lblName setFrame:CGRectMake(17.0,10.0,260,size.height)];
	[imgTitleBack setFrame:CGRectMake(17.0,10.0,260,size.height)];
	
	CGSize constraint1 = CGSizeMake(260.0, 20000.0f);
	CGSize sizeNew = [strDesc sizeWithFont:[UIFont systemFontOfSize:30] constrainedToSize:constraint1 lineBreakMode:UILineBreakModeWordWrap];
	
	[lblDesc setFrame:CGRectMake(17,10+size.height+10,260 ,sizeNew.height)];
	[imgDescBack setFrame:CGRectMake(17,10+size.height+10,260 ,sizeNew.height)];
	
    
    
	[investigatorLabel setFrame:CGRectMake(13,10+size.height+10+sizeNew.height+15, 90, 21)];
	
    [lblInvestiName setFrame:CGRectMake(22+investigatorLabel.frame.size.width+10,10+size.height+10+sizeNew.height+15, 160, 21)];
	[imgInvestiBack setFrame:CGRectMake(13+investigatorLabel.frame.size.width+10,10+size.height+10+sizeNew.height+10, 160, 31)];
	
	[lblCriteria setFrame:CGRectMake(22,5+size.height+10+sizeNew.height+10+31+25+12,66,22)];
	[imgCriteriaBack setFrame:CGRectMake(96,5+size.height+10+sizeNew.height+31+10+30,187,31)];
	[txtCreiteria setFrame:CGRectMake(102,5+size.height+10+sizeNew.height+31+10+30,179,31)];
	
	[txtCreiteria setUserInteractionEnabled:NO];
	
	for (int i=1; i<[arr count]; i++)
	{
		imgNew = [[UIImageView alloc] initWithFrame:CGRectMake(96,10+size.height+10+sizeNew.height+31+10+30+(i*40),187,31)];
		[imgNew setImage:[UIImage imageNamed:@"full_txt.png"]];
		[imgNew setTag:i];
		[self.scrlView addSubview:imgNew];
		
		txtField = [[UITextField alloc] initWithFrame:CGRectMake(102,10+size.height+10+sizeNew.height+31+10+37+(i*40),179,31)];
		[txtField setDelegate:self];
		[txtField setTag:i];
		[txtField setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
		[txtField setText:[arr objectAtIndex:i]];
		[txtField setBorderStyle:UITextBorderStyleNone];
		[txtField setUserInteractionEnabled:NO];
		[self.scrlView addSubview:txtField];
	}
	
	int countCriteria = [arr count]-1;
	
	[staticView setFrame:CGRectMake(21,10+size.height+10+sizeNew.height+31+10+75+(countCriteria*40), staticView.frame.size.width, staticView.frame.size.height)];
	[imgMainBack setFrame:CGRectMake(0,0,298,200+10+size.height+10+sizeNew.height+320+(countCriteria*40))];
	scrlView.contentSize = CGSizeMake(298,300+10+size.height+10+sizeNew.height+31+10+320+(countCriteria*40));



}



-(IBAction)deleteClicked:(id)sender
{
	
	NSString *trailID = [NSString stringWithFormat:@"%@",[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_id"]];
	NSString *urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/delete_trial.php?trial_id=%@",trailID];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult2:) andHandler:self];
	
}

-(void)searchResult2:(NSDictionary*)dictionary
{
	NSLog(@"%@",dictionary);
	
	NSString *msg3 = [dictionary valueForKey:@"msg"];
		
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Trial Deleted Successfully!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
    
    if ([msg3 isEqualToString:@"trial deleted successfully"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction)deactiveClicked:(id)sender
{
	NSString *trailID = [NSString stringWithFormat:@"%@",[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_id"]];
	NSString *urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/deactivate_trial.php?trial_id=%@",trailID];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult1:) andHandler:self];
}

-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)searchResult1:(NSDictionary*)dictionary
{
	NSLog(@"%@",dictionary);
	
	NSString *msg2 = [dictionary valueForKey:@"msg"];
	
	if ([msg2 isEqualToString:@"Trial deactivated successfully"])
	{
		btnDeactive.hidden=TRUE;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Trial Deactivated Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(IBAction)editClicked:(id)sender
{
	EditTrialView *objEdit = [[EditTrialView alloc] initWithNibName:@"EditTrialView" bundle:nil];
	[self.navigationController pushViewController:objEdit animated:YES];
	[objEdit release];
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
    [investigatorLabel release];
    investigatorLabel = nil;
    [labelCompnsatin release];
    labelCompnsatin = nil;
    [irbLabel release];
    irbLabel = nil;
    [irbBackImage release];
    irbBackImage = nil;
    [irbTxtFld release];
    irbTxtFld = nil;
    [irbAdimage release];
    irbAdimage = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [investigatorLabel release];
    [labelCompnsatin release];
    [irbLabel release];
    [irbBackImage release];
    [irbTxtFld release];
    [irbAdimage release];
    [super dealloc];
}


@end
