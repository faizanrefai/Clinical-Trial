//
//  DetailView.m
//  ClinicalRecuiter
//
//  Created by Hirak on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailView.h"
#import "JSON.h"
#import "NSDataAdditions.h"
#import "AlertHandler.h"
#import "EGOCache.h"

static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;

@implementation DetailView
@synthesize rcUname,rcName,rcOverview,rcAdd1,rcAdd2,rcAdd4,rcAdd3,rcBusinessNo,rcFaxNo,rcContactName,rcEmail1,rcEmail2,rcURL,rcArea,rcMobileNO;
@synthesize scrlView,pkrExpArea,isFromLogin,lblExpArea,picker,btnPhoto,imgPhoto;
@synthesize txtExpAre,lblAreaExpNew,imgAreaExpNew;

@synthesize pkrCountry;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.



- (void)viewDidLoad {
    
    [super viewDidLoad];
	[btnToggle setSelected:YES];
	self.navigationController.navigationBarHidden=TRUE;
    countExpAre = [[NSString alloc] init];
    countriesDicArray =[[NSMutableArray alloc] init];
    stateNameArray = [[NSMutableArray alloc]init];
    strImg =[[NSString alloc]init];
    [self GetCountryData];

    allkeysDic =[[NSMutableDictionary alloc]init];
    
	//self.navigationItem.title=@"Profile";
	arrayNo = [[NSMutableArray alloc] initWithObjects:@"Cardiology/Vascular",@"Dental/Maxillofacial",@"Dermatology/Plastic",@"Endocrinology",@"Gastroenterology",@"Hematology",@"Immunology/ID",@"Internal Medicine",@"Musculoskeletal",@"Nephrology/Urology",@"Neurology",@"Ob/Gyn?Oncology",@"Opthalmology",@"Orthopedics",@"Otolaryngology",@"Pediatric/Neonate",@"Pharmacology/Tox",@"Podiatry",@"Psychiatry",@"Pulmonary",@"Rheumatology",@"Sleep Medicine",@"Trauma/Emergency",@"Healthy Patients",nil];                                                                         
	//lblRBINum.enabled=FALSE;
	pickerView = [[ALPickerView alloc] init];
	pickerView.delegate = self;
	entries = [[NSArray alloc] initWithArray:arrayNo];
	selectionStates = [[NSMutableDictionary alloc] init];
	arr11 = [[NSMutableArray alloc] init];
	
	
	picker = [[UIImagePickerController alloc] init];
	[self.picker setDelegate:self];
	//picker.allowsImageEditing = TRUE;
	
	rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditing)];
	rightBtn.possibleTitles = [NSSet setWithObjects:@"Edit",@"Done",nil];
	self.navigationItem.rightBarButtonItem = rightBtn;
	
	BtnLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutClicked:)];
	self.navigationItem.leftBarButtonItem = BtnLogout;
	
	[researchBtnAdd setHidden:YES];
	scrlView.contentSize=CGSizeMake(320, 1320);
	appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    userID = [[NSString alloc]init];
	userID = [appDel.dictUserData valueForKey:@"uid"];
	
	[AlertHandler showAlertForProcess];
		
	rcUname.enabled =FALSE;
	rcName.enabled=FALSE;
	rcOverview.enabled=FALSE;
	rcAdd4.enabled=FALSE;
	rcAdd3.enabled=FALSE;
	rcContactName.enabled=FALSE;
	rcBusinessNo.enabled=FALSE;
	rcMobileNO.enabled=FALSE;
	rcFaxNo.enabled=FALSE;
	rcEmail1.enabled=FALSE;
	rcEmail2.enabled=FALSE;
	rcURL.enabled=FALSE;
	btnAreaExp.enabled=FALSE;
	txtExpAre.editable=FALSE;
	btnPhoto.enabled=FALSE;
    selectStateBtn.userInteractionEnabled=FALSE;
    selectCountryBtn.userInteractionEnabled=FALSE;
    
    

}

