//
//  ViewController.m
//  PhotoFriendsFacebook
//
//  Created by Serg on 2/10/16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ViewController.h"
#import "ListPhoto.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Friends.h"

@interface ViewController () <FBSDKLoginButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([FBSDKAccessToken currentAccessToken] != nil) {
        
        [self GETFriends];
        
           } else {
        
        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        
        loginButton.readPermissions = @[@"user_photos",
                                        @"user_about_me",
                                        @"public_profile",
                                        @"email",
                                        @"user_friends"];
        loginButton.delegate = self;
        
        [self.view addSubview:loginButton];
               
        loginButton.center = self.view.center;
    }
}

- (void) GETFriends {
    
    NSMutableString *facebookRequest = [NSMutableString new];
    
    [facebookRequest appendString:[NSString stringWithFormat:@"/%@/taggable_friends",[FBSDKAccessToken currentAccessToken].userID]];
    
    [facebookRequest appendString:@"?limit=100"];
    
    FBSDKGraphRequest *requestFriends = [[FBSDKGraphRequest alloc]
                                         initWithGraphPath:facebookRequest
                                         parameters:@{@"fields":@"picture, email, name"}
                                         HTTPMethod:@"GET"];
    [requestFriends startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                 id result,
                                                 NSError *error) {
        NSLog(@"result2 = %@",result);
        
        [self resultInServerParsing:result];
    }];
}

- (void) resultInServerParsing: (NSDictionary*) result {
    
    NSArray* arrayJSON = [result objectForKey:@"data"];
    
    NSMutableArray * arrayFriends = [NSMutableArray array];
    
    for (NSDictionary* dictionary in arrayJSON )  {
        
        Friends* friend = [[Friends alloc] initWithServerResponse:dictionary];
        
        if (friend) {
            [arrayFriends addObject:friend];
        }
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ListPhoto * vc = (ListPhoto *)[sb instantiateViewControllerWithIdentifier:@"ListPhoto-identifier"];
    vc.arrayFrends = arrayFriends;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    
    if (error != nil) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
        [alert show];
        
    } else if ([result isCancelled]) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ERROR LOGIN" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    } else {
        
        [self GETFriends];

    }
    
    NSLog(@"result = %@",result);
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}
@end
