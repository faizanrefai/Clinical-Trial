//
//  ProfileUpdateView.m
//  ClinicalRecuiter
//
//  Created by openxcell121 on 3/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileUpdateView.h"


@implementation ProfileUpdateView
@synthesize selectionStates;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    [selectionStates release];
    [arr11 release];
    [arrSavedData release];
    [pickerDataArray release];
    [editBtn release];
    [scrollView release];
    [txtName release];
    [txtAddress release];
    [txtAdd2 release];
    [txtAdd3 release];
    [txtmobile release];
    [txtHome release];
    [txtEmail release];
    [selectBtn release];
    [studyinterestBtn release];
    [studyInterestTxtView release];
    [cancelBtn release];
    [saveBtn release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark
#pragma mark - Text Field Delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return 0;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField 
{	
    
    txtName.autocapitalizationType=UITextAutocapitalizationTypeWords;
    if (textField ==txtName||textField==txtAddress ) {
        
    }else{
        [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField ==txtName||textField==txtAddress ) {
        
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
    ALpicker = [[ALPickerView alloc] init];
    ALpicker.delegate =self;
	[pickHistory addSubview:ALpicker];
	[pickHistory showInView:self.tabBarController.view];

}




#pragma mark
#pragma mark - Action Sheet Delegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(actionSheet.tag ==3)
	{
		if (buttonIndex == 0)
		{
            txtName.userInteractionEnabled  = YES;
			txtAddress.userInteractionEnabled   = YES;
			txtAdd2.userInteractionEnabled  = YES;
			txtAdd3.userInteractionEnabled  = YES;
			txtHome.userInteractionEnabled  = YES;
			txtmobile.userInteractionEnabled   = YES;
			txtEmail.userInteractionEnabled = YES;
			selectBtn.userInteractionEnabled   = YES;
			studyInterestTxtView.userInteractionEnabled  = YES;
			studyInterestTxtView.editable  = YES;
			studyinterestBtn.userInteractionEnabled=YES;
			
			saveBtn.hidden=FALSE;
			cancelBtn.hidden=FALSE;
		}
		else if (buttonIndex == 1)
		{
		
            [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"Patient_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController popToRootViewControllerAnimated:YES];
		
        }
	
    }
    
    //action sheet tag 3 finish

    else
    if (actionSheet.tag ==2)
	{
		if (buttonIndex == 0)
		{
            NSDate *tempDate = dtPicker.date;
        //    NSLog(@"%@ %@",temp,tempDate);
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateFromString = [[dateFormatter stringFromDate:tempDate]retain];
            [selectBtn setTitle:dateFromString forState:UIControlStateNormal];
		
        }

    }
    
    //action sheet tag 2 finish

    else
    if(actionSheet.tag==1)
	{
		if (buttonIndex == 0)
		{
			NSMutableArray *myseleEntry =[[NSMutableArray  alloc]init];
			for (int i=0; i <[pickerDataArray count]; i++)
			{
				NSString *myc_str =[pickerDataArray objectAtIndex:i];
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
				[newSelected addObject:[pickerDataArray objectAtIndex:[[myseleEntry objectAtIndex:j]intValue]]];
                [newSelectedId addObject:[pickerDictionaryDataArray objectAtIndex:[[myseleEntry objectAtIndex:j]intValue]]];
                
			}
            //	NSLog(@"%@",newSelected);
            //NSLog(@"F %@",newSelectedId);
            stringSelIntrestId=@"";
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
            
			[studyInterestTxtView setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
			[studyInterestTxtView setTextAlignment:UITextAlignmentLeft];
			studyInterestTxtView.text = strNewEntry;
		}
	}

    //action sheet tag 1 finish

}





#pragma mark -
#pragma mark ALPickerView delegate methods

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView2 {
	
  //  NSLog(@"%i",[pickerDataArray count]);

    return [pickerDataArray count];

    
}

- (NSString *)pickerView:(ALPickerView *)pickerView2 textForRow:(NSInteger)row {
	return [pickerDataArray objectAtIndex:row];
   // NSLog(@"%@",pickerDataArray);
}

- (BOOL)pickerView:(ALPickerView *)pickerView2 selectionStateForRow:(NSInteger)row 
{
	for (NSString *key in pickerDataArray)
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
	return [[selectionStates objectForKey:[pickerDataArray objectAtIndex:row]] boolValue];
}

- (void)pickerView:(ALPickerView *)pickerView2 didCheckRow:(NSInteger)row {
	// Check whether all rows are checked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[pickerDataArray objectAtIndex:row]];
	
}

- (void)pickerView:(ALPickerView *)pickerView2 didUncheckRow:(NSInteger)row {
	// Check whether all rows are unchecked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[pickerDataArray objectAtIndex:row]];
}




#pragma mark
#pragma mark - Email Validation division.



- (BOOL)validateEmailWithString:(NSString*)email11
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex]; 
    return [emailTest evaluateWithObject:email11];
}




#pragma mark
#pragma mark - IBAction division.



-(IBAction)editClicked:(id)sender{
    UIActionSheet *actionEdit = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Update",@"Logout",nil];
	[actionEdit setActionSheetStyle:UIActionSheetStyleBlackOpaque];
	[actionEdit setTag:3];
	//[actionEdit setCancelButtonIndex:2];
	[actionEdit setDestructiveButtonIndex:1];
	[actionEdit showInView:self.tabBarController.view];

}
-(IBAction)saveButtonClicked:(id)sender{

    NSString *msgalrt =@"";
	
    
        if([txtName.text isEqualToString:@""]){
            msgalrt =@"Enter Name";
        }
        else if([txtAddress.text isEqualToString:@""]){
            msgalrt =@"Enter AddressLine1";
        }
        else if([txtAdd2.text isEqualToString:@""]){
            msgalrt =@"Enter AddressLine2";
        }
        else if([txtAdd3.text isEqualToString:@""]){
            msgalrt =@"Enter AddressLine3";
        }else if([txtHome.text isEqualToString:@""]){
            msgalrt =@"Enter PhoneNumber";
        }

               
        if(![msgalrt isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"warning" message:msgalrt delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
	else{
      
        [self upDatePatientInformation];
    
    }
}
-(IBAction)cancelButtonClicked:(id)sender{
  
}

-(IBAction)dateOfBirthClicked:(id)sender{
    
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
-(IBAction)studyInterest:(id)sender{

	UIActionSheet *pickHistory = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	pickHistory.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	pickHistory.tag = 1;
	[pickHistory setBounds:CGRectMake(0, 0, 320, 250)];
     ALpicker = [[ALPickerView alloc] init];
    ALpicker.delegate =self;
	[pickHistory addSubview:ALpicker];
	[pickHistory showInView:self.tabBarController.view];


}

#pragma mark 
#pragma mark - Web services division.



-(void)responsePatientDetail:(NSDictionary *)dictinory{
  
    //This method is response of the web services called in View will appear 
    
    
   // NSLog(@"%@",dictinory);
    
    txtName.text  = [dictinory  valueForKey:@"name"];
    txtAddress.text   = [dictinory valueForKey:@"address1"];
    txtAdd2.text  = [dictinory  valueForKey:@"address2"];
    txtAdd3.text  = [dictinory valueForKey:@"address3"];
    txtHome.text  = [dictinory  valueForKey:@"home"];
    txtmobile.text = [dictinory  valueForKey:@"mobile_number"];
    txtEmail.text = [dictinory  valueForKey:@"contact_email"];
    stringSelIntrestId  = [[dictinory  valueForKey:@"study_interest"]retain];
    fileArray = [[NSMutableArray alloc] initWithArray:[ [dictinory  valueForKey:@"study_interest"]componentsSeparatedByString:@","]]; 
    
    [selectBtn setTitle:[dictinory valueForKey:@"birthdate"] forState:UIControlStateNormal];
     dateFromString = selectBtn.titleLabel.text;

}
-(void)studyInterestWebserviceResponse:(NSDictionary*)dictionary{
    
      //This method is response of the web services called in View will appear 

    NSMutableString *tempString = [[NSMutableString alloc]init];
    NSMutableString *tempString1 = [[NSMutableString alloc]init];
    
    
    for (NSString *key in pickerDataArray){
        [selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
    }
    
    strNewEntry=@"";

    pickerDictionaryDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"study_interest_areas"]];
    
    int j= 0;
    int i =0;
    for (i=0; i<[pickerDictionaryDataArray count]; i++) {
        
        tempString = [[[[dictionary valueForKey:@"study_interest_areas"]objectAtIndex:i]valueForKey:@"interest_area"]retain];
        [pickerDataArray addObject:tempString];
        
      
        for (j=0;j<=[fileArray count]-1;j++ ) {
            
                   
        if ([[[pickerDictionaryDataArray objectAtIndex:i]valueForKey:@"id"]  isEqual:[fileArray objectAtIndex:j]]) {
             
                tempString1=  [[[pickerDictionaryDataArray objectAtIndex:i]valueForKey:@"interest_area"]retain];
             
          //  studyInterestTxtView.text =   [studyInterestTxtView.text stringByAppendingFormat:tempString1];
            
            
            if (j==0)
            {
            strNewEntry = [[strNewEntry stringByAppendingString:[NSString stringWithFormat:@"%@",tempString1]]retain];
            
            }
            else if(j<=[fileArray count]-1)
            {
            strNewEntry = [[strNewEntry stringByAppendingString:[NSString stringWithFormat:@",%@",tempString1]]retain];
            }
        }
            
			[studyInterestTxtView setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
			[studyInterestTxtView setTextAlignment:UITextAlignmentLeft];
			studyInterestTxtView.text = strNewEntry ;
            
            }
        } 
    
    [tempString release];
    [tempString1 release];

    
}

-(void)upDatePatientInformation{
    
    [AlertHandler showAlertForProcess];
    
    NSString *add1=[[NSString alloc]init];
    NSString *add2=[[NSString alloc]init];
    NSString *add3=[[NSString alloc]init];

    
    add1 = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",txtAddress.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    add2 = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",txtAdd2.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    add3 = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",txtAdd3.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);

    
    NSString *stateUrl=[[NSString alloc ]initWithFormat:@"http://openxcelluk.info/clinical/web_services/patient_update.php?id=%@&name=%@&address1=%@&address2=%@&address3=%@&home=%@&mobile_number=%@&study_interest=%@&birthdate=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Patient_id"],txtName.text,add1,add2,add3,txtHome.text,txtmobile.text,stringSelIntrestId,dateFromString];
    
  //  NSLog(@"%@",stateUrl);
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl]];
    JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(upDatePatientInformationResponse:) andHandler:self];
    NSLog(@"%@",parser);
    [add1 release];
    [add2 release];
    [add3 release];
    [stateUrl release];
    
}
-(void)upDatePatientInformationResponse:(NSDictionary*)dictionary{

  //  NSLog(@"%@",dictionary);
    [AlertHandler hideAlert];

    
    if ([[dictionary valueForKey:@"msg"]isEqualToString:@"patient updated successfully"]) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Record Updated Successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert setTag:45];
        [alert show];
        [alert release];
        
        
        selectBtn.userInteractionEnabled   = NO;
        studyinterestBtn.userInteractionEnabled=NO;
        
        saveBtn.hidden=TRUE;
        cancelBtn.hidden=TRUE;
        
        txtName.userInteractionEnabled  = NO;
        txtAddress.userInteractionEnabled   = NO;
        txtAdd2.userInteractionEnabled  = NO;
        txtAdd3.userInteractionEnabled  = NO;
        txtHome.userInteractionEnabled  = NO;
        txtmobile.userInteractionEnabled   = NO;
        txtEmail.userInteractionEnabled = NO;
        selectBtn.userInteractionEnabled   = NO;
        studyInterestTxtView.userInteractionEnabled  = NO;
        studyInterestTxtView.editable  = NO;
        studyinterestBtn.userInteractionEnabled=NO;

    }else{
        

    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Update Was Unsuccessful. Please Try Again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert setTag:23];
        [alert show];
        [alert release];
    
    }

}




