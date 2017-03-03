//
//  CDMMovieController.h
//  MovieSearch
//
//  Created by Christian McMullin on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CDMMovie;

@interface CDMMovieController : NSObject

+ (void)fetchMoviesWithQuery:(NSString *)query completion:(void(^)(NSArray<CDMMovie *> *movies))completion;
+ (void)fetchMovieImageWithPath:(NSString *)path completion:(void (^)(UIImage *))completion;

@end
