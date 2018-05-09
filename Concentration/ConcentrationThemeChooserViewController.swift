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
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
}
    