# pragma Mark- Webservices division



-(void)GetCountryData
{
    NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/country.php"];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
    NSLog(@"%@",parser);
    
}

-(void)searchResult:(NSDictionary*)dictionary
{
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



# pragma Mark- IBAction division




-(IBAction)countryButtonPressed{
     
    if ([countriesDicArray count]>0) {
        
        countryId=[[NSString stringWithFormat:@"%@",[[countriesDicArray objectAtIndex:238]valueForKey:@"cid"]]retain];
        [selectCountryBtn setTitle:[[NSString stringWithFormat:@"%@",[[countriesDicArray objectAtIndex:238]valueForKey:@"country"]]retain] forState:UIControlStateNormal];
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
        [conActionSheet showInView:self.view];
        [pkrCountry reloadAllComponents];
        
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found. Please Try Again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release]; 
    }
    
}
-(IBAction)stateButtonPressed{
    
    [pickerState reloadAllComponents];
    
    if ([stateNameArray count]>0) {
        
        [selectStateBtn setTitle:[[stateNameArray objectAtIndex:0]retain] forState:UIControlStateNormal];
        
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
        [stateActionSheet showInView:self.view];
        [pickerState reloadAllComponents];
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found. Please Try Again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release]; 
    }

}

-(void)imgLoad:(NSURL*)imgUrl{

    [myimageView2 removeFromSuperview];
    myimageView2.image = nil;
    myimageView2 = nil;
    [myimageView2 release];
    
        myimageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"checkTrue.png"]];
        myimageView2.frame =CGRectMake(0, 0, 99, 81);
        myimageView2.delegate = self;
        myimageView2.imageURL = imgUrl;	

        [imgPhoto addSubview:myimageView2];
    
    NSData *data =[[NSData alloc]initWithContentsOfURL:imgUrl];
    myimageView2.image=[UIImage imageWithData:data];
    
    [AlertHandler hideAlert];

   
    NSData *imgData =UIImageJPEGRepresentation(myimageView2.image, 0.50);
    strImg = [[imgData base64Encoding] retain];
    
}


