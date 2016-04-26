//
//  JoinAsPatient.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JoinAsPatient.h"
#import "titleView.h"
#import "JSON.h"
#import "JSONParser.h"


@implementation JoinAsPatient
@synthesize patName,patAdd,patMob,patEmail,passTxtField,unameTxtField;
@synthesize txtView,scrlView,patAdd2,patAdd3,patHome,txtCaptcha,txtCaptchaName,registrationPass,registrationUname,strNewEntry,pickerDictionaryArray,stringSelIntrestId,arr11,pickeArray,selectionStates,loginBtn;
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
	
  //  patientProfileView.hidden=TRUE;
    btnEdit.hidden=TRUE;
       isNewRecord =TRUE;

   txtView.delegate=self;
        
	appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
   
    arrSavedData = [[NSMutableArray alloc] init];

    stringSelIntrestId= [[NSMutableString alloc]init];

    strNewEntry= [[[NSString alloc]init]retain];
    registrationUname.delegate=self;
    registrationPass.delegate=self;
    unameTxtField.delegate=self;
    passTxtField.delegate=self;
	self.navigationController.navigationBar.hidden=FALSE;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	//conditionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	scrlView.contentSize = CGSizeMake(320,650);

	//conditionView.hidden=FALSE;

	
   
    //  Web Service Calling Start For Study Interest ID and List.
    

    
    NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/study_interest_area_list.php"];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(studyInterestWebserviceResponse:) andHandler:self];
    NSLog(@"%@",parser);
    
    
    
    //  Web Service Calling End For Study Interest ID and List.

    
        pickeArray = [[NSMutableArray alloc]init];

        ALpicker = [[ALPickerView alloc] init];
        ALpicker.delegate = self;

        selectionStates = [[NSMutableDictionary alloc] init];

        arr11 = [[NSMutableArray alloc] init];
        
        [txtView setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        [txtView setTextAlignment:UITextAlignmentLeft];
	
    dictUserData = [[NSMutableDictionary alloc] init];
    
        
}



-(void)studyInterestWebserviceResponse:(NSDictionary*)dictionary{

    NSMutableString *tempString = [[NSMutableString alloc]init];
    pickerDictionaryArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"study_interest_areas"]];
    
    int i =0;
    for (i=0; i<[pickerDictionaryArray count]; i++) {
        
        tempString = [[[[dictionary valueForKey:@"study_interest_areas"]objectAtIndex:i]valueForKey:@"interest_area"]retain];
        [pickeArray addObject:tempString];
    }
    [tempString release];
    
    for (NSString *key in pickeArray)
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
    
}
-(void)pusing:(id)sender{

    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Record Inserted Successfully !" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];

    
    ProfileUpdateView *profileUp = [[ProfileUpdateView alloc]init];

    [self.navigationController pushViewController:profileUp animated:NO];


}
-(IBAction)cancelButtonAgreementView{

    loginBtn.tag=0;
    [self viewWillAppear:YES];  

}

