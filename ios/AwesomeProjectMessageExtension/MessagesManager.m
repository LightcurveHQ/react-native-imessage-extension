//
//  MessagesManager.m
//  AwesomeProjectMessageExtension
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(MessagesManager, NSObject)

RCT_EXTERN_METHOD(getActiveConversation: (RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(composeMessage:
                  (NSDictionary *)messageData
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getPresentationStyle: (RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(updatePresentationStyle:
                  (NSString *)style
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)
@end
