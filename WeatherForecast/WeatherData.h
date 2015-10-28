//
//  WeatherData.h
//  WeatherForecast
//
//  Created by Ye Lu on 10/23/15.
//  Copyright (c) 2015 Raye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *tempreture;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *weatherDesciption;

+(WeatherData*)parseData:(NSDictionary*)data;


@end