-(void)viewWillAppear:(BOOL)animated
{
   
        
    
    loginView.hidden=TRUE;
	srandom(time(NULL));
		
       
    if ([arrSavedData count]>0)
	{
		//conditionView.hidden=TRUE;
		btnEdit.hidden=FALSE;
		btnSave.hidden=TRUE;
		btnCancel.hidden=TRUE;
        
        ProfileUpdateView *profileUp = [[ProfileUpdateView alloc]init];
        [self.navigationController pushViewController:profileUp animated:NO];
            			
    }
	else
	{
        if (loginBtn.tag==0) {
            
            unameTxtField.text= @"";
            passTxtField.text=@"";
            
        loginView.hidden=FALSE;
            
        }else  if(btnSave.tag==0)  { 
        
		txtCaptchaName.text=@"";
		txtCaptcha.text=@"";
		patName.text  = @"";
		patAdd.text   = @""; 
		patAdd2.text  = @"";
		patAdd3.text  = @"";
		patHome.text  = @"";
		patMob.text   = @"";
		patEmail.text = @"";
		dateFromString= @"";
		txtView.text  = @"";
		[btnDOB setTitle:@"Select" forState:UIControlStateNormal];
		btnEdit.hidden=TRUE;
		btnSave.hidden=FALSE;
		btnCancel.hidden=FALSE;
		
		patName.userInteractionEnabled  = YES;
		patAdd.userInteractionEnabled   = YES;
		patAdd2.userInteractionEnabled  = YES;
		patAdd3.userInteractionEnabled  = YES;
		patHome.userInteractionEnabled  = YES;
		patMob.userInteractionEnabled   = YES;
		patEmail.userInteractionEnabled = YES;
		btnDOB.userInteractionEnabled   = YES;
		txtView.userInteractionEnabled  = YES;
		btnMediHistory.userInteractionEnabled=YES;
        }
	}
        
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

-(IBAction)signUp{
    
    loginView.hidden=TRUE;
    loginBtn.tag=1;
    
    txtCaptchaName.text=@"";
    registrationPass.text=@"";
    registrationUname.text=@"";
    txtCaptcha.text=@"";
    patName.text  = @"";
    patAdd.text   = @""; 
    patAdd2.text  = @"";
    patAdd3.text  = @"";
    patHome.text  = @"";
    patMob.text   = @"";
    patEmail.text = @"";
    dateFromString= @"";
    txtView.text  = @"Study Interest";
    [btnDOB setTitle:@"Select" forState:UIControlStateNormal];
    btnEdit.hidden=TRUE;
    btnSave.hidden=FALSE;
    btnCancel.hidden=FALSE;
    
    
    registrationUname.userInteractionEnabled= YES;
    registrationPass.userInteractionEnabled=YES;
    
    patName.userInteractionEnabled  = YES;
    patAdd.userInteractionEnabled   = YES;
    patAdd2.userInteractionEnabled  = YES;
    patAdd3.userInteractionEnabled  = YES;
    patHome.userInteractionEnabled  = YES;
    patMob.userInteractionEnabled   = YES;
    patEmail.userInteractionEnabled = YES;
    btnDOB.userInteractionEnabled   = YES;
    txtView.userInteractionEnabled  = YES;
    btnMediHistory.userInteractionEnabled=YES;



}


-(void)loginResponse:(NSDictionary *)dictinory{

   // NSLog(@"Login %@",dictinory);

    [AlertHandler hideAlert];

    if ([[dictinory valueForKey:@"msg"] isEqualToString:@"Please activate your account check your mail." ]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please activate your account check your mail." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert setTag:11];
        [alert show];
        return;

    }
    
    if ([[dictinory valueForKey:@"msg"] isEqualToString:@"Login successfull" ]) {
        
        loginFlag = TRUE;
        [[NSUserDefaults standardUserDefaults]setValue:[dictinory valueForKey:@"id"] forKey:@"Patient_id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        loginBtn.tag=0;

        ProfileUpdateView *profileUp = [[ProfileUpdateView alloc]init];
        [self.navigationController pushViewController:profileUp animated:NO];
    
    }else{
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Username or Password Incorrect.\n Try Again or Reset Password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert setTag:11];
        [alert show];

         
          
     }
 
}



-(IBAction)loginClicked{

    [unameTxtField resignFirstResponder];    
    [passTxtField resignFirstResponder];
    
    if ([passTxtField.text length]!=0 && [unameTxtField.text length]!=0 ) {
        
    
    [AlertHandler showAlertForProcess];
    NSString *str_planturl=[NSString stringWithFormat:@"http://openxcelluk.info/clinical/web_services/login_patient.php?username=%@&password=%@",unameTxtField.text,passTxtField.text];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(loginResponse:) andHandler:self];
    NSLog(@"%@",parser);
    }
    else{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Valid Username and Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert setTag:589];
		[alert show];
        [alert release];
    
    }
   
        
}


