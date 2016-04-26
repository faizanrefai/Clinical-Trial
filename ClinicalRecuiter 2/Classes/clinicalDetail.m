//
//  clinicalDetail.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "clinicalDetail.h"
#import "DAL.h"


@implementation clinicalDetail
@synthesize txtCreiteria,txtCompansation,scrlView,imgCriteriaBack,imgTitleBack,lblCriteria,imgMainBack,lblCompansation;
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
	//self.navigationItem.title=@"Trail Detail";
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	//scrlView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Shape.png"]];
}
-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	
    
    int keyTag = [[[NSUserDefaults standardUserDefaults] valueForKey:@"clinicalTag"] intValue];
	NSString *key = [NSString stringWithFormat:@"trail%d",keyTag+1];

	NSString *strTitle = [[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"];
	
    txtCompansation.text=[[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"compensation"];
    
	if ([txtCompansation.text length]==0 || [txtCompansation.text isEqualToString:@"(null)"])
	{
        lblCompansation.hidden=TRUE;
        txtCompansation.hidden=TRUE;
		imgCom.hidden=TRUE;
	}
	else
	{
        lblCompansation.hidden=FALSE;
        txtCompansation.hidden=FALSE;
		imgCom.hidden=FALSE;
	}
	
    NSString *imgStr =[[[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"upload_ad"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    irbAdImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgStr]]];
    
	irbNolabel.text=[[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"approveno"];
	
    lblName.text= strTitle;
	txtCompansation.text=[[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"compensation"];
	start.text = [[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"duration"];
	end.text = [[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"study_visit"];
	
	NSString *baseCriteria = [NSString stringWithFormat:@"%@",[[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"criteria"]];
	NSArray *arr = [baseCriteria componentsSeparatedByString:@","];
	txtCreiteria.text = [arr objectAtIndex:0];
	
	CGSize constraint = CGSizeMake(260.0, 20000.0f);
	CGSize size = [strTitle sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	
	
	NSString *strDesc= [[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"title_description"];
	
	lblDesc.text=strDesc;
	CGSize size1 = [strDesc sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    [lblDesc.layer setBorderColor:[UIColor colorWithRed:108.0/255.0 green:143.00/255.0 blue:168.0/255.0 alpha:1].CGColor];
    [lblDesc.layer setBorderWidth:2.0];
    lblDesc.layer.cornerRadius =5.0;
    
	   
	lblInvestiName.text = [[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"investigator_name"];
    
    [txtCreiteria setUserInteractionEnabled:NO];
	
	for (int i=1; i<[arr count]; i++)
	{
		imgNew = [[UIImageView alloc] initWithFrame:CGRectMake(97,32+size.height+40+size1.height+37+10+(i*40),187,31)];
		[imgNew setImage:[UIImage imageNamed:@"full_txt.png"]];
		[imgNew setTag:i];
		[self.scrlView addSubview:imgNew];
		
		txtField = [[UITextField alloc] initWithFrame:CGRectMake(102,32+size.height+40+size1.height+37+18+(i*40),174,31)];
		txtField.delegate=self;
		[txtField setTag:i];
		[txtField setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
		[txtField setText:[arr objectAtIndex:i]];
		[txtField setBorderStyle:UITextBorderStyleNone];
		[txtField setUserInteractionEnabled:NO];
		[self.scrlView addSubview:txtField];
	}
	
	int countCriteria = [arr count]-1;
	
	[staticView setFrame:CGRectMake(17,100+12+size.height+10+10+size1.height+37+10+10+(countCriteria*40), staticView.frame.size.width, staticView.frame.size.height)];
	[imgMainBack setFrame:CGRectMake(0,0,298,450+12+size.height+10+10+size1.height+37+10+10+(countCriteria*40))];
	scrlView.contentSize = CGSizeMake(298, 450+12+size.height+10+10+size1.height+37+10+10+(countCriteria*40));
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction) mailBtnPressed:(id)sender
{
	DetailMail *objDetailmail=[[DetailMail alloc]initWithNibName:@"DetailMail" bundle:nil];
    [self.navigationController pushViewController:objDetailmail animated:YES];
	
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [lblDesc release];
    lblDesc = nil;
        [lblCompansation release];
    lblCompansation = nil;
    [irbNolabel release];
    irbNolabel = nil;
    [irbAdImage release];
    irbAdImage = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [lblDesc release];
    [lblCompansation release];
    [irbNolabel release];
    [irbAdImage release];
        [super dealloc];
}


@end
