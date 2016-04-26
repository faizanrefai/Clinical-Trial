//
//  JoinAsPatient.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailMail.h"
#import "JSON.h"
#import "JSONParser.h"


@implementation DetailMail
@synthesize patName,patAdd,patMob,patEmail;
@synthesize txtView,scrlView,patAdd2,patHome,txtCaptcha,txtCaptchaName,strNewEntry,pickerDictionaryArray,stringSelIntrestId,arr11,pickeArray,selectionStates,reserchCenterDic;



- (void)dealloc {
    [pickerDictionaryArray release];
    [cancelButtonAgreementView release];
    [btnTextViewStudyInterest release];
    [reserchCenterDic release];
    [super dealloc];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
   
	appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
   
    arrSavedData = [[NSMutableArray alloc] init];

    stringSelIntrestId= [[NSMutableString alloc]init];

    strNewEntry= [[[NSString alloc]init]retain];
   	self.navigationController.navigationBar.hidden=FALSE;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	scrlView.contentSize = CGSizeMake(320,550);
	
	   
    //  Web Service Calling Start For Study Interest ID and List.

    
        
    
    //  Web Service Calling End For Study Interest ID and List.

    
        pickeArray = [[NSMutableArray alloc]init];
        ALpicker = [[ALPickerView alloc] init];
        ALpicker.delegate = self;

        selectionStates = [[NSMutableDictionary alloc] init];
        dictUserData = [[NSMutableDictionary alloc] init];
        arr11 = [[NSMutableArray alloc] init];

        
        [txtView setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        [txtView setTextAlignment:UITextAlignmentLeft];
	
       
    
        
}


-(IBAction)cancelButtonAgreementView{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    int keyTag = [[[NSUserDefaults standardUserDefaults] valueForKey:@"clinicalTag"] intValue];
	NSString *key = [NSString stringWithFormat:@"trail%d",keyTag+1];
    
	NSString *strTitle = [[[appDel.dictTrailsListMain valueForKey:@"trials"] valueForKey:key] valueForKey:@"trial_title"];
		
    patName.text  = @"";
		patAdd.text   = @""; 
		patAdd2.text  = @"";
		patHome.text  = @"";
		patMob.text   = @"";
		patEmail.text = @"";
		dateFromString= @"";
		
    txtView.text  = strTitle;
		
    [btnDOB setTitle:@"Select" forState:UIControlStateNormal];
		
}

-(IBAction)historyClicked:(id)sender
{
	[self resignResponderText];
	
    UIActionSheet *pickHistory = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	pickHistory.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	pickHistory.tag = 1;
	[pickHistory setBounds:CGRectMake(0, 0, 320, 250)];
	[pickHistory addSubview:ALpicker];
	[pickHistory showInView:self.tabBarController.view];
}





-(IBAction)patCancelclicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
       
}
- (BOOL)validateEmailWithString:(NSString*)email11
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email11];
}




-(IBAction)patAddClicked:(id)sender
{
	// Email Button Clicked

    
    NSString *msgalrt =@"";
    if([patName.text isEqualToString:@""]){
		msgalrt =@"Enter Name";
	}
    	else if([patAdd.text isEqualToString:@""]){
		msgalrt =@"Enter AddressLine1";
	}
	else if([patAdd.text isEqualToString:@""]){
		msgalrt =@"Enter AddressLine2";
	}
	else if([patHome.text isEqualToString:@""]){
		msgalrt =@"Enter PhoneNumber";
	}
	else if([patEmail.text isEqualToString:@""]){
		msgalrt =@"Enter Email";
	}
	else if(![self validateEmailWithString:patEmail.text]){
		msgalrt =@"Enter Valid Email";
	}
	
	if(![msgalrt isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"warning" message:msgalrt delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];

	}
	else{
        
		
		[dictUserData setObject:patName.text forKey:@"name"];
		[dictUserData setObject:patAdd.text forKey:@"address1"];
		[dictUserData setObject:patAdd2.text forKey:@"address2"];
		[dictUserData setObject:patHome.text forKey:@"home"];
		[dictUserData setObject:patMob.text forKey:@"mobile"];
		[dictUserData setObject:patEmail.text forKey:@"email"];
		[dictUserData setObject:dateFromString forKey:@"birthdate"];
		[dictUserData setObject:txtView.text forKey:@"study_interest"];
				
        //	NSLog(@"%@",dictUserData);
        
        [self upLoadDetail];
        
    }
	
	
}


