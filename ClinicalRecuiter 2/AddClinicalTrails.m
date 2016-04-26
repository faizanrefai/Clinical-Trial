//
//  AddClinicalTrails.m
//  ClinicalRecuiter
//
//  Created by Hirak on 1/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AddClinicalTrails.h"
#import "NSDataAdditions.h"

static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;

@implementation AddClinicalTrails
@synthesize TxtCritearea;

@synthesize txtTitle,txtName,txtView,scrlView,txtFrom,txtTo,txtDesc,txtIRBNum;
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
	//self.navigationItem.title=@"Add Trails";
	myView_arr =[[NSMutableArray alloc]init];
	
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	[tempDict setObject:@"" forKey:@"text"];
	
	[myView_arr addObject:tempDict];
    
    
    txtView.inputAccessoryView = toolbar;
	
	[tempDict release];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	
	centerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userProfileID"];
	centerName = [[NSUserDefaults standardUserDefaults] valueForKey:@"centerName"];
	//arrCriteria = [[NSMutableArray alloc] init];
	
	self.scrlView.contentSize = CGSizeMake(320, 650);
	appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	fieldCount=1;
	[btnRemove setHidden:YES];
	
	[txtView setHidden:TRUE];
	[imgCompBack setHidden:TRUE];
	
	txtTitle.text=@"";
	txtView.text=@"";
	txtFrom.text=@"";
	txtTo.text=@"";
	txtName.text=@"";
}

-(IBAction)backClicked:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	
	if (appDel.isEditTrail==TRUE)
	{
		int keyTag = [[[NSUserDefaults standardUserDefaults] valueForKey:@"editTag"] intValue];
		NSString *key = [NSString stringWithFormat:@"trail%d",keyTag+1];
		
		NSString *cri = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"criteria"];
		
		arr11 = [[cri componentsSeparatedByString:@","] retain];
		arrCriteria = [[NSMutableArray alloc] initWithArray:arr11];
		txtTitle.text=[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"];
		txtView.text=[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"compensation"];
		trailID =[[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_id"];
		
		startDate = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"start_date"];
		endDate = [[[appDel.dictTrailsList valueForKey:@"trials"] valueForKey:key] valueForKey:@"end_date"];
		txtFrom.text=startDate;
		txtTo.text=endDate;

	}
	else
	{
		arrCriteria = [[NSMutableArray alloc] init];
	}

}




