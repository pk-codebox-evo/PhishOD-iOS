//
//  PhishNetAPI.h
//  Phish Tracks
//
//  Created by Alec Gorge on 6/4/13.
//  Copyright (c) 2013 Alec Gorge. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "PhishNetSetlist.h"
#import "PhishNetReview.h"
#import "PhishNetTopShow.h"
#import "PhishNetJamChartEntry.h"
#import "PhishNetBlogItem.h"
#import "PhishNetNewsItem.h"
#import "PhishNetShow.h"
#import "PhishinSong.h"

#define PHISH_NET_API_KEY @"B6570BEDA805B616AB6C"
#define PHISH_NET_PUB_KEY @"E52DD6B46196E92CFB16"

@interface PhishNetAPI : AFHTTPRequestOperationManager {
	NSRegularExpression *findRating;
	NSRegularExpression *findVotes;
	NSRegularExpression *findTopRatings;
	
	NSRegularExpression *findIframe;
}

+(PhishNetAPI *)sharedAPI;

-(void)setlistForDate:(NSString *)date
			  success:(void ( ^ ) (PhishNetSetlist *))success
			  failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

-(void)jamsForSong:(PhishinSong *)date
		   success:(void ( ^ ) (NSArray *dates))success;

-(void)reviewsForDate:(NSString *)date
			  success:(void ( ^ ) (NSArray *))success
			  failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

-(void)topRatedShowsWithSuccess:(void ( ^ ) (NSArray *))success
						failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

- (void)news:(void ( ^ ) (NSArray *))success
	 failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

- (void)blog:(void ( ^ ) (NSArray *))success
	 failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

- (void)showsForCurrentUser:(void ( ^ ) (NSArray *))success
					failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

- (void)authorizeUsername:(NSString *)username
			 withPassword:(NSString *)password
				  success:(void ( ^ ) (BOOL success, NSString *authkey))success
				  failure:(void ( ^ ) ( AFHTTPRequestOperation *, NSError *))failure;

@end
