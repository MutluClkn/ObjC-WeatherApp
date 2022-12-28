//
//  QDCoordinateData.h
//  WeatherApp
//
//  Created by Mutlu Çalkan on 28.12.2022.
//

#import <Foundation/Foundation.h>

@class QDWeatherData;
@class QDCoord;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QDWeatherData : NSObject
@property (nonatomic, strong) QDCoord *coord;
@property (nonatomic, copy)   NSString *name;
@end

@interface QDCoord : NSObject
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) double lat;
@end

NS_ASSUME_NONNULL_END