-(IBAction)patCancelclicked:(id)sender
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are You Sure You Want to Quit Registration? " delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
    
    alert.tag=25;
    [alert show];
    [alert release];

    
}
-(IBAction)editClicked:(id)sender
{
	UIActionSheet *actionEdit = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Update",@"Delete",nil];
	[actionEdit setActionSheetStyle:UIActionSheetStyleBlackOpaque];
	[actionEdit setTag:3];
	//[actionEdit setCancelButtonIndex:2];
	[actionEdit setDestructiveButtonIndex:1];
	[actionEdit showInView:self.tabBarController.view];
}
- (BOOL)validateEmailWithString:(NSString*)email11
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email11];
}




-(IBAction)patAddClicked:(id)sender
{
	NSString *msgalrt =@"";
	// if([registrationUname.text isEqualToString:@""]){
		//msgalrt =@"Enter User Name";
	//}
    //else if([registrationPass.text isEqualToString:@""]){
		//msgalrt =@"Enter Password";
	//}
    
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
	//else if([self validateEmailWithString:patEmail.text]){
		//msgalrt =@"Enter Valid Email";
	//}
	
	if(![msgalrt isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"warning" message:msgalrt delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		//[alert setTag:12];
		[alert show];
		[alert release];
        btnSave.tag=1;

	}
	else{
        
        
        //Faizan 
		
		[dictUserData setObject:@"1" forKey:@"id"];
		[dictUserData setObject:patName.text forKey:@"name"];
		[dictUserData setObject:patAdd.text forKey:@"address1"];
		[dictUserData setObject:patAdd2.text forKey:@"address2"];
		[dictUserData setObject:patAdd3.text forKey:@"address3"];
		[dictUserData setObject:patHome.text forKey:@"home"];
		[dictUserData setObject:patMob.text forKey:@"mobile"];
		[dictUserData setObject:patEmail.text forKey:@"email"];
		[dictUserData setObject:dateFromString forKey:@"birthdate"];
		[dictUserData setObject:txtView.text forKey:@"study_interest"];
				
	//	NSLog(@"%@",dictUserData);
        
   
        
		if (isNewRecord==TRUE)
		{
			 [self performSelector:@selector(upLoadDetail) withObject:nil afterDelay:0.5] ;
		
            
		}
			}
	
	
}


#pragma mark -
#pragma mark  Upload Patient Detail delegate methods

-(void)upLoadDetail{

    [AlertHandler showAlertForProcess];
    
    patAdd.text = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",patAdd.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    patAdd2.text = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",patAdd2.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    patAdd3.text = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",patAdd3.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    
    self.stringSelIntrestId = (NSMutableString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSMutableString stringWithFormat:@"%@",self.stringSelIntrestId], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    
    
    NSString *stateUrl=[[NSString alloc ]initWithFormat:@"http://openxcelluk.info/clinical/web_services/patient_registration.php?username=%@&name=%@&address1=%@&address2=%@&address3=%@&home=%@&mobile_number=%@&study_interest=%@&contact_email=%@&birthdate=%@&password=%@",registrationUname.text,patName.text,patAdd.text,patAdd2.text,patAdd3.text,patHome.text,patMob.text,self.stringSelIntrestId,patEmail.text,dateFromString,registrationPass.text];
    
  //  NSLog(@"%@",stateUrl);

    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl]];
    JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(responseresult:) andHandler:self];
  NSLog(@"%@",parser);
    
       
 
}


