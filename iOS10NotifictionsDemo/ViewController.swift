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
        
        notificationTypes.append(.PlainNotification)
        notificationTypes.append(.NotificationWithImage)
        notificationTypes.append(.NotificationWithGif)
        notificationTypes.append(.NotificationWithAudio)
        notificationTypes.append(.NotificationWithVideo)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func sendUILocalNotificationWithImage() {
        do{
            let imgURL = Bundle.main().urlForResource("notification", withExtension: "jpg")
            
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "jpg_identifier", url:imgURL! , options: nil)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    func sendUILocalNotificationWithAudio() {
        do{
            let imgURL = Bundle.main().urlForResource("notification", withExtension: "mp3")
            let notificationOptions = [UNNotificationAttachmentOptionsTypeHintKey:kUTTypeMP3]
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "audio_identifier", url:imgURL! , options: notificationOptions)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    func sendUILocalNotificationWithVideo() {
        do{
            let imgURL = Bundle.main().urlForResource("notification", withExtension: "mp4")
            let notificationOptions = [UNNotificationAttachmentOptionsTypeHintKey:kUTTypeMPEG4]
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "video_identifier", url:imgURL! , options: notificationOptions)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    func sendUILocalNotificationWithGif() {
        do{
            let imgURL = Bundle.main().urlForResource("notification", withExtension: "gif")
            let notificationOptions = [UNNotificationAttachmentOptionsTypeHintKey:kUTTypeGIF]
            let notificationImageAttachment =  try UNNotificationAttachment(identifier: "gif_identifier", url:imgURL! , options: notificationOptions)
            sendUILocalNotificationWithAttachment(notificationAttachment: notificationImageAttachment)
        }
        catch {
            
        }
    }
    
    func sendUILocalNotificationWithAttachment(notificationAttachment:UNNotificationAttachment?){
        let content = UNMutableNotificationContent()
        content.title = "The Code Ninja says"
        content.body = "The new notifications api in iOS 10 is just awesome"
        content.subtitle = "Also you can add a subtitle with it"
        
        if notificationAttachment != nil {
            content.attachments = [notificationAttachment!]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = "TheCodeNinja_Identifier"
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content,
                                            trigger: trigger)
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