-(UIImage *)scaleImage:(UIImage*)image toResolution:(int)resolution {
    CGImageRef imgRef = [image CGImage];
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    //if already at the minimum resolution, return the orginal image, otherwise scale
    if (width <= resolution && height <= resolution) {
        return image;
        
    } else {
        CGFloat ratio = width/height;
        
        if (ratio > 1) {
            bounds.size.width = resolution;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = resolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    [image drawInRect:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
    
}



-(void)finisheParsing:(NSDictionary*)dictionary
{
	
    
    
    [appDel.dicSubscribInfo removeAllObjects];
    
    [appDel.dicSubscribInfo addEntriesFromDictionary:dictionary];
    
    
    
    NSLog(@"%@",appDel.dicSubscribInfo);

    
	NSString *centerID = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_id"];
	[[NSUserDefaults standardUserDefaults] setValue:centerID forKey:@"userProfileID"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	NSString *usename = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"username"];
	NSString *rcname  = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_name"];
	[[NSUserDefaults standardUserDefaults] setValue:rcname forKey:@"centerName"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	//NSString *rbiNum    = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"approveno"];
	
	NSString *over    = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"overview"];
	NSString *add1    = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address1"];
	NSString *add2    = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address2"];
	NSString *add3    = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address3"];
	rcAdd4.text  = [[[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address4"]retain];
    
    NSString *contact = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"contact_name"];
	NSString *bsnsNum = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"business_number"];
	NSString *mobNum  = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"mobile_number"];
	NSString *faxNum  = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"fax_number"];
	NSString *emai1   = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"contact_email1"];
	NSString *emai2   = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"contact_email2"];
	NSString *strURL  = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"URL"];
	
    
   //Image section
    
    NSString *photoURL = [[[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"center_photo"]retain];
    NSURL *url1 = [NSURL URLWithString:[photoURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    // Image Section
    [[EGOCache currentCache]clearCache];
    [self performSelector:@selector(imgLoad:) withObject:url1 afterDelay:1];
    
    
    //if(![[appDel.dictUserData  valueForKey:@"role"]isEqualToString:@"Sponcer"]){
	NSString *countexpAre =[[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"expertise_area"];
	
    NSArray *selecArr = [[NSArray alloc]init] ;
                         selecArr = [countexpAre componentsSeparatedByString:@","];
	
	for (NSString *key in entries)
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	
	[selecArr retain];
	for (NSString *abc in entries){
		for (int i = 0; i<[selecArr count]; i++){			
			//NSString *str = [NSString stringWithFormat:@"%@",[selecArr objectAtIndex:0]];	
			
			id value1 = [selecArr objectAtIndex:0];
			NSString *str11 = @"";
			if(value1 != [NSNull null])
				str11 = (NSString *)value1;
			
			//
//NSLog(@"%@",str11);
			if ([str11 length]>0){
				[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[arrayNo objectAtIndex:[[selecArr objectAtIndex:i]intValue]-1]];
			}
		}
	}
	
	NSMutableArray *oldSelected = [[NSMutableArray alloc] init];
	for (int j=0; j<[selecArr count]; j++)
	{
		id value1 = [selecArr objectAtIndex:0];
		NSString *str11 = @"";
		if(value1 != [NSNull null])
			str11 = (NSString *)value1;
		
		if ([str11 length]>0)
		{
			[oldSelected addObject:[arrayNo objectAtIndex:[[selecArr objectAtIndex:j]intValue]-1]];
		}
	}
	NSLog(@"%@",oldSelected);
	NSString *strOldEntry =@"";
	
	for (int i=0; i<[oldSelected count]; i++)
	{
		if (i==[oldSelected count]-1)
		{
			strOldEntry = [strOldEntry stringByAppendingString:[NSString stringWithFormat:@"%@",[oldSelected objectAtIndex:i]]];
		}
		else
		{
			strOldEntry = [strOldEntry stringByAppendingString:[NSString stringWithFormat:@"%@,",[oldSelected objectAtIndex:i]]];
		}
	}
	NSLog(@"%@",strOldEntry);
		txtExpAre.text = strOldEntry;
	
	if ([countexpAre isEqualToString:@""]){
		
		txtExpAre.hidden=TRUE;
		lblAreaExpNew.hidden=TRUE;
		imgAreaExpNew.hidden=TRUE;		
		btnAreaExp.hidden=TRUE;
		lblExpArea.hidden=TRUE;
		btnAddTrails.frame =CGRectMake(15, 540, 149, 37);
		btnSubscribe.frame =CGRectMake(19, 580, 285, 37);
		researchBtnAdd.frame =CGRectMake(19, 624, 285, 37);
		bgImag.frame =CGRectMake(11, 9, 300, 664);
		scrlView.frame =CGRectMake(0, 44, 320, 750);
		btnListTrails.frame =CGRectMake(160, 540, 149, 37);
		scrlView.contentSize =CGSizeMake(320,1070);

	}
	else {
		
		lblAreaExpNew.hidden=FALSE;
		imgAreaExpNew.hidden=FALSE;
		txtExpAre.hidden=FALSE;
		btnAreaExp.hidden=FALSE;
		lblExpArea.hidden=FALSE;
		btnAddTrails.frame =CGRectMake(15, 635, 149, 37);
		
		btnSubscribe.frame =CGRectMake(19, 675, 285, 41);
		researchBtnAdd.frame =CGRectMake(20, 719, 285, 46);
		bgImag.frame =CGRectMake(11, 9, 300, 771);
		scrlView.frame =CGRectMake(0, 44, 320, 900);
		btnListTrails.frame =CGRectMake(160, 635, 149, 37);
		scrlView.contentSize =CGSizeMake(320,1320);

	}
	
	
        rcUname.text = usename;
	rcName.text=rcname;
	rcOverview.text=over;
	//rcAdd1.text=add1;
	//rcAdd2.text=add2;
	rcAdd3.text=add3;
	rcContactName.text=contact;
	rcBusinessNo.text=bsnsNum;
	rcMobileNO.text=mobNum;
	rcFaxNo.text=faxNum;
	rcEmail1.text=emai1;
	rcEmail2.text=emai2;
	rcURL.text=strURL;
    
    [selectStateBtn setTitle:add2 forState:UIControlStateNormal];
	[selectCountryBtn setTitle:add1 forState:UIControlStateNormal];

   

}

-(IBAction)addTrailsClicked:(id)sender
{
	appDel.isEditTrail = FALSE;
    
  //  NSString *Payment_create_date = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"Payment_create_date"];
    
    NSString *payment_expiry_date = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
    
    NSString *payment_plan = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
  //  NSString *payment_status = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];

    // Date comparision
    
    NSDate *Date1 = [NSDate date];
      
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *Date2 = [dateFormat dateFromString:payment_expiry_date];  
    
    NSComparisonResult result = [Date1 compare:Date2];
    
    if (result==NSOrderedAscending) {
      
        AddClinicalTrails *  Addq = [[AddClinicalTrails alloc] initWithNibName:@"AddClinicalTrails" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:Addq animated:YES];
        [Addq release];

        NSLog(@"payment_expiry_date  Date2 is in the future");
        
    } else if (result==NSOrderedDescending) {
        
        if([payment_plan isEqualToString:@"Free-Plan"]){
            
            if ([[[allkeysDic valueForKey:@"trials"] allKeys] count]==3)
            {
            
                NSString *str = [NSString stringWithFormat:@"You have selected the Free Subscription Plan. You may list up to 3 clinical trials for free per center for 1 year.\n  You have currently reached your trial limit of 3 trials. If you would like to add more trials you will need to upgrade to a monthly or yearly subscription plan."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release]; 
                return;
  
            
            } else if ([[[allkeysDic valueForKey:@"trials"] allKeys] count])
                
            {
                NSString *str = [NSString stringWithFormat:@"You have selected the Free Subscription Plan. You may list up to 3 clinical trials for free per center for 1 year.\n You have currently added %d trial. You may add %d more trials.",[[[allkeysDic valueForKey:@"trials"] allKeys] count],3-[[[allkeysDic valueForKey:@"trials"] allKeys] count]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release]; 
                return;

            }
            
            NSString *str = [NSString stringWithFormat:@"You have selected the Free Subscription Plan. You may list up to 3 clinical trials for free per center for 1 year.\n You have currently added %d trial. You may add %d more trials.",[[[allkeysDic valueForKey:@"trials"] allKeys] count],3-[[[allkeysDic valueForKey:@"trials"] allKeys] count]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release]; 
 
            
        }else
        {
            NSString *str;
            
            str = [NSString stringWithFormat:@"Your %@ Subscription Was Expired, Please View Subscription Options",payment_plan];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release]; 
            
            
        }
        
        NSLog(@"payment_expiry_date  Expired dates");
        
    } else if(result==NSOrderedSame) {
        
        NSLog(@"payment_expiry_date  Both dates are the same");
       
       
        if ([payment_expiry_date isEqualToString:@"0000-00-00"]) {
           
            
            if([payment_plan isEqualToString:@"Free-Plan"]){
                
                if ([[[allkeysDic valueForKey:@"trials"] allKeys] count]==3)
                {
                    
                    NSString *str = [NSString stringWithFormat:@"You have selected the Free Subscription Plan. You may list up to 3 clinical trials for free per center for 1 year.\n  You have currently reached your trial limit of 3 trials. If you would like to add more trials you will need to upgrade to a monthly or yearly subscription plan."];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release]; 
                    return;
                    
                    
                } else if ([[[allkeysDic valueForKey:@"trials"] allKeys] count])
                    
                {
                    NSString *str = [NSString stringWithFormat:@"You are using Free Subscription Plan, and you allows to add only 3 free trial listing per center for 1 year only.\n And your No. of added trial is %d.\n Please note, Free Members are listed below paid members in search result.",[[[allkeysDic valueForKey:@"trials"] allKeys] count]];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release]; 
                    return;
                    
                }
                
                NSString *str = [NSString stringWithFormat:@"You have selected the Free Subscription Plan. You may list up to 3 clinical trials for free per center for 1 year.\n You have currently added %d trial. You may add %d more trials.",[[[allkeysDic valueForKey:@"trials"] allKeys] count],3-[[[allkeysDic valueForKey:@"trials"] allKeys] count]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release]; 
                
                
            }else
            {
            
                
                NSString *str = [NSString stringWithFormat:@"Your %@ Subscription Was Expired, Please View Subscription Options",payment_plan];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release]; 
                
            
            }
            
        }
        else{
            
            AddClinicalTrails *  Add = [[AddClinicalTrails alloc] initWithNibName:@"AddClinicalTrails" bundle:nil];
            [self.navigationController pushViewController:objAdd animated:YES];
            [Add release];
                  
        }

    }
	
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        
        switch (buttonIndex) {
 
            case 0:{
                
                break;
            }
                
            case 1:{ 
                
                if (objAdd) {
                objAdd=nil;
                [objAdd release];
           
                }
                objAdd = [[SubscriptionInfoView alloc] initWithNibName:@"SubscriptionInfoView" bundle:nil];
                [self.navigationController pushViewController:objAdd animated:YES];

                break;
            }
                
            case 2:{
                
                AddClinicalTrails *  Addq = [[AddClinicalTrails alloc] initWithNibName:@"AddClinicalTrails" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:Addq animated:YES];
                [Addq release];
                
                break;
            }
                
            default:
                break;
        }       
        
        return; 
    }
    
      
    if (objAdd) {
        objAdd=nil;
        [objAdd release];
    }
    objAdd = [[SubscriptionInfoView alloc] initWithNibName:@"SubscriptionInfoView" bundle:nil];
    [self.navigationController pushViewController:objAdd animated:YES];
    
}

