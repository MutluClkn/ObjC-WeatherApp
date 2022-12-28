//
//  CoordinateModel.h
//  WeatherApp
//
//  Created by Mutlu Çalkan on 28.12.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoordinateModel : NSObject
//Properties
@property NSNumber *longitude;
@property NSNumber *latitude;

//Initializer
- (instancetype)initWithLongitude: (NSNumber *)longitude andLatitude: (NSNumber *)latitude;

@end

NS_ASSUME_NONNULL_END
