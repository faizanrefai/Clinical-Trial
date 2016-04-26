//
//  webService.h
//  ZawJi
//
//  Created by openxcell open on 11/16/10.
//  Copyright 2010 xcsxzc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface webService : NSObject {

}
+(NSMutableURLRequest*)getURq_getansascreen:(NSString*)ws_name;

//-------------------------------------------------------


+(NSString*)getWS_register :(NSString *)uname :(NSString *)pass :(NSString *)Confirm :(NSString *)center_name :(NSString *)overview :(NSString *)photo :(NSString *)address1 :(NSString *)address2 :(NSString *)address3 :(NSString *)business_num :(NSString *)fax_num :(NSString *)contact :(NSString *)email1 :(NSString *)email2 :(NSString *)URL :(NSString *)expertise :(NSString *)mobile_nu :(NSString *)role :(NSString *)status :(NSString *)imgCode;
+(NSString*)getWS_login :(NSString *)uname :(NSString *)pass;
+(NSString*)getWS_profile :(NSString *)userID;
+(NSString*)getWS_edit :(NSString *)userID :(NSString *)center_name :(NSString *)overview :(NSString *)address1 :(NSString *)address2 :(NSString *)address3 :(NSString *)business_num :(NSString *)fax_num :(NSString *)contact :(NSString *)email1 :(NSString *)email2 :(NSString *)URL :(NSString *)expertise :(NSString *)mobile_nu;
+(NSString*)getWS_searchByCenter :(NSString *)keyword;
+(NSString*)getWS_searchByExpArea :(NSString *)keyword;
+(NSString*)getWS_searchByLocation:(NSString *)lati :(NSString *)longi :(NSString *)area;
+(NSString*)getWS_allProfile;
+(NSString*)getWS_allCenter;
//+(NSString*)getWS_addTrails:(NSString *)center_id :(NSString *)trial_title :(NSString *)criteria :(NSString *)startDate :(NSString *)endDate :(NSString *)compansation;

@end