//
//  ListPhoto.m
//  PhotoFriendsFacebook
//
//  Created by Serg on 2/11/16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ListPhoto.h"
#import "ViewController.h"
#import "Friends.h"
#import "FriendTableViewCell.h"

@interface ListPhoto () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView* friendsTable;

@end

@implementation ListPhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UINib *nib = [UINib nibWithNibName:@"FriendTableViewCell" bundle:nil];
    
    [[self friendsTable] registerNib:nib forCellReuseIdentifier:@"idetifier"];
    
    NSLog(@"arrayFrends = %@",self.arrayFrends);
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger countFriends = self.arrayFrends.count;
    
    return  countFriends;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString* idetifier = @"idetifier";
    
    FriendTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:idetifier];

    Friends* friend = self.arrayFrends [indexPath.row];
    
    [cell updateWithFriendInformation:friend];
    
    return cell;
}

@end
