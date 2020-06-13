#import <Foundation/Foundation.h>

typedef enum {
    FeedbackType_Selection,
    FeedbackType_Impact_Light,
    FeedbackType_Impact_Medium,
    FeedbackType_Impact_Heavy,
    FeedbackType_Impact_Rigid,
    FeedbackType_Impact_Soft,
    FeedbackType_Notification_Success,
    FeedbackType_Notification_Warning,
    FeedbackType_Notification_Error
}FeedbackType;

@interface Haptics : NSObject

+ (void)generateFeedback:(FeedbackType)type;

@end