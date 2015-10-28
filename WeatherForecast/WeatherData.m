//
//  WeatherData.m
//  WeatherForecast
//
//  Created by Ye Lu on 10/23/15.
//  Copyright (c) 2015 Raye. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

+(WeatherData *)parseData:(NSDictionary *)data {
    WeatherData *weatherData = [[WeatherData alloc] init];
    weatherData.cityName = [data objectForKey:@"name"];
    NSDictionary *sys = [data objectForKey:@"sys"];
    weatherData.countryCode = [sys objectForKey:@"country"];
    NSDictionary *main = [data objectForKey:@"main"];
    weatherData.tempreture = [[main objectForKey:@"temp"] stringValue];
    weatherData.humidity = [[main objectForKey:@"humidity"] stringValue];
    NSArray *weather = [data objectForKey:@"weather"];
    weatherData.weatherDesciption = [weather[0] objectForKey:@"description"];
    
    return weatherData;
    
}

@end
