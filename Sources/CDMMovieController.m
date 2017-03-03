//
//  CDMMovieController.m
//  MovieSearch
//
//  Created by Christian McMullin on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "CDMMovieController.h"
#import "MovieSearch-Swift.h"
#import "CDMMovie.h"

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const apiKey = @"e3cdbac157682e09c79e268f7afedcd5";
static NSString * const baseImageURLString = @"http://image.tmdb.org/t/p/w500";

@implementation CDMMovieController

+ (void)fetchMoviesWithQuery:(NSString *)query completion:(void (^)(NSArray<CDMMovie *> *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *api_keyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"query" value:query];
    NSArray *componentsArray = @[api_keyItem, queryItem];
    [urlComponents setQueryItems:componentsArray];
    
    NSURL *url = urlComponents.URL;
    
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) { NSLog(@"Error: problem with dataTaskWithURL:\n %@", error); completion(nil); }
        
        if(!data) { NSLog(@"No data was recived with NSURLSession"); completion(nil); }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *moviesArrayOfDicts = jsonDictionary[@"results"];
        NSMutableArray *moviesArray = [[NSMutableArray alloc]init];
        for (NSDictionary *movie in moviesArrayOfDicts) {
            CDMMovie *newMovie = [[CDMMovie alloc]initWithDictionary:movie];
            if (newMovie.posterURLString) {
                [moviesArray addObject:newMovie];
            }
        }
        completion(moviesArray);
     }]resume];
}

+ (void)fetchMovieImageWithPath:(NSString *)path completion:(void (^)(UIImage *))completion
{
    NSURL *imageURL = [NSURL URLWithString:baseImageURLString];
    NSURL *imageEndpoint = [imageURL URLByAppendingPathComponent:path];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:imageEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) { NSLog(@"Error finding image: %@", error); completion(nil); }
        
        if (!data) { NSLog(@"Error in retriveing image data"); completion(nil); }
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        completion(image);
        
    }]resume];
    
}

@end
