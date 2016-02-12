//
//  Friends.m
//  PhotoFriendsFacebook
//
//  Created by Serg on 2/11/16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "Friends.h"

@implementation Friends

- (id) initWithServerResponse:(NSDictionary*) responseObject {
    
    self = [super init];
    if (self) {
        
        self.friendID         = responseObject[@"id"];
        self.friendName       = responseObject[@"name"];
        self.photoFriendsURL  = [NSURL URLWithString:responseObject[@"picture" ] [@"data"] [@"url"]];
    }
    return self;
}
@end
