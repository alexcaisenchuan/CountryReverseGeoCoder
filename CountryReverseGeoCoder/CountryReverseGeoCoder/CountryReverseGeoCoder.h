//
//  TestFileOP.h
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import <Foundation/Foundation.h>

@interface CountryReverseGeoCoder : NSObject

//Get the country code by latitude & longitude, country code is define in ISO 3166-1 two letter format
-(NSString *)getCountryCodeByLatitude:(double)lat andLongitude:(double)lon;

@end
