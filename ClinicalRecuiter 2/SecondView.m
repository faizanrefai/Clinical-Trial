    //
//  SecondView.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondView.h"
#import "JSON.h"
#import "AlertHandler.h"
#import "JSONParser.h"
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;



@implementation SecondView
@synthesize rcUname,rcPassword,rcName,rcOverview,rcAdd1,rcAdd2,rcAdd3,rcAdd4,rcBusinessNo,rcFaxNo,rcContactName,rcEmail1,rcEmail2,rcURL,rcMobileNO,rcConfPass,countriesDicArray,pkrCountry,countryId,stateNameArray;
@synthesize scrlView,pkrExpArea,isPatient,lblExp,btnPhoto,picker,imgPhoto,pickerState;//,rcIRBNum;
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)dealloc {
    [selectCountryBtn release];
    [selectStateBtn release];
    [rcAdd4 release];
    [detailLable release];
    [super dealloc];
    [countriesDicArray release];
    [pkrCountry release];
    [pickerState release];
    [countryId release];
    [stateNameArray release];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	scrlView.contentSize=CGSizeMake(320, 1400);
	//rcXtraField1.hidden = TRUE;
	arrayNo = [[NSMutableArray alloc] initWithObjects:@"Cardiology/Vascular",@"Dental/Maxillofacial",@"Dermatology/Plastic",@"Endocrinology",@"Gastroenterology",@"Hematology",@"Immunology/ID",@"Internal Medicine",@"Musculoskeletal",@"Nephrology/Urology",@"Neurology",@"OBGYN",@"Opthalmology",@"Orthopedics",@"Otolaryngology",@"Pediatric/Neonate",@"Pharmacology/Tox",@"Podiatry",@"Psychiatry",@"Pulmonary",@"Rheumatology",@"Sleep Medicine",@"Trauma/Emergency",@"Healthy Patients",nil];	

    strImg=[[[NSString alloc]init]retain];
    countryId = [[NSMutableString alloc]init];
    stateNameArray = [[NSMutableArray alloc]init];
    countriesDicArray =[[NSMutableArray alloc] init];
	arr11 = [[NSMutableArray alloc] init];
	pickerView = [[ALPickerView alloc] init];
	pickerView.delegate = self;
    countExpAre = [[NSString alloc] initWithFormat:@""];

	entries = [[NSArray alloc] initWithArray:arrayNo];
	selectionStates = [[NSMutableDictionary alloc] init];
	
	for (NSString *key in entries)
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	
	appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
	picker = [[UIImagePickerController alloc] init];
	[picker setDelegate:self];
	//picker.allowsImageEditing = TRUE;
	
	
	

}

- (void)viewWillAppear:(BOOL)animated
{

    if (isPicker) {
        return;
    } 
    
    if ([countriesDicArray count]==0) {
    [self GetCountryData];
	}
    
    rcUname.text=@"";
	rcOverview.text =@"";
	[selectStateBtn setTitle:@"Select State" forState:UIControlStateNormal];
	[selectCountryBtn setTitle:@"Select Country" forState:UIControlStateNormal]; 
	rcPassword.text=@"";
	rcConfPass.text=@"";
	rcName.text=@"";
	rcAdd1.text=@"";
    rcAdd4.text=@"";
	rcAdd2.text=@"";
	rcAdd3.text=@"";
	//rcIRBNum.text=@"";
	rcContactName.text=@"";
	rcBusinessNo.text=@"";
	rcMobileNO.text=@"";
	rcFaxNo.text=@"";
	rcEmail1.text=@"";
	rcEmail2.text=@"";
	rcURL.text=@"";
    scrlView.scrollsToTop =TRUE;
	[btnAreaExp setTitle:@"Select" forState:UIControlStateNormal];
    
	if ([[appDel.dictUserData valueForKey:@"role"]isEqualToString:@"Sponcer"]){
		researchBtnAdd.frame =CGRectMake(43, 750, 74, 37);
		researchBtnCancel.frame =CGRectMake(196, 750, 74, 37);
		ExpAraMendatory.hidden =TRUE;
		areaOfExpLabel.hidden=TRUE;
		[btnAreaExp setHidden:TRUE];
		lblExp.hidden=TRUE;
		scrlView.contentSize=CGSizeMake(320, 1350);
		detailLable.text=@"Sponsors/CRO's, please fill in the following form by entering the company details for your participating sites. After successful submission you will be allowed to list your clinical trial details which will be linked to this investigator site in our app and website database.";
        //scrollBGImage.frame =CGRectMake(5, 8, 300,900);
		//scrlView.frame.size.height = 850.0;
	}
	else 
	{
		detailLable.text=@"Investigator Centers, please fill in the following form by entering your company details. After successful submission you will be allowed to submit any your clinical trials to be listed on the CTR app and website";
        researchBtnAdd.frame =CGRectMake(43, 810, 74, 37);
		researchBtnCancel.frame =CGRectMake(196, 810, 74, 37);
		areaOfExpLabel.hidden=FALSE;
		[btnAreaExp setHidden:FALSE];
		lblExp.hidden=FALSE;
		lblExp.hidden=FALSE;
		//scrollBGImage.frame =CGRectMake(5, 8, 300, 736);
		scrlView.contentSize=CGSizeMake(320, 1370);
           
	}
    
    scrlView.contentOffset=CGPointMake(0, 0);

}




