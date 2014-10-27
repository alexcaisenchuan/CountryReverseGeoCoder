//
//  LinearRing.h
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import <Foundation/Foundation.h>
#import "Geometry.h"

@interface LinearRing : NSObject <Geometry>

-(id)initWithPointString:(NSString *)str;
-(id)initWithPointArray:(NSArray *)arr;

@end
