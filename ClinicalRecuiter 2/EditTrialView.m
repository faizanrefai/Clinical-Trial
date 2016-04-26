//
//  EditTrialView.m
//  ClinicalRecuiter
//
//  Created by Hirak on 1/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EditTrialView.h"

static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;

@implementation EditTrialView

@synthesize txtTitle,txtName,txtView,scrlView,txtFrom,txtTo,txtDesc;

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
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	self.scrlView.contentSize = CGSizeMake(320, 720);
	appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	
	NSLog(@"NEw:%@",appDel.dictTrailsList);
	
	myView_arr =[[NSMutableArray alloc]init];
	
	centerName = [[NSUserDefaults standardUserDefaults] valueForKey:@"centerName"];
	//txtName.text=centerName;
//	txtName.userInteractionEnabled = NO;
	
	int keyTag = [[[NSUserDefaults standardUserDefaults] valueForKey:@"editTag"] intValue];
	NSString *key = [NSString stringWithFormat:@"trail%d",keyTag+1];
	
	NSString *strTitle = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"];
	txtTitle.text= strTitle;
	txtFrom.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"duration"];
	txtTo.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"study_visit"];	
	txtName.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"investigator_name"];	 
	NSString *strDesc = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"title_description"];
	txtDesc.text= strDesc;
	
	trailID =[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_id"];
	
	txtView.text=[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"compensation"];
	if ([txtView.text length]==0)
	{
		[btnNo setSelected:YES];
		[txtView setHidden:TRUE];
		[imgCompBack setHidden:TRUE];
	}
	else
	{
		[btnYes setSelected:YES];
		[txtView setHidden:FALSE];
		[imgCompBack setHidden:FALSE];
	}

	//txtFrom.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"start_date"];
//	txtTo.text = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"end_date"];
	
	NSString *baseCriteria = [NSString stringWithFormat:@"%@",[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"criteria"]];
	NSArray *arr = [baseCriteria componentsSeparatedByString:@","];
	txtCreiteria.text = [arr objectAtIndex:0];
	txtCreiteria.tag = 0;
	
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	[tempDict setObject:txtCreiteria.text forKey:@"text"];
	
	[myView_arr addObject:tempDict];
	
	for (int i=1; i<[arr count]; i++)
	{
		imgNew = [[UIImageView alloc] initWithFrame:CGRectMake(118,162+(i*40),181,36)];
		[imgNew setImage:[UIImage imageNamed:@"full_txt.png"]];
		[imgNew setTag:i];
		[self.scrlView addSubview:imgNew];
		
		txtField = [[UITextField alloc] initWithFrame:CGRectMake(126,172+(i*40),173,31)];
		[txtField setDelegate:self];
		[txtField setTag:i];
		[txtField setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
		[txtField setText:[arr objectAtIndex:i]];
		[txtField setBorderStyle:UITextBorderStyleNone];
		//[txtField setUserInteractionEnabled:NO];
		[self.scrlView addSubview:txtField];
		
		fieldCount=i+1;
		NSMutableDictionary *t_dic =[[NSMutableDictionary alloc]init];
		[t_dic setObject:imgNew forKey:@"img_view"];
		[t_dic setObject:txtField forKey:@"txt_view"];
		[t_dic setObject:[arr objectAtIndex:i] forKey:@"text"];
		
		[myView_arr addObject:t_dic];
		[t_dic release];
	}
	
	int countCriteria;
	if ([arr count]>0)
	{
		countCriteria = [arr count]-1;
	}
	else
	{
		countCriteria = 0;
	}
	
	[btnAdd setFrame:CGRectMake(171, 204+(countCriteria*40), 54, 24)];
	[btnRemove setFrame:CGRectMake(233, 204+(countCriteria*40), 66, 24)];
	[staticView setFrame:CGRectMake(9, 236+(countCriteria*40), 298, 237)];
	[imgMain setFrame:CGRectMake(9,10,300,496+(countCriteria*40))];
	scrlView.contentSize = CGSizeMake(298,720+(countCriteria*40));
}

-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)addCriteriaClicked:(id)sender
{
	[btnRemove setHidden:NO];
	
	imgNew = [[UIImageView alloc] initWithFrame:CGRectMake(118, 162+(fieldCount*40), 181, 36)];
	[imgNew setImage:[UIImage imageNamed:@"full_txt.png"]];
	[imgNew setTag:fieldCount];
	[self.scrlView addSubview:imgNew];
	
	txtField = [[UITextField alloc] initWithFrame:CGRectMake(126,172+(fieldCount*40),173,31)];
	[txtField setDelegate:self];
	[txtField setTag:fieldCount];
	[txtField setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
	[txtField setPlaceholder:@"Criteria"];
	[txtField setBorderStyle:UITextBorderStyleNone];
	[self.scrlView addSubview:txtField];
	
	btnAdd.frame = CGRectMake(171, 204+(fieldCount*40), 54, 24);
	btnRemove.frame = CGRectMake(233, 204+(fieldCount*40), 66, 24);
	staticView.frame = CGRectMake(9, 252+(fieldCount*40), 298, 334);
	imgMain.frame =CGRectMake(9, 10, 300,496+(fieldCount*40));
	
	self.scrlView.contentSize = CGSizeMake(320,750+(fieldCount*40));
	fieldCount++;
	NSMutableDictionary *t_dic =[[NSMutableDictionary alloc]init];
	[t_dic setObject:imgNew forKey:@"img_view"];
	[t_dic setObject:txtField forKey:@"txt_view"];
	
	[myView_arr addObject:t_dic];
	[t_dic release];
}
-(IBAction)removeCriteriaClicked:(id)sender
{
	NSMutableDictionary *t_dic = [myView_arr objectAtIndex:[myView_arr count]-1];
	fieldCount = fieldCount-2;
	
	[[t_dic valueForKey:@"img_view"] removeFromSuperview];
	[[t_dic valueForKey:@"txt_view"] removeFromSuperview];
	
	btnAdd.frame = CGRectMake(171, 204+(fieldCount*40), 54, 24);
	btnRemove.frame = CGRectMake(233, 204+(fieldCount*40), 66, 24);
	staticView.frame = CGRectMake(9, 252+(fieldCount*40), 298, 334);
	imgMain.frame =CGRectMake(9, 10, 300,496+(fieldCount*40));
	
	self.scrlView.contentSize = CGSizeMake(320, 750+(fieldCount*40));
	[myView_arr removeLastObject];
	
	fieldCount++;
	
	if(fieldCount==1)
	{
		[btnRemove setHidden:YES];
	}
}

-(IBAction)addClicked:(id)sender
{
	NSString *criteriaSTR =@"";
	for (int i=0; i<[myView_arr count]; i++)
	{
		if (i==[myView_arr count]-1)
		{
			criteriaSTR = [criteriaSTR stringByAppendingString:[NSString stringWithFormat:@"%@",[[myView_arr objectAtIndex:i] valueForKey:@"text"]]];
		}
		else
		{
			criteriaSTR = [criteriaSTR stringByAppendingString:[NSString stringWithFormat:@"%@,",[[myView_arr objectAtIndex:i] valueForKey:@"text"]]];
		}
	}
	NSLog(@"%@",criteriaSTR);
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/edit_trial.php?trial_id=%@&trial_title=%@&title_description=%@&investigator_name=%@&criteria=%@&compensation=%@&duration=%@&study_visit=%@",trailID,txtTitle.text,txtDesc.text,txtName.text,criteriaSTR,txtView.text,txtFrom.text,txtTo.text];
	
	[AlertHandler showAlertForProcess];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];		
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
}