-(BOOL)validateEmail:(NSString *)Email{    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];     
    return [emailTest evaluateWithObject:Email];
}

-(IBAction)backClicked: (id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)expAreaClicked:(id)sender
{
	pkrExpArea = [[UIPickerView alloc] init];
	pkrExpArea.delegate=self;
	pkrExpArea.dataSource=self;
	[pkrExpArea setShowsSelectionIndicator:YES];
	[pkrExpArea selectRow:1 inComponent:0 animated:NO];
	[pkrExpArea setTag:1];
	
	UIActionSheet *ExpArea = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	ExpArea.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[ExpArea setBounds:CGRectMake(0, 0, 320, 250)];
	ExpArea.tag=1;
	[ExpArea addSubview:pickerView];
	[ExpArea showInView:self.tabBarController.tabBar];
	[pkrExpArea reloadAllComponents];
}
#pragma mark -
#pragma mark JSON delegate methods


-(void)GetCountryData
{
    [AlertHandler showAlertForProcess];
    NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/country.php"];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
   NSLog(@"%@",parser);
       
}

-(void)searchResult:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
    countriesDicArray =[[dictionary valueForKey:@"countries"]mutableCopy];
   // NSLog(@"%@",countriesDicArray);
 
}	
-(void)serchResultStateName:(NSDictionary*)dictinary{

    [AlertHandler hideAlert];
    // NSLog(@"%@",dictinary);
    NSMutableString *tempString=[[NSMutableString alloc]init];
    
  //  NSLog(@"%i",[[dictinary valueForKey:@"states"]count]);
    [stateNameArray removeAllObjects];
    
    int i =0;
    for (i=0; i<[[dictinary valueForKey:@"states"]count]; i++) {
        
        tempString = [[[[dictinary valueForKey:@"states"]objectAtIndex:i]valueForKey:@"state"]retain];
        [stateNameArray addObject:tempString];
    }
    [tempString release];

}
#pragma mark -

#pragma mark -
#pragma mark ALPickerView delegate methods

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView {
        return [entries count];
}

- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row {
    return [entries objectAtIndex:row];

}
- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row {
	
	for (NSString *key in entries)
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
	return [[selectionStates objectForKey:[entries objectAtIndex:row]] boolValue];
}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row {
	// Check whether all rows are checked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[entries objectAtIndex:row]];
	
}

- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row {
	// Check whether all rows are unchecked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[entries objectAtIndex:row]];
}


#pragma mark -
#pragma mark Photo Clicked delegate methods



