//
//  ViewController.swift
//  Easy_Currency
//
//  Created by Muharrem Köroğlu on 16.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var amountlABEL: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.keyboardType = .decimalPad
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        let url = URL(string: "https://api.apilayer.com/fixer/latest?apikey=lGW7idesiBABdZUTWwYi93TknRvSXyne")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let button = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
                alert.addAction(button)
                self.present(alert, animated: true)
                
            }else{
                
                if data != nil {
                    do{
                        let response = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                        DispatchQueue.main.async {
                            if let rates = response["rates"] as? [String:Any] {
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY     \(String(format: "%.2f", tl))"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD     \(String(format: "%.2f", usd))"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF        \(String(format: "%.2f", chf))"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP     \(String(format: "%.2f", gbp))"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY     \(String(format: "%.2f", jpy))"
                                }
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD        \(String(format: "%.2f", cad))"
                                }
                            }
                        }
                    }catch{
                        print("Error")
                    }
                    
                }
            }
            
            
        }
        task.resume()

    }
    
    @objc func hideKeyboard () {
        view.endEditing(true)
    }
    
    func convertCurrency (convertTo : String) {
        let url = URL(string: "https://api.apilayer.com/fixer/convert?to=\(convertTo)&from=EUR&amount=\(self.textField.text ?? "1")&apikey=lGW7idesiBABdZUTWwYi93TknRvSXyne")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                alert.addAction(button)
                self.present(alert, animated: true)
            }else{
                do{
                    let response = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                    DispatchQueue.main.async {
                        if let result = response["result"] as? Double {
                            self.amountlABEL.text = "\(String(format: "%.2f",result))"
                        }
                    }
                    
                }catch{
                    print("Error")
                }
            }
        }
        task.resume()
    }
    
    
    @IBAction func tryButton(_ sender: Any) {
        convertCurrency(convertTo: "TRY")
    }
    
    @IBAction func usdButton(_ sender: Any) {
        convertCurrency(convertTo: "USD")
    }
    
    @IBAction func chfButton(_ sender: Any) {
        convertCurrency(convertTo: "CHF")
    }
    
    @IBAction func gbpButton(_ sender: Any) {
        convertCurrency(convertTo: "GBP")
    }
    
    @IBAction func jpyButton(_ sender: Any) {
        convertCurrency(convertTo: "JPY")
    }
    
    @IBAction func cadButton(_ sender: Any) {
        convertCurrency(convertTo: "CAD")
    }
    
    
}
