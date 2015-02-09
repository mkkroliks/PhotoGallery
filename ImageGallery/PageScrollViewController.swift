//
//  PageScrollViewController.swift
//  ImageGallery
//
//  Created by Maciej Krolikowski on 09/02/15.
//  Copyright (c) 2015 Maciej Krolikowski. All rights reserved.
//

import UIKit

class PageScrollViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageImages:[UIImage] = []
    var pageViews:[UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageImages = [UIImage(named:"photo1.png")!,
            UIImage(named:"photo2.png")!,
            UIImage(named:"photo3.png")!,
            UIImage(named:"photo4.png")!,
            UIImage(named:"photo5.png")!]
        
        let pageCount = pageImages.count

        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount

        for _ in 0..<pageCount {
            pageViews.append(nil)
        }

        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)

        loadVisiblePages()
    }
    
    func loadPage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            return
        }
        
        if let pageView = pageViews[page] {

        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0

            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)

            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            return
        }

        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        
    }
    
    func loadVisiblePages() {

        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1

        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }

        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
        
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        loadVisiblePages()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
