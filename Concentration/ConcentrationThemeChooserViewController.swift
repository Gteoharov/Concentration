//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Georgi Teoharov on 9.05.18.
//  Copyright © 2018 Georgi Teoharov. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    
    let themes = [
        "Sports" : "🏀🎾🎳🥋🏓🏅🚵‍♂️🏋️‍♂️⚽️🥊🏎🏈",
        "Animals" : "🐈🐍🐓🐏🐺🐅🐏🐘🐊🐄🦏🦋",
        "Faces" : "😎😃😇🤣😍🤩🤬🤯🤪🤓🧐🤨"
    ]
    
    // changeTheme method:
    // 1. How to find theme in splitView for iPad versions and iPhones + models
    // 2. How to hold something in the heap that gets trown off a navigation stack
    // 3. How to push things on navigation controller without segue
    // 4. How to segue from code
    
    
    @IBAction func changeTheme(_ sender: Any) {
        //1...
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        //2...
        } else if let cvc = lastSegueToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            //3...
            navigationController?.pushViewController(cvc, animated: true)
            
        } else {
            //4...
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    
    private var lastSegueToConcentrationViewController: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSegueToConcentrationViewController = cvc
                }
            }
        }
    }
}
    


