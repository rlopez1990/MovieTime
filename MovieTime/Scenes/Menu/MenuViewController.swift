//
//  MenuViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

final class MenuViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Tab one
        let tabOne = HomeViewController()
        let tabOneBarItem = UITabBarItem(title: "Popular",
                                         image: UIImage(systemName: "film"),
                                         selectedImage: UIImage(systemName: "film.fill"))
        tabOne.tabBarItem = tabOneBarItem

        // Create Tab two
        let tabTwo = HomeViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Top Rated",
                                          image: UIImage(systemName: "tv"),
                                          selectedImage: UIImage(systemName: "tv.fill"))
        tabTwo.tabBarItem = tabTwoBarItem2

        // Create Tab two
        let tabThree = HomeViewController()
        let tabThreeItem = UITabBarItem(title: "Upcoming",
                                    image: UIImage(systemName: "play.tv"),
                                    selectedImage: UIImage(systemName: "play.tv.fill"))
        tabThree.tabBarItem = tabThreeItem
        
        self.viewControllers = [tabOne, tabTwo, tabThree]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