-(IBAction)onSbuscribe:(id)sender{ 
	
    NSString *payment_expiry_date = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
    
    NSString *payment_plan = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
    //  NSString *payment_status = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];
    
    // Date comparision
    
    NSDate *Date1 = [NSDate date];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *Date2 = [dateFormat dateFromString:payment_expiry_date];  
    
    NSComparisonResult result = [Date1 compare:Date2];
    
    if (result==NSOrderedAscending) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"You are currently using %@ Subscription.\n Your Plan will be expire on\n %@",payment_plan,payment_expiry_date]  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"View Subscription Option",@"Add Trial",nil];
        alert.tag=1;
        [alert show];
        [alert release];

         
        NSLog(@"payment_expiry_date  Date2 is in the future");
        return;
        
    }
    
    

    if ([payment_plan isEqualToString:@"Monthly-Plan"]) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"You are currently using Monthly Subscription plan.\n Your Plan will be expire on %@",payment_expiry_date]  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
   
        
    }else 
        if([payment_plan isEqualToString:@"Yearly-Plan"]){
    
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"You are currently using Yearly Subscription plan.\n Your Plan will be expire on\n %@",payment_expiry_date]  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
    
    }
        else {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"View Subscription Options" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
            
    }

}
-(IBAction)toggleEditing :(id)sender
{
	if ([btnToggle isSelected])
	{
		
        isEdit = NO;
		[btnToggle setImage:[UIImage imageNamed:@"Done.png"] forState:UIControlStateNormal];
		[btnToggle setSelected:NO];
		//self.navigationItem.rightBarButtonItem.title = @"Done";
		
		rcName.enabled=TRUE;
		rcOverview.enabled=TRUE;
		//rcAdd1.enabled=TRUE;
		//rcAdd2.enabled=TRUE;
		rcAdd4.enabled=TRUE;
		rcAdd3.enabled=TRUE;
		rcContactName.enabled=TRUE;
		rcBusinessNo.enabled=TRUE;
		rcMobileNO.enabled=TRUE;
		rcFaxNo.enabled=TRUE;
		rcEmail1.enabled=TRUE;
		rcEmail2.enabled=TRUE;
		rcURL.enabled=TRUE;
		
		btnAreaExp.enabled=TRUE;
		txtExpAre.editable=TRUE;
		btnPhoto.enabled=TRUE;
        selectCountryBtn.userInteractionEnabled=TRUE;
        selectStateBtn.userInteractionEnabled=TRUE;
        
		[researchBtnAdd setHidden:NO];
	}
	else 
	{
		
		[btnToggle setImage:[UIImage imageNamed:@"Edit.png"] forState:UIControlStateNormal];
		[btnToggle setSelected:YES];
		
		isEdit = YES;
		//self.navigationItem.rightBarButtonItem.title = @"Edit";
		rcUname.enabled = FALSE;
		rcName.enabled=FALSE;
		rcOverview.enabled=FALSE;
		//rcAdd1.enabled=FALSE;
		//rcAdd2.enabled=FALSE;
		rcAdd4.enabled=FALSE;
		rcAdd3.enabled=FALSE;
		rcContactName.enabled=FALSE;
		rcBusinessNo.enabled=FALSE;
		rcMobileNO.enabled=FALSE;
		rcFaxNo.enabled=FALSE;
		rcEmail1.enabled=FALSE;
		rcEmail2.enabled=FALSE;
		rcURL.enabled=FALSE;
		btnAreaExp.enabled=FALSE;
		txtExpAre.editable=FALSE;
		btnPhoto.enabled=FALSE;
        
        selectCountryBtn.userInteractionEnabled=FALSE;
        selectStateBtn.userInteractionEnabled=FALSE;
        
		[researchBtnAdd setHidden:YES];
	}
}
-(IBAction)logoutClicked :(id)sender
{
	if (isFromLogin==TRUE)
	{
		[self dismissModalViewControllerAnimated:YES];
	}
	else
	{
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}


-(void)listOfTrail
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
    
    NSString *centerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userProfileID"];

	NSString *urlStringer = [NSString stringWithFormat:@"http://openxcelluk.info/clinical/web_services/list_trial.php?research_center_id=%@",centerID];
	urlStringer = [urlStringer stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStringer]];
	JSONParser *parser;
    parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(listOfTrailReslt:) andHandler:self];
    NSLog(@"listOfTrailReslt:(NSDictionary*)dic %@",urlStringer);

}


