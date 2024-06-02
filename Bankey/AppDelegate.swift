//
//  AppDelegate.swift
//  Bankey
//
//  Created by Jason Hung on 2024/5/11.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        let vc = mainViewController
        vc.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc
        
        return true
    }
}

// LoginViewController
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if localState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
        
    }
}

//onboardingContainerViewController
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        localState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

//DummyViewContoller
extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

