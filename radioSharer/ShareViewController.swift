//
//  ShareViewController.swift
//  radioSharer
//
//  Created by Alvar Arias on 2022-01-28.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        // Get the data post
        if let content = extensionContext!.inputItems.first as? NSExtensionItem {
            
            // Define multiple contenstypes to enable sharing of both photos and videos
            //Here we are checking the content Types. kUTTypeMovie and kUTTypeImage are the standard types for video and image respectively
            let contentTypes = [kUTTypeMovie as? String,kUTTypeImage as? String]
            if let contents = content.attachments as? [NSItemProvider] {
                for attachment in contents {
                                    for contentType in contentTypes {
                                        if attachment.hasItemConformingToTypeIdentifier(contentType!) {
                                            attachment.loadItem(forTypeIdentifier: contentType!, options: nil) { (data, error) in
                                                if error  != nil {
                                                    print(error)
                                                    return
                                                }
                                                guard let url = data as? NSURL else {
                                                    return
                                                }
                                                guard let url1 = url as? URL else {
                                                    return
                                                }
                                                guard let mediaData = NSData(contentsOf: url1) else {
                                                    return
                                                }
                                                //Now get the path where you will write the data
                                                guard let def = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.path_of_media") else {
                                                    return
                                                }
                                                
                                                var url2 = URL(string: "")
                                                
                                                switch contentType {
                                                case kUTTypeMovie as? String :
                                                    url2 = URL(string: "\(def)myNewMedia.mp4")!
                                                    break
                                                    
                                                case kUTTypeImage as? String :
                                                    url2 = URL(string: "\(def)myNewMedia")!
                                                    break
                                                    
                                                case .none:
                                                    break
                                                case .some(_):
                                                    break
                                                }
                                                
                                                print("value from the switch case = \(url2)")
                                                
                                                let writeToURLAbsPath = "\(def)myNewMedia.mp4".split(separator: ":")[1].replacingOccurrences(of: "///", with: "/")
                                                
                                                //write the data to disc
                                                if url1 != nil {
                                                    do {
                                                        print("Now mediaData is being written to \(url2)")
                                                        try mediaData.write(to: url2!, options: .atomic)
                                                    } catch {
                                                        print("Some error happened while writing data to disc ...\(error).")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                }
        
        
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
