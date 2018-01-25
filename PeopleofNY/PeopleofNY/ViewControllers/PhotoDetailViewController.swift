//
//  PhotoDetailViewController.swift
//  
//
//  Created by Scott Guidoboni on 1/24/18.
//

import UIKit
import AlamofireImage

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if let url = url{
        photoView.af_setImage(withURL: url!)//}
        //photoView.af_setImage(withURL: url)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
