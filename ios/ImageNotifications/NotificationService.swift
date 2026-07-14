//
//  NotificationService.swift
//  ImageNotifications
//
//  Created by mashiur on 7/15/26.
//sakil khan 
//sakil hossion

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = bestAttemptContent else {
            return
        }
        
        // Retrieve the payload
        guard let userInfo = request.content.userInfo as? [String: Any] else {
            contentHandler(bestAttemptContent)
            return
        }
        
        // Find the image URL from FCM standard or custom fields
        var imageUrlString: String? = nil
        
        if let fcmOptions = userInfo["fcm_options"] as? [String: Any], let image = fcmOptions["image"] as? String {
            imageUrlString = image
        } else if let image = userInfo["image"] as? String {
            imageUrlString = image
        } else if let image = userInfo["thumbnail_url"] as? String {
            imageUrlString = image
        }

        if let imageUrlString = imageUrlString, let url = URL(string: imageUrlString) {
            downloadImage(from: url) { attachment in
                if let attachment = attachment {
                    bestAttemptContent.attachments = [attachment]
                }
                contentHandler(bestAttemptContent)
            }
        } else {
            contentHandler(bestAttemptContent)
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (downloadedUrl, response, error) in
            guard let downloadedUrl = downloadedUrl, error == nil else {
                completion(nil)
                return
            }
            
            // Create a temporary file to hold the downloaded image
            let pathExtension = url.pathExtension.isEmpty ? "jpg" : url.pathExtension
            let uniqueURL = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent(UUID().uuidString)
                .appendingPathExtension(pathExtension)
            
            do {
                try FileManager.default.moveItem(at: downloadedUrl, to: uniqueURL)
                let attachment = try UNNotificationAttachment(identifier: "image", url: uniqueURL, options: nil)
                completion(attachment)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
