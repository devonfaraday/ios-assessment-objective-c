//
//  CDMMovie.h
//  MovieSearch
//
//  Created by Christian McMullin on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDMMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, readonly) double rating;
@property (nonatomic, copy, readonly) NSString *posterURLString;

- (instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview rating:(double)rating posterURLString:(NSString *)posterURLString NS_DESIGNATED_INITIALIZER;

@end

@interface CDMMovie (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
