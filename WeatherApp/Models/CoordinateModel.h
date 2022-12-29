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
@property NSString *longitude;
@property NSString *latitude;

//Initializer
- (instancetype)initWithLongitude: (NSString *)longitude andLatitude: (NSString *)latitude;

//Methods
+ (NSArray *)fetchCoord;

@end

NS_ASSUME_NONNULL_END
