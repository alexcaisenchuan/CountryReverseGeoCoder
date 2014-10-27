//
//  Country.h
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import <Foundation/Foundation.h>
#import "Geometry.h"

@interface Country : NSObject

@property (strong, nonatomic) NSString* code;
@property (strong, nonatomic) NSObject<Geometry>* metry;

@end
