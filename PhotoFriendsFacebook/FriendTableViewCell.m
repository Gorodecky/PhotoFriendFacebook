//
//  FriendTableViewCell.m
//  PhotoFriendsFacebook
//
//  Created by Serg on 2/11/16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "Friends.h"
#import "UIImageView+AFNetworking.h"



@implementation FriendTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updateWithFriendInformation :(Friends*) friendsInformation {
    
    self.friendNameLable.text = friendsInformation.friendName;
    
    if (friendsInformation.photoFriendsURL) {
        
        
        NSURLRequest* requect = [NSURLRequest requestWithURL: friendsInformation.photoFriendsURL];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void){
            
            [self.friendImageView setImageWithURLRequest: requect
                              placeholderImage:nil
                                       success:^(NSURLRequest* request,
                                                 NSHTTPURLResponse* response,
                                                 UIImage*theImage) {
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^(void) {
                                               
                                               self.friendImageView.image = theImage;
                                              
                                           });
                                           
                                       } failure:^(NSURLRequest* request,
                                                   NSHTTPURLResponse* response,
                                                   NSError * error) {
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^(void) {
                                               
                                               NSLog(@"Error photo upload");
                                           });
                                       }];
        });

    }
        
}

@end