-(void)responseresult:(NSDictionary *)dictinory{

   
    [AlertHandler hideAlert]; 
  //  NSLog(@"%@",dictinory);

    if ([[dictinory valueForKey:@"msg" ]isEqualToString:@"patient registerd successfully"]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:registrationUname.text forKey:@"Uname"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults] setValue:registrationPass.text forKey:@"Pass"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dictinory valueForKey:@"id"] forKey:@"Patient_id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        loginBtn.tag=0;
        
        ProfileUpdateView *profileUp = [[ProfileUpdateView alloc]init];
        
        [self.navigationController pushViewController:profileUp animated:NO];
        
        
        
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Record Submitted Successfully!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];

               
        }else if([[dictinory valueForKey:@"msg"]isEqualToString:@"username or email already exist"]){
        
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Username or email already exist.\n Please Login to Your Account or Reset Your Password." message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
         
   
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if (alertView.tag==25)
	{
	
        switch (buttonIndex) {
            case 0:{
                
                loginBtn.tag=0;
                [self viewWillAppear:YES];
                break;
            }
            case 1:{
                
                break;
            }
                
            default:
                break;
        }  
        
	}
	else if (alertView.tag==22)
	{
		txtCaptcha.text=@"";
		txtCaptchaName.text=@"";
	}
	else if (alertView.tag==23){
		[self viewWillAppear:YES];
		
	}
	else
	{
		[self viewWillAppear:YES];
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
	
    [unameTxtField resignFirstResponder];
    [passTxtField resignFirstResponder];
	[patName resignFirstResponder];	
	[patAdd resignFirstResponder];	
	[patAdd2 resignFirstResponder];	
	[patAdd3 resignFirstResponder];	
	[patHome resignFirstResponder];	
	[patMob resignFirstResponder];
	[patEmail resignFirstResponder];


}


#pragma mark -
#pragma mark Action Sheet delegate methods




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(actionSheet.tag ==3)
	{
		if (buttonIndex == 0)
		{
			isNewRecord = FALSE;
			
		//	patientProfileView.hidden=TRUE;
            
            patName.userInteractionEnabled  = YES;
			patAdd.userInteractionEnabled   = YES;
			patAdd2.userInteractionEnabled  = YES;
			patAdd3.userInteractionEnabled  = YES;
			patHome.userInteractionEnabled  = YES;
			patMob.userInteractionEnabled   = YES;
			patEmail.userInteractionEnabled = YES;
			btnDOB.userInteractionEnabled   = YES;
			txtView.userInteractionEnabled  = YES;
			btnMediHistory.userInteractionEnabled=YES;
			
			btnSave.hidden=FALSE;
			btnCancel.hidden=FALSE;
		}
		else if (buttonIndex == 1)
		{
			selectionStates = [[NSMutableDictionary alloc] init];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Record Deleted Successfully!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert setTag:23];
			[alert show];
			[alert release];
		}
	}
	
	else if (actionSheet.tag ==2)
	{
		if (buttonIndex == 0)
		{
            
            NSDate *tempDate = dtPicker.date;
            //    NSLog(@"%@ %@",temp,tempDate);
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateFromString = [[dateFormatter stringFromDate:tempDate]retain];
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
         //   NSLog(@"F %@",newSelectedId);

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
    if (textField ==patName ||textField==registrationPass||textField==registrationUname||textField==unameTxtField||textField==passTxtField) {
        
    }else{
        [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField ==patName||textField==registrationPass||textField==registrationUname||textField==unameTxtField||textField==passTxtField) {
        
    }else{
        [self animateTextField:textField up:NO];
    }
}

- (void)animateTextField:(UITextField*) textField up: (BOOL) up {
	
	int movementDistance = 140; 
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
    [unameTxtField resignFirstResponder];
    [passTxtField resignFirstResponder];
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
    [loginView release];
    loginView = nil;
    [loginBtn release];
    loginBtn = nil;
    [joinBtn release];
    joinBtn = nil;
    [unameTxtField release];
    unameTxtField = nil;
    [passTxtField release];
    passTxtField = nil;
    // [patientProfileView release];
   // patientProfileView = nil;
      [cancelButtonAgreementView release];
    cancelButtonAgreementView = nil;
    [btnTextViewStudyInterest release];
    btnTextViewStudyInterest = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [loginView release];
    [pickerDictionaryArray release];
    [loginBtn release];
    [joinBtn release];
    [unameTxtField release];
    [passTxtField release];
    [registrationPass release];
    [registrationUname release];
      [cancelButtonAgreementView release];
    [btnTextViewStudyInterest release];
    [super dealloc];
}


@end
