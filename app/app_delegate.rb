class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    mainView = MainViewController.alloc.initWithNibName(nil, bundle:nil)

    window.setRootViewController mainView
    window.makeKeyAndVisible

    true
  end
end
