//
//  ViewController.swift
//  Paytm
//
//  Created by Apple on 01/02/19.
//  Copyright © 2019 Mahesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PGTransactionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //this function triggers when transaction gets finished
    func didFinishedResponse(_ controller: ViewController, response responseString: String) {
        let msg : String = responseString
        var titlemsg : String = ""
        if let data = responseString.data(using: String.Encoding.utf8) {
            do {
                if let jsonresponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] , jsonresponse.count > 0{
                    titlemsg = jsonresponse["STATUS"] as? String ?? ""
                }
            } catch {
                print("Something went wrong")
            }
        }
        let actionSheetController: UIAlertController = UIAlertController(title: titlemsg , message: msg, preferredStyle: .alert)
        let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel) {
            action -> Void in
            controller.navigationController?.popViewController(animated: true)
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    //this function triggers when transaction gets cancelled
    func didCancelTrasaction(_ controller : ViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
    //Called when a required parameter is missing.
    func errorMisssingParameter(_ controller : ViewController, error : NSError?) {
        controller.navigationController?.popViewController(animated: true)
    }

}