-(void)listOfTrailReslt:(NSDictionary*)dic
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;
    
    NSLog(@"[[[dic valueForKey:] allKeys] count]%d", [[[dic valueForKey:@"trials"] allKeys] count] );
    NSLog(@"[[[dic valueForKey:] allKeys] count]%@", dic );
    
    if ([[dic valueForKey:@"msg"] isEqualToString:@"no trial found"]) {
        
        return;
    }
    
    [allkeysDic setValuesForKeysWithDictionary:nil];
    
    [allkeysDic setValuesForKeysWithDictionary:dic];

}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    
    
    if ([btnToggle isSelected]){
    
        [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;

    WSPContinuous *wspcontinuous;
	wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[webService getURq_getansascreen:[webService getWS_profile:userID]] 
															rootTag:@"Record" 
														startingTag:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
														  endingTag:[NSDictionary dictionaryWithObjectsAndKeys:@"research_center_id",@"research_center_id",@"username",@"username",@"research_center_name",@"research_center_name",@"overview",@"overview",@"center_photo",@"center_photo",@"address1",@"address1",@"address2",@"address2",@"address3",@"address3",@"address4",@"address4",@"approveno",@"approveno",@"business_number",@"business_number",@"fax_number",@"fax_number",@"contact_name",@"contact_name",@"contact_email1",@"contact_email1",@"contact_email2",@"contact_email2",@"URL",@"URL",@"expertise_area",@"expertise_area",@"mobile_number",@"mobile_number",@"role",@"role",@"center_status",@"center_status",@"N"@"payment_plan",@"payment_plan",@"payment_status",@"payment_status",@"payment_expiry_date",@"payment_expiry_date",@"Payment_create_date",@"Payment_create_date",nil] 
														  otherTags:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
																sel:@selector(finisheParsing:) 
														 andHandler:self];
    [self performSelectorInBackground:@selector(listOfTrail) withObject:nil];
        
        
    }

}

