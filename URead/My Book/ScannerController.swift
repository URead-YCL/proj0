//
//  ScannerController.swift
//  URead
//
//  Created by Cindy on 12/5/20.
//
//Source: https://github.com/aoshiro10/ISBN-barcode-scanner
//Author: @aoshiro10

import UIKit
import AVFoundation

struct ScannedISBN {
    static var isbn = ""
}

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    

    @IBOutlet weak var textLabel: UITextField!
    var captureSession:AVCaptureSession?
    var inputLayer:AVCaptureVideoPreviewLayer?
    var barCodeFrameView:UIView?
        
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.qr]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //try to find back camera
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
//        guard let captureDevice = deviceDiscoverySession.devices.first else {
//            print("Camera device was not found")
//            return
//        }
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        setUpVideoCapture(captureDevice: captureDevice)
            
        captureSession!.startRunning()
        
        view.bringSubviewToFront(textLabel)
        
        //setting frame view on barcode
        barCodeFrameView = UIView()
        if let barcodeFrameView = barCodeFrameView {
            barcodeFrameView.layer.borderColor = UIColor.blue.cgColor
            barcodeFrameView.layer.borderWidth = 1
            view.addSubview(barcodeFrameView)
            view.bringSubviewToFront(barcodeFrameView)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setUpVideoCapture(captureDevice: AVCaptureDevice) {
            
            do {
                let cameraInput = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                captureSession?.addInput(cameraInput)
                
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession!.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                //setting the type of metadata we are trying to read
                //ISBN barcodes are of type ean13
                captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
                
                inputLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                inputLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                inputLayer?.frame = view.layer.bounds
                view.layer.addSublayer(inputLayer!)
                
            } catch {
                print(error)
            }
            
        }
        
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
            if metadataObjects.count == 0 {
                barCodeFrameView?.frame = CGRect.zero
                textLabel.text = "No barcode is found"
                
            } else {
                
                //found some code
                let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
                
                if metadataObj.type == AVMetadataObject.ObjectType.ean13 {
                    
                    //found ISBN barcode
                    let barCodeObject = inputLayer?.transformedMetadataObject(for: metadataObj)
                    barCodeFrameView?.frame = barCodeObject!.bounds
                    
                    if metadataObj.stringValue != nil {
                        textLabel.text = metadataObj.stringValue
                        print(metadataObj.stringValue!)
       
                        ScannedISBN.isbn = metadataObj.stringValue!
                        performSegue(withIdentifier: "readToAdd", sender: nil)
                        self.captureSession?.stopRunning()
//                        _ = navigationController?.popViewController(animated: true)
////
                       // https://www.googleapis.com/books/v1/volumes?q=isbn:9787562841630

                    }
                }
            }
        }
}
