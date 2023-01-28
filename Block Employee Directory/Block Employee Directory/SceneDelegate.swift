//
//  SceneDelegate.swift
//  Block Employee Directory
//
//  Created by Millie Savalia on 1/23/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = EmployeeDirectoryViewController()
        
        window?.makeKeyAndVisible()
    }

}

