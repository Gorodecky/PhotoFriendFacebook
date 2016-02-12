//
//  Friends.h
//  PhotoFriendsFacebook
//
//  Created by Serg on 2/11/16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friends : NSObject

@property (strong, nonatomic) NSString* friendID;
@property (strong, nonatomic) NSString* friendName;
@property (strong, nonatomic) NSURL* photoFriendsURL;

- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
