//
//  ViewController.swift
//  iOS10NotifictionsDemo
//
//  Created by satheeshwaran on 7/13/16.
//  Copyright © 2016 satheeshwaran. All rights reserved.
//

import UIKit
import UserNotifications
import MobileCoreServices

/**
 Enum to define multiple types of notifications in iOS 8
 
 - PlainNotification:     Plain notificaton with subtitle
 - NotificationWithImage: Notification that contains an image type attachment
 - NotificationWithGif:   Notification that contains a Gif type attachment
 - NotificationWithAudio: Notification that contains an Audio type attachment
 - NotificationWithVideo: Notificaton that contains a Video type attachment
 */
enum iOS10NotificationTypes:String {
    case PlainNotification = "Plain Notification in iOS 10 style"
    case NotificationWithImage = "Notification that contains an image type attachment"
    case NotificationWithGif = "Notification that contains a Gif type attachment"
    case NotificationWithAudio = "Notification that contains an Audio type attachment"
    case NotificationWithVideo = "Notificaton that contains a Video type attachment"
}

class ViewController: UITableViewController {
    
    var notificationTypes:[iOS10NotificationTypes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select To Send"
        
        /**
         Adding all types to the data source array.
         */
        notificationTypes.append(.PlainNotification)
        notificationTypes.append(.NotificationWithImage)
        notificationTypes.append(.NotificationWithGif)
        notificationTypes.append(.NotificationWithAudio)
        notificationTypes.append(.NotificationWithVideo)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    /**
     Method to send a notification with an image
     */
    func sendUILocalNotificationWithImage() {
        do{
            /// Creating a image URL from bundle
            let imgURL = Bundle.main.urlForResource("notification", withExtension: "jpg")
            
            /// Creating an attachment object
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "jpg_identifier", url:imgURL! , options: nil)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    /**
     Method to send a notification with audio
     */
    func sendUILocalNotificationWithAudio() {
        do{
            /// Creating a audio file URL from bundle
            let imgURL = Bundle.main.urlForResource("notification", withExtension: "mp3")
            let notificationOptions = [UNNotificationAttachmentOptionsTypeHintKey:kUTTypeMP3]
            
            /// Creating an attachment object
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "audio_identifier", url:imgURL! , options: notificationOptions)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    /**
     Method to send a notification with Video
     */
    func sendUILocalNotificationWithVideo() {
        do{
            /// Creating a video file URL from bundle
            let videoURL = Bundle.main.urlForResource("notification", withExtension: "mp4")
            let notificationOptions = [UNNotificationAttachmentOptionsTypeHintKey:kUTTypeMPEG4]
            
            /// Creating an attachment object
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "video_identifier", url:videoURL! , options: notificationOptions)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    /**
     Method to send a notification with GIF
     */
    func sendUILocalNotificationWithGif() {
        do{
            /// Creating a audio file URL from bundle
            let gifURL = Bundle.main.urlForResource("notification", withExtension: "gif")
            let notificationOptions = [UNNotificationAttachmentOptionsTypeHintKey:kUTTypeGIF]
            
            /// Creating an attachment object
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "gif_identifier", url:gifURL! , options: notificationOptions)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    /**
     Method to send notification with an attachment object
     
     - parameter notificationAttachment: a notification attachment object
     */
    func sendUILocalNotificationWithAttachment(notificationAttachment:UNNotificationAttachment?){
        
        /// Creating a UNMutableNotificationContent object that will specify the notification content details
        let content = UNMutableNotificationContent()
        /**
         *  Setting the title
         */
        content.title = "The Code Ninja says"
        
        /**
         *  Setting the body
         */
        content.body = "The new notifications api in iOS 10 is just awesome"
        
        /**
         *  Setting the subtite, this is new for iOS 10 alone.
         */
        content.subtitle = "Also you can add a subtitle with it"
        
        /**
         *  Setting the attachment object for the notification
         */
        if notificationAttachment != nil {
            content.attachments = [notificationAttachment!]
        }
        
        /// Setting the trigger time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        /// Setting the identifier to identify different types of notifications
        let requestIdentifier = "TheCodeNinja_Identifier"
        /// Creating a UNNotificationRequest object with the identifier, content and the trigger object
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content,
                                            trigger: trigger)
        /**
         *  Adding the request to UNUserNotificationCenter.current()'s queue so that it presents the notification when the trigger happens.
         */
        UNUserNotificationCenter.current().add(request) { (error) in
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return notificationTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notificationTypeCell = tableView.dequeueReusableCell(withIdentifier: "notificationTypeCell", for: indexPath)
        
        notificationTypeCell.textLabel?.text = notificationTypes[indexPath.row].rawValue
        notificationTypeCell.textLabel?.numberOfLines = 2
        
        return notificationTypeCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch notificationTypes[indexPath.row] {
        case .PlainNotification:
            sendUILocalNotificationWithAttachment(notificationAttachment: nil)
        case .NotificationWithImage:
            sendUILocalNotificationWithImage()
        case .NotificationWithGif:
            sendUILocalNotificationWithGif()
        case .NotificationWithAudio:
            sendUILocalNotificationWithAudio()
        case .NotificationWithVideo:
            sendUILocalNotificationWithVideo()
            //do nothing...
        }
    }
}

