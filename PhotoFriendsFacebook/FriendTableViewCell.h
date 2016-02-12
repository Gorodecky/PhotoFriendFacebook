//
//  FriendTableViewCell.h
//  PhotoFriendsFacebook
//
//  Created by Serg on 2/11/16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friends.h"

@interface FriendTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *friendNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *friendImageView;

- (void)updateWithFriendInformation :(Friends*) friendsInformation;

@end
