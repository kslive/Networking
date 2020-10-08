//
//  DataProvider.swift
//  Networking
//
//  Created by Eugene Kiselev on 08.10.2020.
//

import UIKit

class DataProvider: NSObject {
    private var downloadTask: URLSessionDownloadTask!
    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    private lazy var backgroundSession: URLSession = {
        
        let config = URLSessionConfiguration.background(withIdentifier: "kiseleff.DownloadImage")
        
        config.sessionSendsLaunchEvents = true
        
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload() {
        
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin") {
            
            downloadTask = backgroundSession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            downloadTask.countOfBytesClientExpectsToSend = 512
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
            downloadTask.resume()
        }
    }
    
    func stopDownload() {
        
        downloadTask.cancel()
    }
}

extension DataProvider: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        DispatchQueue.main.async {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let completionHandler = appDelegate.backgroundSessionCompletionHandler
            else { return }
            
            appDelegate.backgroundSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

extension DataProvider: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("did finish: \(location.absoluteString)")
        
        DispatchQueue.main.async { [weak self] in
            
            self?.fileLocation?(location)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        
        let progress = Double(totalBytesWritten/totalBytesExpectedToWrite)
        
        print("download progress: \(progress)")
        
        DispatchQueue.main.async { [weak self] in
            
            self?.onProgress?(progress)
        }
    }
}