#pragma mark 
#pragma mark - View lifecycle division



- (void)viewDidLoad
{
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    pickerDataArray=[[NSMutableArray alloc]init];
    scrollView.contentSize=CGSizeMake(320, 650);
   joinPatientobj=[[JoinAsPatient alloc]init];
    selectionStates=[[NSMutableDictionary alloc]init];
    arr11= [[NSMutableArray alloc]init];
    arrSavedData=[[NSMutableArray alloc]init];
    
  strNewEntry = [[[NSString alloc]init]retain];
    stringSelIntrestId =[[[NSString alloc]init]retain];
  
    
    
    txtName.delegate  =self ;
    txtAddress.delegate   = self;
    txtAdd2.delegate  = self;
    txtAdd3.delegate  = self;
    txtHome.delegate  = self;
    txtmobile.delegate   = self;
    txtEmail.delegate =  self;

    

}


-(void)viewWillAppear:(BOOL)animated{
   
    selectBtn.userInteractionEnabled   = NO;
    studyinterestBtn.userInteractionEnabled=NO;

    saveBtn.hidden=TRUE;
    cancelBtn.hidden=TRUE;
    
    // Patient study Interest AL-picker View Webservices start


    NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/study_interest_area_list.php"];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(studyInterestWebserviceResponse:) andHandler:self];
    NSLog(@"%@",parser);
    
    // Patient study Interest AL-picker View Webservices End

    
    
    // Patient profile Webservices start
    
    NSString *stateUrl1=[[NSString alloc ]initWithFormat:@"http://openxcelluk.info/clinical/web_services/patient_profile.php?id=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Patient_id"]];
    
   // NSLog(@"%@",stateUrl1);
    
    NSMutableURLRequest *request1=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl1]];
    JSONParser *parser1 = [[JSONParser alloc] initWithRequestForThread:request1 sel:@selector(responsePatientDetail:) andHandler:self];
    NSLog(@"%@",parser1);

    // Patient profile Webservices End
    
    [AlertHandler hideAlert];



}


- (void)viewDidUnload
{
    [editBtn release];
    editBtn = nil;
    [scrollView release];
    scrollView = nil;
    [txtName release];
    txtName = nil;
    [txtAddress release];
    txtAddress = nil;
    [txtAdd2 release];
    txtAdd2 = nil;
    [txtAdd3 release];
    txtAdd3 = nil;
    [txtmobile release];
    txtmobile = nil;
    [txtHome release];
    txtHome = nil;
    [txtEmail release];
    txtEmail = nil;
    [selectBtn release];
    selectBtn = nil;
    [studyinterestBtn release];
    studyinterestBtn = nil;
    [studyInterestTxtView release];
    studyInterestTxtView = nil;
    [cancelBtn release];
    cancelBtn = nil;
    [saveBtn release];
    saveBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
