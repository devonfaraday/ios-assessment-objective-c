//
//  CDMMovie.m
//  MovieSearch
//
//  Created by Christian McMullin on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "CDMMovie.h"

@implementation CDMMovie

- (instancetype)init
{
    return [self initWithTitle:@"" overview:@"" rating:0 posterURLString:@""];
}

- (instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview rating:(double)rating posterURLString:(NSString *)posterURLString
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _overview = [overview copy];
        _rating = rating;
        _posterURLString = [posterURLString copy];
    }
    
    return self;
}

@end

@implementation CDMMovie (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
        NSString *title = dictionary[@"title"];
        NSString *overview  = dictionary[@"overview"];
        double rating = [dictionary[@"vote_average"] doubleValue];
        NSString *posterURLString = dictionary[@"poster_path"];
    
    
        if (![title isKindOfClass:[NSString class]] || ![overview isKindOfClass:[NSString class]] || ![posterURLString isKindOfClass:[NSString class]]) {
            return nil;
        }
    
        return [self initWithTitle:title overview:overview rating:rating posterURLString:posterURLString];
}

@end
