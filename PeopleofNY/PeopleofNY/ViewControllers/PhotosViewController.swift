//
//  PhotosViewController.swift
//  
//
//  Created by Scott Guidoboni on 1/19/18.
//

import UIKit

import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of posts: \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            
            let photo = photos[0]
        
            let originalSize = photo["original_size"] as! [String: Any]
           
            let urlString = originalSize["url"] as! String
  
            let url = URL(string: urlString)!
            
            
            cell.picView.af_setImage(withURL: url)
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            
            // let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            //cell.textLabel?.text = "This is row \(indexPath.row)"
            //self.tableView.reloadData()
            
        }
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView! //no outlet

    var posts: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPicture()
    }
        
    func fetchPicture() {
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Reload the table view HarJas
                self.tableView.reloadData()
                
            }
        }
        task.resume()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get a reference to the PhotoDetailsViewController
        let vc = segue.destination as! PhotoDetailViewController
        //Get the cell that triggered the segue
        let cell = sender as! UITableViewCell
        //Get the indexPath of the selected photo
        let indexPath = tableView.indexPath(for: cell)!
        
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)!
            print(urlString)
        
        
        
    
        //let url = URL(string: urlString)!
        vc.url = url
       // vc.photoView.af_setImage(withURL: url)
            
            
        
    }
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