-(IBAction)listTrailsClicked:(id)sender
{
	ListTrails *objList = [[ListTrails alloc] initWithNibName:@"ListTrails" bundle:nil];
	[self.navigationController pushViewController:objList animated:YES];
	[objList release];
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
	[ExpArea showInView:self.view];
	[pkrExpArea reloadAllComponents];
}
-(IBAction)photoClicked: (id)sender
{
	UIActionSheet *photoAction = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Galery",nil];
	[photoAction showInView:self.view];
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
            NSString *stateUrl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/states.php?cid=%@"@"239"];
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
						[myseleEntry addObject:[NSString stringWithFormat:@"%d",i]];
				}
			}
			
			//NSLog(@"%@",myseleEntry);
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
			
			NSMutableArray *newSelected = [[NSMutableArray alloc] init];
			for (int j=0; j<[myseleEntry count]; j++)
			{
				[newSelected addObject:[arrayNo objectAtIndex:[[myseleEntry objectAtIndex:j]intValue]]];
			}
			//NSLog(@"%@",newSelected);
			NSString *strNewEntry =@"";
			
			for (int i=0; i<[newSelected count]; i++)
			{
				if (i==[newSelected count]-1)
				{
					strNewEntry = [strNewEntry stringByAppendingString:[NSString stringWithFormat:@"%@",[newSelected objectAtIndex:i]]];
				}
				else
				{
					strNewEntry = [strNewEntry stringByAppendingString:[NSString stringWithFormat:@"%@,",[newSelected objectAtIndex:i]]];
				}
			}
			//NSLog(@"%@",strNewEntry);
			
			txtExpAre.text = strNewEntry;
		}
	}
	else if (actionSheet.tag==2)
	{
		if (buttonIndex==0)
		{
			picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			[self presentModalViewController:picker animated:YES];
		}
		else if (buttonIndex==1)
		{
			picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentModalViewController:picker animated:YES];
		}
	}
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
	[self performSelector:@selector(expAreaClicked:)];
	return NO;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
}