-(IBAction)photoClicked: (id)sender
{
    
	UIActionSheet *photoAction = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Galery",nil];
	[photoAction showInView:self.tabBarController.tabBar];
	photoAction.tag=2;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==6) {
       
        if ([countryId length]!=0) {
            
            [AlertHandler showAlertForProcess];
            
        NSString *stateUrl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/states.php?cid=%@",countryId];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl]];
        JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(serchResultStateName:) andHandler:self];
        NSLog(@"%@",parser);
        pkrCountry.tag=0;
        }else{
        
            [AlertHandler showAlertForProcess];

            [selectCountryBtn setTitle:@"USA" forState:UIControlStateNormal];
            rcAdd2.text =@"USA";
            
            NSString *stateUrl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/states.php?cid=%@",@"239"];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl]];
            JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(serchResultStateName:) andHandler:self];
            NSLog(@"%@",parser);
            pkrCountry.tag=0;

        }
        
                   
       
    }
    if (actionSheet.tag==7) {
        
        pickerState.tag=0;
          
    }
    
	if (actionSheet.tag==1)
	{
		if (buttonIndex==0)
		{
			NSMutableArray *myseleEntry =[[NSMutableArray  alloc]init];
			for (int i=0; i <[entries count]; i++)
			{
				NSString *myc_str =[entries objectAtIndex:i];
				for(NSString *s in arr11){
					if([s isEqualToString:myc_str])
						[myseleEntry addObject:[NSString stringWithFormat:@"%d",i+1]];
				}
			}
			
		//	NSLog(@"%@",myseleEntry);
			
			NSString *str =@"";
			for (int i=0; i<[myseleEntry count]; i++)
			{
				
				if (i==[myseleEntry count]-1)
				{
					str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",[myseleEntry objectAtIndex:i]]];
				}
				else
				{
					str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",[myseleEntry objectAtIndex:i]]];
				}
			}
			countExpAre=[str copy];
			//NSLog(@"%@",countExpAre);
			//strExpArea =[arrayNo objectAtIndex:[pkrExpArea selectedRowInComponent:0]];
//			countExpAre = [[NSString alloc] initWithFormat:@"%d",[pkrExpArea selectedRowInComponent:0]];
//			[btnAreaExp setTitle:strExpArea forState:UIControlStateNormal];
		}
	}
	else if (actionSheet.tag==2)
	{
		if (buttonIndex==0)
		{
			isPicker=TRUE;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			[self presentModalViewController:picker animated:YES];
		}
		else if (buttonIndex==1)
		{
            isPicker=TRUE;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentModalViewController:picker animated:YES];
		}
	}
}
- (void)imagePickerController:(UIImagePickerController *)pickers didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
	[imgPhoto setImage:img];
	
	NSData *imgData =UIImageJPEGRepresentation(img, 0.45);
	strImg = [[imgData base64Encoding] retain];
}
#pragma mark -
#pragma mark Picker Methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView1 numberOfRowsInComponent:(NSInteger)component;
{
	if (pickerState.tag==7) {
        return [stateNameArray count];
    }
    if (pkrCountry.tag==6) {
        return [countriesDicArray count];
    }
    else{
  //  NSLog(@"%d",[arrayNo count]);
    return [arrayNo count];

    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView1 titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    
    if (pickerState.tag==7) {
       
        return [stateNameArray objectAtIndex:row];
      
        
    }
    if (pkrCountry.tag==6) {
       
        NSMutableString *tempStr = [[[NSMutableString alloc]initWithFormat:@"%@",[[countriesDicArray objectAtIndex:row]valueForKey:@"country"]]retain];
        
        return tempStr;
    }else{
	return nil;
    }
}


- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pkrCountry.tag==6) {
        
        rcAdd2.text=[[[countriesDicArray objectAtIndex:row]valueForKey:@"country"]retain];
        countryId = [[NSString stringWithFormat:@"%@",[[countriesDicArray objectAtIndex:row]valueForKey:@"cid"]]retain];
        
        [selectCountryBtn setTitle:rcAdd2.text forState:UIControlStateNormal];
        [stateNameArray removeAllObjects];
                
    }
    if (pickerState.tag==7)
	{       
        rcAdd3.text=[[stateNameArray objectAtIndex:row]retain];
         [selectStateBtn setTitle:rcAdd3.text forState:UIControlStateNormal];
       
 	}
    
    if (pickerView1.tag==1)
	{
		strExpArea = [[NSString alloc] initWithFormat:@"%@",[arrayNo objectAtIndex:row]];
		countExpAre = [[NSString alloc] initWithFormat:@"%d",row];
    
	}
}

-(IBAction)researchCancelclicked:(id)sender
{

}

