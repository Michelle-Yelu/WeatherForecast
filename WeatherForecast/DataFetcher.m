//
//  DataFetcher.m
//  WeatherForecast
//
//  Created by Ye Lu on 10/23/15.
//  Copyright (c) 2015 Raye. All rights reserved.
//

#import "DataFetcher.h"


#define OPENWEATHERMAP_APP_ID @"ece233e9189fb4678508919baaf4eb9d"

@implementation DataFetcher



+(void)fetchDataWithURL:(NSURL*)url completionHandler:(void(^)(NSData *, NSURLResponse *, NSError *))complete {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        complete(data, response, error);
    }];
    [dataTask resume];
}



+(void)fetchDataWithLocationLatitude:(float)latitude longitude:(float)longitude completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))complete{
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%@", latitude, longitude, OPENWEATHERMAP_APP_ID]];
    
    [DataFetcher fetchDataWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        complete(data, response, error);
    }];
}

+(void)fetchDataWithCityName:(NSString *)city completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))complete{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@", city, OPENWEATHERMAP_APP_ID]];
    [DataFetcher fetchDataWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        complete(data, response, error);
    }];
    
}

@end
