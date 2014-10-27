//
//  MultiPolygon.h
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import <Foundation/Foundation.h>
#import "Geometry.h"

@interface MultiPolygon : NSObject <Geometry>

-(id)initWithString:(NSString *)str;

@end
