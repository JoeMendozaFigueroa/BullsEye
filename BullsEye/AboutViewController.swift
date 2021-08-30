//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Josue Mendoza on 8/22/21.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    //This is the variable which identifies the webview inside the view controller.
    @IBOutlet var webView: WKWebView!

    //This the method for the view controller.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is the constant which identifies the location of the Bullseye.html document whithin the project folder.
        if let url = Bundle.main.url (
            forResource: "BullsEye", withExtension:
                "html") {
                    let request = URLRequest(url: url)
                    webView.load(request)
                }
            }
}