- (void)imagePickerController:(UIImagePickerController *)pickers didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   
    myimageView2.image= [self scaleImage:img toResolution:200];
    NSData *imgData =UIImageJPEGRepresentation([self scaleImage:img toResolution:200], 0.50);
    strImg = [[imgData base64Encoding] retain];
    
}





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
#pragma mark Picker Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView1 numberOfRowsInComponent:(NSInteger)component;
{
    if (pickerView1.tag==7) {
        return [stateNameArray count];
    }
    if (pickerView1.tag==6) {
        return [countriesDicArray count];
    }

    else{
        return [arrayNo count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView1 titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	
    if (pickerView1.tag==7) {
        
        return [stateNameArray objectAtIndex:row];
        
    }
    if (pickerView1.tag==6) {
        
        NSMutableString *tempStr = [[[NSMutableString alloc]initWithFormat:@"%@",[[countriesDicArray objectAtIndex:row]valueForKey:@"country"]]retain];
        return tempStr;
    }
    
    
    if (pickerView1.tag==1)
	{
		return [arrayNo objectAtIndex:row];
	}
    
    else{
        return nil;
    }
}


- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
    if (pickerView1.tag==6) {
        
       // rcAdd1.text=[[[countriesDicArray objectAtIndex:row]valueForKey:@"country"]retain];
        countryId = [[NSString stringWithFormat:@"%@",[[countriesDicArray objectAtIndex:row]valueForKey:@"cid"]]retain];
        
        [selectCountryBtn setTitle:[[[countriesDicArray objectAtIndex:row]valueForKey:@"country"]retain] forState:UIControlStateNormal];
        [stateNameArray removeAllObjects];
        
    }
    if (pickerView1.tag==7)
	{       
        //rcAdd2.text=[[stateNameArray objectAtIndex:row]retain];
        [selectStateBtn setTitle:[[stateNameArray objectAtIndex:row]retain] forState:UIControlStateNormal];
        
 	}
    
    if (pickerView1.tag==1)
	{
		strExpArea = [[NSString alloc] initWithFormat:@"%@",[arrayNo objectAtIndex:row]];
		countExpAre = [[NSString alloc] initWithFormat:@"%d",row];
	}
}


-(void)alertHandler{

    NSString *Payment_create_date = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"Payment_create_date"];
    
    NSString *payment_expiry_date = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
  
      
    NSString *payment_plan = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
    
    NSString *payment_status = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];
    
      

    
    NSString *photoName = [[NSString alloc] initWithFormat:@"%@.jpg",rcUname.text];
	NSString *c11 = [[NSString alloc]init];
    c11 = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strImg, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
    NSString *tempStr= [[NSString alloc]init];
    
    tempStr= (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)rcOverview.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
    
	NSString *post =[NSString stringWithFormat:@"research_center_id=%@&research_center_name=%@&overview=%@&address1=%@&address2=%@&address3=%@&address4=%@&approveno=%@&upload_ad=%@&business_number=%@&fax_number=%@&contact_name=%@&contact_email1=%@&contact_email2=%@&URL=%@&expertise_area=%@&mobile_number=%@&center_photo_code=%@&center_photo=%@",userID,rcName.text,tempStr,[selectCountryBtn currentTitle],[selectStateBtn currentTitle],rcAdd3.text,rcAdd4.text,rcAdd4.text,rcAdd4.text,rcBusinessNo.text,rcFaxNo.text,rcContactName.text,rcEmail1.text,rcEmail2.text,rcURL.text,countExpAre,rcMobileNO.text,c11,photoName];
    
    NSLog(@"%@",post);
    
    NSString *postD = [NSString stringWithFormat:@"&Payment_create_date=%@&payment_expiry_date=%@&payment_plan=%@&payment_status=%@",Payment_create_date,payment_expiry_date,payment_plan,payment_status];
    
    [tempStr release];
    
    NSMutableData *postData = [NSMutableData data ];
    
   [postData appendData:[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
   [postData appendData:[postD dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:@"http://openxcelluk.info/clinical/web_services/update.php"]];
    [request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
    [AlertHandler hideAlert];

    
    [[EGOCache currentCache]clearCache];
	
	NSMutableDictionary *temp = [data JSONValue];
	NSString *msg = [[NSString alloc] initWithFormat:@"%@",[temp valueForKey:@"msg"]];
    
    NSLog(@"%@",msg);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Record Updated Successfully!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
 

}
-(IBAction)researchAddClicked:(id)sender
{
	
   [AlertHandler showAlertForProcess];
    
    [self performSelector:@selector(alertHandler) withObject:nil afterDelay:0.3];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[rcUname       resignFirstResponder];
	[rcName        resignFirstResponder];
	[rcOverview    resignFirstResponder];
	//[rcAdd1        resignFirstResponder];
	//[rcAdd2        resignFirstResponder];
    [rcAdd4        resignFirstResponder];
    [rcAdd3        resignFirstResponder];
	[rcBusinessNo  resignFirstResponder];
	[rcFaxNo       resignFirstResponder];
	[rcContactName resignFirstResponder];
	[rcEmail1      resignFirstResponder];
	[rcEmail2      resignFirstResponder];
	[rcURL         resignFirstResponder];
    [rcArea        resignFirstResponder];
	[rcMobileNO    resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
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
    [rcAdd4 release];
    rcAdd4 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [rcAdd4 release];
    [super dealloc];
}


@end
