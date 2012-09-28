//
//  JSModelRepository.h
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

//   NSString  [l_object.userInfo.userAvatarImageURL hash]

#define HashString(x)   [NSString stringWithFormat:@"%u",[x hash]]

// singleton class for handling all the model data
//
@interface JSModelRepository : NSObject
{
}

@property (nonatomic, retain) NSMutableArray* objects;

// class method for getting the singleton object
//
+ (JSModelRepository*) sharedModelRepository;


// public methods

// add objects which are fetched from the url
- (void) addObjectsFromArray:(NSArray*)in_arrOfObjects;

// maintain a image cache - object image
//
- (void) addOrUpdateImage:(UIImage*)in_uiImage withKey:(NSString*)in_strKey;

// avatar image
- (void) addOrUpdateAvatarImage:(UIImage*)in_uiImage withKey:(NSString*)in_strKey;


// image getter
- (UIImage*) getUIImageForKey:(NSString*)in_strKey;


@end