#pragma mark -
#pragma mark  Upload Patient Detail delegate methods

-(void)upLoadDetail{

    [AlertHandler showAlertForProcess];
    
    NSString *add1=[[NSString alloc]init];
    NSString *add2=[[NSString alloc]init];
    NSString *name=[[NSString alloc]init];
    NSString *studyIntrst=[[NSString alloc]init];
  
    name = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",patName.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    add1 = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",patAdd.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    add2 = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",patAdd2.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    studyIntrst  = (NSMutableString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSMutableString stringWithFormat:@"%@",txtView.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    
    
    NSString *stateUrl=[[NSString alloc ]initWithFormat:@"http://openxcelluk.info/clinical/web_services/send_email.php?research_center_id=%@&full_name=%@&add1=%@&add2=%@&home_contact_no=%@&mobile_no=%@&email=%@&dob=%@&study_interest=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"reserchCenterId"],name,add1,add2,patHome.text,patMob.text,patEmail.text,dateFromString,studyIntrst];

    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl]];
    JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(responseresult:) andHandler:self];
    NSLog(@"%@",parser);
    
    [add1 release];
    [add2 release];
    [name release];
    [stateUrl release];
    [studyIntrst release];
   
}


-(void)responseresult:(NSDictionary *)dictinory{

    [AlertHandler hideAlert]; 
//    NSLog(@"%@",dictinory);

    if ([[dictinory valueForKey:@"msg" ]isEqualToString:@"mail sent"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Email Sent!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
               
        }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email Was Not Sent! Please Retry." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
   
}


-(IBAction)dateOfBirthClicked:(id)sender
{
	[self resignResponderText];
	UIActionSheet *pickTime = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	pickTime.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	pickTime.tag = 2;
	[pickTime setBounds:CGRectMake(0, 0, 320, 250)];
	dtPicker = [[UIDatePicker alloc] init];
	dtPicker.datePickerMode = UIDatePickerModeDate;
	dtPicker.maximumDate = [NSDate date];
	[pickTime addSubview:dtPicker];
	[pickTime showInView:self.tabBarController.view];
}

-(void)resignResponderText{
   
	[patName resignFirstResponder];	
	[patAdd resignFirstResponder];	
	[patAdd2 resignFirstResponder];	
	[patHome resignFirstResponder];	
	[patMob resignFirstResponder];
	[patEmail resignFirstResponder];


}


#pragma mark -
#pragma mark Action Sheet delegate methods




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	 if (actionSheet.tag ==2)
	{
		if (buttonIndex == 0)
		{
			NSDate *tempDate = dtPicker.date;
			NSDate *temp = [tempDate addTimeInterval:(1.0*60*60*24)];
			
			//NSLog(@"%@",temp);
			NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
			NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
			[dateFormatter setDateFormat:@"yyyy-MM-dd"];
			[dateFormatter setTimeZone:gmt];
			
			dateFromString = [[dateFormatter stringFromDate:temp]retain];
		//	NSLog(@"%@",dateFromString);
			//NSString *str = [NSString stringWithFormat:@"%@",dtPicker.date];
			//		str = [[str componentsSeparatedByString:@" "] objectAtIndex:0];
			[btnDOB setTitle:dateFromString forState:UIControlStateNormal];
		}
	}
	else if(actionSheet.tag==1)
	{
		if (buttonIndex == 0)
		{
			NSMutableArray *myseleEntry =[[NSMutableArray  alloc]init];
			for (int i=0; i <[pickeArray count]; i++)
			{
				NSString *myc_str =[pickeArray objectAtIndex:i];
				for(NSString *s in arr11){
					if([s isEqualToString:myc_str])
						[myseleEntry addObject:[NSString stringWithFormat:@"%d",i]];
				}
			}
		//	NSLog(@"Faizan %@",myseleEntry);
			
			NSMutableArray *newSelected = [[NSMutableArray alloc] init];
            NSMutableArray *newSelectedId = [[NSMutableArray alloc] init];
			for (int j=0; j<[myseleEntry count]; j++)
			{
				[newSelected addObject:[pickeArray objectAtIndex:[[myseleEntry objectAtIndex:j]intValue]]];
                [newSelectedId addObject:[pickerDictionaryArray objectAtIndex:[[myseleEntry objectAtIndex:j]intValue]]];
                
			}
		//	NSLog(@"%@",newSelected);
          //  NSLog(@"F %@",newSelectedId);

			strNewEntry =@"";
            
			for (int i=0; i<[newSelected count]; i++)
			{
				if (i==[newSelected count]-1)
				{
					strNewEntry = [strNewEntry stringByAppendingString:[NSString stringWithFormat:@"%@",[newSelected objectAtIndex:i]]];
                    stringSelIntrestId =[[stringSelIntrestId stringByAppendingString:[NSString stringWithFormat:@"%@",[[newSelectedId objectAtIndex:i]valueForKey:@"id"]]]retain];
				}
				else
				{
					strNewEntry = [strNewEntry stringByAppendingString:[NSString stringWithFormat:@"%@,",[newSelected objectAtIndex:i]]];
                    stringSelIntrestId= [[stringSelIntrestId stringByAppendingString:[NSString stringWithFormat:@"%@,",[[newSelectedId objectAtIndex:i]valueForKey:@"id"]]]retain];
				}
			}
		
            
            
			[txtView setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
			[txtView setTextAlignment:UITextAlignmentLeft];
			txtView.text = strNewEntry;
		}
        
        if ([txtView.text length]==0) {
           
            txtView.text = @"Study Interest";
        }
	}
}


#pragma mark -
#pragma mark Text Field delegate methods


- (void)textFieldDidBeginEditing:(UITextField *)textField 
{	
    patName.autocapitalizationType=UITextAutocapitalizationTypeWords;
    
    if (textField ==patName||textField==patAdd) {
        
    }else{
        [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField ==patName||textField==patAdd) {
        
    }else{
    [self animateTextField:textField up:NO];
    }
}

- (void)animateTextField:(UITextField*) textField up: (BOOL) up {
	
	int movementDistance = 120; 
	float movementDuration = 0.3f; 
	int movement = (up ? -movementDistance : movementDistance);	
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[patAdd resignFirstResponder];
	[patName resignFirstResponder];
	[patMob resignFirstResponder];
	[patEmail resignFirstResponder];
  	return YES;
}



-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if (textView.tag==0) {
        [self performSelector:@selector(keyboardRemove:) withObject:textView afterDelay:0.01]; 
    }
    
}
-(void)keyboardRemove:(id)sender{
    
    [sender resignFirstResponder];
    UIActionSheet *pickHistory = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	pickHistory.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	pickHistory.tag = 1;
	[pickHistory setBounds:CGRectMake(0, 0, 320, 250)];
	[pickHistory addSubview:ALpicker];
	[pickHistory showInView:self.tabBarController.view];
    
}



#pragma mark -
#pragma mark ALPickerView delegate methods

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView {
	return [pickeArray count];
}

- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row {
	return [pickeArray objectAtIndex:row];
}

- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row 
{
	for (NSString *key in pickeArray)
    {
        NSString *st = [NSString stringWithFormat:@"%@",[selectionStates objectForKey:key]];
		
        if([st isEqualToString:@"1"])
		{
			if(![arr11 containsObject:key])
                [arr11 addObject:key];
		}
        
        if([st isEqualToString:@"0"])
        {
            if([arr11 containsObject:key])
                [arr11 removeObject:key];
			
        }
    }
//	NSLog(@"%@",arr11);
	return [[selectionStates objectForKey:[pickeArray objectAtIndex:row]] boolValue];
}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row {
	// Check whether all rows are checked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[pickeArray objectAtIndex:row]];
	
}

- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row {
	// Check whether all rows are unchecked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[pickeArray objectAtIndex:row]];
}




- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
          [cancelButtonAgreementView release];
    cancelButtonAgreementView = nil;
    [btnTextViewStudyInterest release];
    btnTextViewStudyInterest = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
