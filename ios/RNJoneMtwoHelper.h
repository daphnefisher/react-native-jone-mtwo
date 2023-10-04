#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeDelegate.h>
#import <UserNotifications/UNUserNotificationCenter.h>


@interface RNJoneMtwoHelper : UIResponder<RCTBridgeDelegate, UNUserNotificationCenterDelegate>

+ (instancetype)joneMtwo_shared;
- (BOOL)joneMtwo_tryThisWay:(void (^)(void))changeVcBlock;
- (BOOL)joneMtwo_tryOtherWayQueryScheme:(NSURL *)url;
- (UIInterfaceOrientationMask)joneMtwo_getOrientation;
- (UIViewController *)joneMtwo_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end
