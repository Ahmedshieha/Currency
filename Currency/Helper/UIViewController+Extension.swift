



import Foundation
import UIKit
import JGProgressHUD

extension UIViewController {
    func showIndicator (title : String) {
        let hud = JGProgressHUD()
        hud.show(in: self.view, animated: true)
        hud.textLabel.text = title
        
    }
    
    func hideIndicator () {
        JGProgressHUD().dismiss(animated: true)
//        self.view.isUserInteractionEnabled = true
    }
}