-(void)searchResult:(NSDictionary*)dictionary
{
	//[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	msg = [[dictionary valueForKey:@"msg"] retain];
	//[AlertHandler showAlertForProcess];
	NSString *centerID11 = [[NSUserDefaults standardUserDefaults] valueForKey:@"userProfileID"];
	NSString *urlString = [NSString stringWithFormat:@"http://openxcellaus.info/clinical/list_trial.php?research_center_id=%@",centerID11];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
    parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult1:) andHandler:self];
}
-(void)searchResult1:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
	[appDel.dictTrailsList release];
	appDel.dictTrailsList = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Trial Updated Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(IBAction)yesClicked:(id)sender
{
	if ([btnYes isSelected])
	{
		[btnYes setSelected:NO];
		[txtView setHidden:TRUE];
		[imgCompBack setHidden:TRUE];
	}
	else
	{
		[txtView setHidden:FALSE];
		[imgCompBack setHidden:FALSE];
		[btnYes setSelected:YES];
		[btnNo setSelected:NO];
	}
	
}
-(IBAction)noClicked:(id)sender
{
	if ([btnNo isSelected])
	{
		[btnNo setSelected:NO];
		[txtView setHidden:TRUE];
		[imgCompBack setHidden:TRUE];
	}
	else
	{
		[txtView setHidden:TRUE];
		[imgCompBack setHidden:TRUE];
		[btnYes setSelected:NO];
		[btnNo setSelected:YES];
	}
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	[txtFrom resignFirstResponder];
//	[txtTo resignFirstResponder];
//	
//	if (actionSheet.tag==1)
//	{
//		if (buttonIndex==0)
//		{
//			startDate = [NSString stringWithFormat:@"%@",pkrFrom.date];
//			startDate = [[startDate componentsSeparatedByString:@" "] objectAtIndex:0];
//			txtFrom.text=startDate;
//		}
//	}
//	else if (actionSheet.tag==2)
//	{
//		if (buttonIndex==0)
//		{
//			endDate = [NSString stringWithFormat:@"%@",pkrTo.date];
//			endDate = [[endDate componentsSeparatedByString:@" "] objectAtIndex:0];
//			txtTo.text=endDate;
//		}
//	}
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[txtTo resignFirstResponder];
	[txtFrom resignFirstResponder];
	[txtName resignFirstResponder];
	[txtView resignFirstResponder];
	[txtDesc resignFirstResponder];
	[txtTitle resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
	
	CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
	CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
	
	CGFloat midline = textFieldRect.origin.y +1.0 * textFieldRect.size.height;
	CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	animatedDistance = floor(162.0 * heightFraction);
	
	CGRect viewFrame =scrlView.frame;
	
	viewFrame.origin.y -= animatedDistance;
	
	[UIScrollView beginAnimations:nil context:NULL];
	[UIScrollView setAnimationBeginsFromCurrentState:YES];
	[UIScrollView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[self.scrlView setFrame:viewFrame];
	[UIScrollView commitAnimations];
	
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (textField.tag==111 || textField.tag==112 || textField.tag==113 || textField.tag==114 || textField.tag==115 || textField.tag==116)
	{
	}
	else 
	{
		if ([textField.text length]>0)
		{
			
			[[myView_arr objectAtIndex:textField.tag] setValue:textField.text forKey:@"text"];
		}
		else
		{
			[[myView_arr objectAtIndex:textField.tag] setValue:@"" forKey:@"text"];
		}
	}
	NSLog(@"%@",myView_arr);
		
	CGRect viewFrame = scrlView.frame;
	//self.view.frame;
	viewFrame.origin.y += animatedDistance;
	
	[UIScrollView beginAnimations:nil context:NULL];
	[UIScrollView setAnimationBeginsFromCurrentState:YES];
	[UIScrollView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[self.scrlView setFrame:viewFrame];
	
	[UIScrollView commitAnimations];
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
