//
//  ViewController.swift
//  ControllerApp
//
//  Created by anges on 09.02.19.
//  Copyright © 2019 anges. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var BackGroundView: UIView!
    @IBOutlet weak var ImgProfileImage: UIImageView!
    @IBOutlet weak var LblChannelName: UILabel!
    @IBOutlet weak var LblSubscribers: UILabel!
    @IBOutlet weak var LblVideoCount: UILabel!
    @IBOutlet weak var LblViewCount: UILabel!
    
    @IBOutlet weak var IndOffline: UIActivityIndicatorView!
    @IBOutlet weak var LblOffline: UILabel!
    
    @IBOutlet weak var BackGroundView2: UIView!
    @IBOutlet weak var ImgProfileImage2: UIImageView!
    @IBOutlet weak var LblChannelName2: UILabel!
    @IBOutlet weak var LblSubscribers2: UILabel!
    @IBOutlet weak var LblVideoCount2: UILabel!
    @IBOutlet weak var LblViewCount2: UILabel!
    
    @IBOutlet weak var BackGroundView3: UIView!
    @IBOutlet weak var ImgProfileImage3: UIImageView!
    @IBOutlet weak var LblChannelName3: UILabel!
    @IBOutlet weak var LblSubscribers3: UILabel!
    @IBOutlet weak var LblVideoCount3: UILabel!
    @IBOutlet weak var LblViewCount3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Link = "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id="
        let key = "" //Insert your YouTube key here!!!
        let lang = "en"
        
        let id1 = "UCE_M8A5yxnLfW0KghEeajjw" //Apple
        let id2 = "UC7c3Kb6jYCRj4JOHHZTxKsQ" //GitHub
        let id3 = "UCFtEEv80fQVKkD4h1PF-Xqw" //Microsoft
        
        //YouTube request
        Request1(link: Link, id: id1, key: key, lang: lang)
        Request2(link: Link, id: id2, key: key, lang: lang)
        Request3(link: Link, id: id3, key: key, lang: lang)
        
        
        let Color1 = UIColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 0.3).cgColor
        let Color2 = UIColor(red: 0.1, green: 0.26, blue: 0.9, alpha: 0.9).cgColor
        SetGradiantBackgroundView(View: BackGroundView, Color1: Color1, Color2: Color2)
        SetGradiantBackgroundView(View: BackGroundView2, Color1: Color1, Color2: Color2)
        SetGradiantBackgroundView(View: BackGroundView3, Color1: Color1, Color2: Color2)
        MainView.addSubview(BackGroundView)
        MainView.addSubview(BackGroundView2)
        MainView.addSubview(BackGroundView3)
        
        //Corner Radius of Channel-Image
        ImgProfileImage.layer.cornerRadius = 28
        ImgProfileImage.layer.masksToBounds = true
        ImgProfileImage2.layer.cornerRadius = 28
        ImgProfileImage2.layer.masksToBounds = true
        ImgProfileImage3.layer.cornerRadius = 28
        ImgProfileImage3.layer.masksToBounds = true
        
        //Refresh YouTube Data every 5 Sec.
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            self.Request1(link: Link, id: id1, key: key, lang: lang)
            self.Request2(link: Link, id: id2, key: key, lang: lang)
            self.Request3(link: Link, id: id3, key: key, lang: lang)
        }
    }
    
    //Gradient BackgroundColor
    func SetGradiantBackgroundView(View: UIView, Color1: CGColor, Color2: CGColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = View.bounds
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 20
        
        gradient.colors = [Color1, Color2]
        View.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func Request1(link: String, id: String, key: String, lang: String)
    {
        guard let url = URL(string: link + id + "&key=" + key + "&hl=" + lang) else { return }
        
        URLSession.shared.dataTask(with: url) {(Outdata, response, error) in
            guard let data = Outdata else {
                
                let err = error!.localizedDescription
                print(err)
                
                //In case Internet is not available
                DispatchQueue.main.async
                {
                    self.IndOffline.startAnimating()
                    self.IndOffline.layer.zPosition = 1
                    self.LblOffline.text = err
                    self.LblOffline.layer.zPosition = 1
                }
                
                return
            }
            
            do {
                //Parse JSON Data
                let YoutubeData = try JSONDecoder().decode(Helper.YouTubeData.self, from: data)
                
                //Show data in UI
                DispatchQueue.main.async
                {
                    //Reset when Online
                    self.IndOffline.stopAnimating()
                    self.LblOffline.isHidden = true
                    self.LblOffline.text = ""
                    
                    let Jurl = YoutubeData.items[0].snippet.thumbnails.medium.url
                    if (Jurl.starts(with: "http"))
                    {
                        let url = URL(string: Jurl)
                        let data = try? Data(contentsOf: url!)
                        self.ImgProfileImage.image = UIImage(data: data!)
                    }
                    self.LblChannelName.text = YoutubeData.items[0].snippet.title
                    self.LblSubscribers.text = YoutubeData.items[0].statistics.subscriberCount
                    self.LblViewCount.text = YoutubeData.items[0].statistics.viewCount
                    self.LblVideoCount.text = YoutubeData.items[0].statistics.videoCount
                }
            }
            catch
            {
                print(error)
            }
            
            guard let err = error else { return }
            print(err)
            
            }.resume()
    }
    
    
    //Second request
    func Request2(link: String, id: String, key: String, lang: String)
    {
        guard let url = URL(string: link + id + "&key=" + key + "&hl=" + lang) else { return }
        
        URLSession.shared.dataTask(with: url) {(Outdata, response, error) in
            guard let data = Outdata else {
                
                let err = error!.localizedDescription
                print(err)
                
                //In case Internet is not available
                DispatchQueue.main.async
                    {
                        self.IndOffline.startAnimating()
                        self.IndOffline.layer.zPosition = 1
                        self.LblOffline.text = err
                        self.LblOffline.layer.zPosition = 1
                }
                
                return
            }
            
            do {
                //Parse JSON Data
                let YoutubeData = try JSONDecoder().decode(Helper.YouTubeData.self, from: data)
                
                //Show data in UI
                DispatchQueue.main.async
                    {
                        //Reset when Online
                        self.IndOffline.stopAnimating()
                        self.LblOffline.isHidden = true
                        self.LblOffline.text = ""
                        
                        let Jurl = YoutubeData.items[0].snippet.thumbnails.medium.url
                        if (Jurl.starts(with: "http"))
                        {
                            let url = URL(string: Jurl)
                            let data = try? Data(contentsOf: url!)
                            self.ImgProfileImage2.image = UIImage(data: data!)
                        }
                        self.LblChannelName2.text = YoutubeData.items[0].snippet.title
                        self.LblSubscribers2.text = YoutubeData.items[0].statistics.subscriberCount
                        self.LblViewCount2.text = YoutubeData.items[0].statistics.viewCount
                        self.LblVideoCount2.text = YoutubeData.items[0].statistics.videoCount
                }
            }
            catch
            {
                print(error)
            }
            
            guard let err = error else { return }
            print(err)
            
            }.resume()
    }
    
    //Third request
    func Request3(link: String, id: String, key: String, lang: String)
    {
        guard let url = URL(string: link + id + "&key=" + key + "&hl=" + lang) else { return }
        
        URLSession.shared.dataTask(with: url) {(Outdata, response, error) in
            guard let data = Outdata else {
                
                let err = error!.localizedDescription
                print(err)
                
                //In case Internet is not available
                DispatchQueue.main.async
                    {
                        self.IndOffline.startAnimating()
                        self.IndOffline.layer.zPosition = 1
                        self.LblOffline.text = err
                        self.LblOffline.layer.zPosition = 1
                }
                
                return
            }
            
            do {
                //Parse JSON Data
                let YoutubeData = try JSONDecoder().decode(Helper.YouTubeData.self, from: data)
                
                //Show data in UI
                DispatchQueue.main.async
                    {
                        //Reset when Online
                        self.IndOffline.stopAnimating()
                        self.LblOffline.isHidden = true
                        self.LblOffline.text = ""
                        
                        let Jurl = YoutubeData.items[0].snippet.thumbnails.medium.url
                        if (Jurl.starts(with: "http"))
                        {
                            let url = URL(string: Jurl)
                            let data = try? Data(contentsOf: url!)
                            self.ImgProfileImage3.image = UIImage(data: data!)
                        }
                        self.LblChannelName3.text = YoutubeData.items[0].snippet.title
                        self.LblSubscribers3.text = YoutubeData.items[0].statistics.subscriberCount
                        self.LblViewCount3.text = YoutubeData.items[0].statistics.viewCount
                        self.LblVideoCount3.text = YoutubeData.items[0].statistics.videoCount
                }
            }
            catch
            {
                print(error)
            }
            
            guard let err = error else { return }
            print(err)
            
            }.resume()
    }
}