-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

   
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [string rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textField.text.length + string.length > 26){
        if (location != NSNotFound){
            [textField resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
    
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
    [txtField becomeFirstResponder];

	btnAdd.frame = CGRectMake(171, 204+(fieldCount*40), 54, 24);
	btnRemove.frame = CGRectMake(233, 204+(fieldCount*40), 66, 24);
	staticView.frame = CGRectMake(9, 252+(fieldCount*40), 298, 334);
	imgMain.frame =CGRectMake(9, 10, 300,596+(fieldCount*40));
	
	self.scrlView.contentSize = CGSizeMake(320, 900+(fieldCount*40));
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
	imgMain.frame =CGRectMake(9, 10, 300,596+(fieldCount*40));
	
	self.scrlView.contentSize = CGSizeMake(320, 800+(fieldCount*40));
	[myView_arr removeLastObject];
	
	fieldCount++;
	
	if(fieldCount==1)
	{
		[btnRemove setHidden:YES];
	}
}

- (IBAction)backPress:(id)sender {
    
    [txtView resignFirstResponder];
    
}

-(IBAction)addClicked:(id)sender
{
	
        
    if ([txtTitle.text isEqualToString: @""]||[txtName.text isEqualToString: @""]||[txtIRBNum.text isEqualToString: @""]||[txtTitle.text isEqualToString: @""]||[txtFrom.text isEqualToString: @""]||[txtDesc.text isEqualToString: @""]||[txtTo.text isEqualToString: @""]){   
   
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Fill In All Details." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    
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
	
	NSString *imageData =[dataImg base64Encoding];
	
	NSString *c11 = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)imageData, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	////////////////////////////
	NSString *post =[NSString stringWithFormat:@"research_center_id=%@&trial_title=%@&title_description=%@&investigator_name=%@&criteria=%@&approveno=%@&upload_ad=try.jpg&upload_ad_code=%@&compensation=%@&duration=%@&study_visit=%@",centerID,txtTitle.text,txtDesc.text,txtName.text,criteriaSTR,txtIRBNum.text,c11,txtView.text,txtFrom.text,txtTo.text];
	
	NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:@"http://openxcelluk.info/clinical/web_services/add_trial.php"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	// [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSError *error;
	NSURLResponse *response;
	NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
	
	NSMutableDictionary *temp = [data JSONValue];
	NSLog(@"%@",temp);
	
	//NSString *msg = [temp valueForKey:@"msg"];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"Trial Added Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	alert.tag =1;
	[alert show];
	[alert release];
	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(alertView.tag == 1){
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}

-(void)searchResult:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	NSString *msg = [dictionary valueForKey:@"msg"];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(IBAction) btnUpload:(id)sender
{
    UIActionSheet *actionsheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library",nil];
	actionsheet.tag=1;
	[actionsheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
	[actionsheet showInView:self.view];
	[actionsheet release];
}
- (void) actionSheet:(UIActionSheet *)actionsheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (actionsheet.tag==1)
	{
		if (buttonIndex == 0) {
			UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
			imagePicker.delegate = self;
			imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
			imagePicker.editing=NO;
			
			[self presentModalViewController:imagePicker animated:YES];
			
			[imagePicker release];
		}        
		if(buttonIndex ==1) {
			UIImagePickerController *picker;
			picker = [[UIImagePickerController alloc]init];
			picker.delegate = self;
			picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			picker.editing=NO;
			
			
			[self presentModalViewController:picker animated:YES];
		}
	}
	else if (actionsheet.tag==2)
	{
		
		if (buttonIndex==0)
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
			
			NSString *imageData =[dataImg base64Encoding];
			
			NSString *c11 = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)imageData, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
			
			////////////////////////////
			NSString *post =[NSString stringWithFormat:@"research_center_id=%@&trial_title=%@&title_description=%@&investigator_name=%@&criteria=%@&approveno=%@&upload_ad=try.jpg&upload_ad_code=%@&compensation=%@&duration=%@&study_visit=%@",centerID,txtTitle.text,txtDesc.text,txtName.text,criteriaSTR,txtIRBNum.text,c11,txtView.text,txtFrom.text,txtTo.text];
			
			NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
			
			
			NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
			
			NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
			[request setURL:[NSURL URLWithString:@"http://openxcelluk.info/clinical/web_services/add_trial.php"]];
			[request setHTTPMethod:@"POST"];
			[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
			[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
			// [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
			[request setHTTPBody:postData];
			
			NSError *error;
			NSURLResponse *response;
			NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
			NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
			
			NSMutableDictionary *temp = [data JSONValue];
			NSLog(@"%@",temp);
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Trial Added Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else if (buttonIndex==1)
		{
			
		}
		else if (buttonIndex==2)
		{
			
		}
		else
		{
			
		}
		
	}

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    [picker dismissModalViewControllerAnimated:YES];
	
	UIImage *image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
	
	dataImg = [UIImageJPEGRepresentation(image, 0.45) retain];
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



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[txtTo resignFirstResponder];
	[txtFrom resignFirstResponder];
	[txtName resignFirstResponder];
	[txtView resignFirstResponder];
	[txtDesc resignFirstResponder];
	[txtIRBNum resignFirstResponder];
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
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setTxtCritearea:nil];
    [toolbar release];
    toolbar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [TxtCritearea release];
    [toolbar release];
    [super dealloc];
}


@end
