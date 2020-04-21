//
//  Page1TableViewController.swift
//  UniverseMatome
//
//  Created by Tsukuda Hiroshi on 2020/04/07.
//  Copyright © 2020 Tsukuda Hiroshi. All rights reserved.
//

import UIKit
import SegementSlide

class Page4TableViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate{

    var parser = XMLParser()
    
    var currentElementName: String!
    
    var newsItems = [NewsItems]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        let urlString = "https://koyamachuya.com/space/feed/"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
        tableView.reloadData()

    }

    
    @objc var scrollView: UIScrollView{
    
    return tableView
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/6
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .gray

        let newsItem = self.newsItems[indexPath.row]
        
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.pubDate
        cell.detailTextLabel?.textColor = .black
        
        
        return cell
 
    }
    
      func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

            currentElementName = nil
            if elementName == "item"{

                self.newsItems.append(NewsItems())

    //            [a,b,c]

            }else{
                currentElementName = elementName
            }
        }

        func parser(_ parser: XMLParser, foundCharacters string: String) {
            if self.newsItems.count > 0
            {

    //            [1,2,3,4,5]
                let lastItem = self.newsItems[self.newsItems.count - 1]

                switch self.currentElementName{

                case "title":
                        lastItem.title = string


                case "link":
                    lastItem.url = string

                case "pubDate":
                    lastItem.pubDate = string

                default: break
                }
            }

        }

    //    <title>タイトル</title>

        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            self.currentElementName = nil


        }

    
     func parserDidEndDocument(_ parser: XMLParser) {
            self.tableView.reloadData()
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    //        webViewControllerにurlを渡して表示したい
            let webViewController = WebViewController()
            webViewController.modalTransitionStyle = .crossDissolve
            let newsItem = newsItems[indexPath.row]
            UserDefaults.standard.set(newsItem.url, forKey: "url")
            present(webViewController, animated: true, completion: nil)
            
            
        }

}
