//
//  ViewController.swift
//  230927_FaceRecognitionProject
//
//  Created by hasan bilgin on 28.09.2023.
//

import UIKit
//build edilip görmezzse kapatılıp açılır
//kamera yada parmak izide dahil giriş için eklendi
import LocalAuthentication


class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sıgnInClicked(_ sender: Any) {
        
        let authContext = LAContext()
        var error : NSError?
        //deviceOwnerAuthenticationWithBiometrics ya yüzü yada parmak izi ikiside geçerli
        //error pointer  istemiş ondna & koyuldu
        //elimizde cihaz bunu değerlendirebiliyorsa
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            //o yüz tanıma yada parmakizi kontrolüne geçicektir bu kodla
            //Is it You? kullanıcya yansıtılcak soru işte manule yazdık
            //reply: <#T##(Bool, Error?) -> Void#> entere basılınca bool(success) yani doğru olduğunda Error? ise hatayı vercek)
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it You?") { success, error in
                if success { // success == true ile aynıdır
                    //successfull auth
                    //bu kod sayesinde main threadde çalıştırmış olduk
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
            //closure demek yani callBackFunction demektir diyebiliriz ondna self kullanımı zorladı
        }
        //bide info.plist e bu eklenecek Privacy - Face ID Usage Description ve valuesuna to Authenticate yazdık
        
        //FaceID similatördede deneyebiliriz aktif etmek için similasyon da en üst çubukta Features->FaceID->Enrolled yaotık
        //FaceID doğru okutmak için similasyon da en üst çubukta Features->FaceID -> Matching Face dedik // yanlış okutmak içinse Non-matching Face seçeriz
        
        
    }
    
}