-(IBAction)researchAddClicked:(id)sender
{
	NSString *MsgAlrt = @"";
	BOOL isCorrectEmail1 = [self validateEmail:rcEmail1.text];
	BOOL isCorrectEmail2 =FALSE;
	if(![rcEmail2.text isEqualToString:@""]){
	 isCorrectEmail2 = [self validateEmail:rcEmail2.text];
	}
	else{
		isCorrectEmail2 =TRUE;
	}
	if (isPatient==TRUE)
	{
		countExpAre = @"";
		
	}	
	if([rcUname.text isEqualToString:@""]){
		MsgAlrt =@"Enter Username";
	}
	else if([rcPassword.text isEqualToString:@""]){
		MsgAlrt =@"Enter Pasword";
	}
	else if(![rcConfPass.text isEqualToString:rcPassword.text]){
		MsgAlrt =@"Pasword does not match";
	}
	else if([rcName.text isEqualToString:@""]){
		MsgAlrt =@"Enter Centername";
	}
	else if([[selectCountryBtn currentTitle] isEqualToString:@"Select Country"]){
		MsgAlrt =@"Enter Country";
		
	}else if([rcAdd4.text isEqualToString:@""]){
		MsgAlrt =@"Enter Address";
	}
	else if([[selectStateBtn currentTitle] isEqualToString:@"Select State"]){
		MsgAlrt =@"Enter State";
	}
	else if([rcOverview.text isEqualToString:@""]){
		MsgAlrt =@"Enter Overview";
	}
	
	else if([rcContactName.text isEqualToString:@""]){
		MsgAlrt =@"Enter Contactname";
	}

	else if([rcBusinessNo.text isEqualToString:@""]){
		MsgAlrt =@"Enter addressline1";
	}
	
	else if([rcEmail1.text isEqualToString:@""]){
		MsgAlrt =@"Enter E-mail Address";
	}
	else if (!isCorrectEmail1){
		MsgAlrt =@"Enter valid Email";

	}
	else if (!isCorrectEmail2){
		MsgAlrt =@"Enter valid Alternative E-mail";
	}
	
	
	if([MsgAlrt isEqualToString:@""] && isCorrectEmail1){
	
				
		[NSThread detachNewThreadSelector:@selector(displayindicator) toTarget:self withObject:nil];

		NSString *photoName = [[NSString alloc] initWithFormat:@"%@.jpg",rcUname.text];
		NSString *role = [[NSString alloc] initWithFormat:@"%@",[appDel.dictUserData valueForKey:@"role"]];
		
		NSString *c11 = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strImg, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
        
        rcOverview.text= (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)rcOverview.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
        
       //  rcOverview.text = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",rcOverview.text], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
		
		NSString *post =[NSString stringWithFormat:@"username=%@&password=%@&Confirm_password=%@&research_center_name=%@&overview=%@&center_photo=%@&address1=%@&address2=%@&address3=%@&address4=%@&business_number=%@&fax_number=%@&contact_name=%@&contact_email1=%@&contact_email2=%@&URL=%@&expertise_area=%@&mobile_number=%@&role=%@&center_photo_code=%@",rcUname.text,rcPassword.text,rcConfPass.text,rcName.text,rcOverview.text,photoName,[selectCountryBtn currentTitle],[selectStateBtn currentTitle],rcAdd4.text,rcAdd1.text,rcBusinessNo.text,rcFaxNo.text,rcContactName.text,rcEmail1.text,rcEmail2.text,rcURL.text,countExpAre,rcMobileNO.text,role,c11];
		
		//NSLog(post);
		NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
		
		NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
		
		NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
		[request setURL:[NSURL URLWithString:@"http://www.openxcelluk.info/clinical/web_services/registration.php"]];
		[request setHTTPMethod:@"POST"];
		[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:postData];
		
		NSError *error;
		NSURLResponse *response = [[NSURLResponse alloc]init] ;
		NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
		
		NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
       temp= [data JSONValue];
		
		
		[AlertHandler hideAlert];	
		NSString *msg = [temp valueForKey:@"msg"];
        
        appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		if ([msg isEqualToString:@"Register successfully"])
		{
			NSString *userId = [[NSString alloc] initWithFormat:@"%@",[temp valueForKey:@"research_center_id"]];
			[appDel.dictUserData setValue:userId forKey:@"uid"];
			DetailView *objDetail = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
			objDetail.isFromLogin=FALSE;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Thank You! Your Registration Was Successfully Submitted!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
            
			[self.navigationController pushViewController:objDetail animated:YES];
			//[objDetail release];
		}
		else if ([msg isEqualToString:@"duplicate data found unable to register"])
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to Register\n***Duplicate Username***\nPlease Retry, Login To Your Account or Reset Your Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:MsgAlrt delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

-(void)displayindicator{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];	{
	[AlertHandler showAlertForProcess];
	}
	
	[pool release];	
}

#pragma mark -
#pragma mark Text Field Delegate delegate methods


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[rcUname resignFirstResponder];
	[rcPassword resignFirstResponder];
	[rcName resignFirstResponder];
	[rcOverview resignFirstResponder];
	[rcAdd1 resignFirstResponder];
	[rcAdd2 resignFirstResponder];
    [rcAdd3 resignFirstResponder];
	//[rcIRBNum resignFirstResponder];
	[rcBusinessNo resignFirstResponder];
	[rcFaxNo resignFirstResponder];
	[rcContactName resignFirstResponder];
	[rcEmail1 resignFirstResponder];
	[rcEmail2 resignFirstResponder];
	[rcURL resignFirstResponder];
	[rcMobileNO resignFirstResponder];
    [rcConfPass resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    
    	return YES;
}


-(IBAction)countryButtonPressed{
    
    if ([countriesDicArray count]>0) {
        
      
        rcAdd2.text=[[NSString stringWithFormat:@"%@",[[countriesDicArray objectAtIndex:238]valueForKey:@"country"]]retain];
        countryId=[[NSString stringWithFormat:@"%@",[[countriesDicArray objectAtIndex:238]valueForKey:@"cid"]]retain];
        [selectCountryBtn setTitle:rcAdd2.text forState:UIControlStateNormal];
        
        rcAdd3.text=@"Select State";
        [selectStateBtn setTitle:rcAdd3.text forState:UIControlStateNormal];

        
        [stateNameArray removeAllObjects];
        
       
        
        
        pkrCountry = [[UIPickerView alloc] init];
        pkrCountry.delegate=self;
        pkrCountry.dataSource=self;
        [pkrCountry setShowsSelectionIndicator:YES];
        [pkrCountry setTag:6];
        
        UIActionSheet *conActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Country\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];
        [pkrCountry selectRow:238 inComponent:0 animated:NO];
        
        conActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [conActionSheet setBounds:CGRectMake(0, 0, 320, 250)];
        conActionSheet.tag=6;
        [conActionSheet addSubview:pkrCountry];
        [conActionSheet showInView:self.tabBarController.tabBar];
        [pkrCountry reloadAllComponents];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found. \nPlease Try Again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release]; 
    }

    
}
-(IBAction)stateButtonPressed{
    
    [pickerState reloadAllComponents];
    
   
    
    
    if ([stateNameArray count]>0) {
        
        rcAdd3.text=[[stateNameArray objectAtIndex:0]retain];
        [selectStateBtn setTitle:rcAdd3.text forState:UIControlStateNormal];
        
        pickerState = [[UIPickerView alloc] init];
        pickerState.delegate=self;
        pickerState.dataSource=self;
        [pickerState setShowsSelectionIndicator:YES];
        [pickerState setTag:7];
        
        UIActionSheet *stateActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Country\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];
        
        stateActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [stateActionSheet setBounds:CGRectMake(0, 0, 320, 250)];
        stateActionSheet.tag=7;
        [stateActionSheet addSubview:pickerState];
        [stateActionSheet showInView:self.tabBarController.tabBar];
        [pickerState reloadAllComponents];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found. \nPlease Try Again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release]; 
    }
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
       
    if (textField.tag==6) {
    
        if ([countriesDicArray count]>0) {
               
        [textField resignFirstResponder];
        pkrCountry = [[UIPickerView alloc] init];
        pkrCountry.delegate=self;
        pkrCountry.dataSource=self;
        [pkrCountry setShowsSelectionIndicator:YES];
        [pkrCountry setTag:6];
        
        UIActionSheet *conActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Country\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];
            [pkrCountry selectRow:238 inComponent:0 animated:NO];

        conActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [conActionSheet setBounds:CGRectMake(0, 0, 320, 250)];
        conActionSheet.tag=6;
        [conActionSheet addSubview:pkrCountry];
        [conActionSheet showInView:self.tabBarController.tabBar];
        [pkrCountry reloadAllComponents];

        }
        
    }
    
    if (textField.tag==7) {
        
        [pickerState reloadAllComponents];
        
        if ([stateNameArray count]>0) {
            
            [textField resignFirstResponder];
            pickerState = [[UIPickerView alloc] init];
            pickerState.delegate=self;
            pickerState.dataSource=self;
            [pickerState setShowsSelectionIndicator:YES];
            [pickerState setTag:7];
            
            UIActionSheet *stateActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Country\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];

            stateActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [stateActionSheet setBounds:CGRectMake(0, 0, 320, 250)];
            stateActionSheet.tag=7;
            [stateActionSheet addSubview:pickerState];
            [stateActionSheet showInView:self.tabBarController.tabBar];
            [pickerState reloadAllComponents];
            
        }
        
    }
    
    
    
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
    [selectCountryBtn release];
    selectCountryBtn = nil;
    [selectStateBtn release];
    selectStateBtn = nil;
    [rcAdd4 release];
    rcAdd4 = nil;
    [detailLable release];
    detailLable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
