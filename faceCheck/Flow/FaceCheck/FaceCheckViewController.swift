//
//  FaceCheckViewController.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import AVFoundation
import UIKit
import Vision

class FaceCheckViewController: UIViewController {
    
    private var buttonView: UIView!
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private let videoDataQueue = DispatchQueue(label: "videoDataQueue",
                                               qos: .userInitiated)
    var sequenceHandler = VNSequenceRequestHandler()

    override func loadView() {
        super.loadView()
        
        configureCaptureSession()
        configurePreviewLayer()
        addButtonView()
        
        session.startRunning()
    }
    
    // MARK: - Configuring video processing
    private func configureCaptureSession() {
        
        // Configure device
        guard
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                 for: .video,
                                                 position: .front) else { fatalError("Front video camera unavailable") }
        
        // Connect camera with session
        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            session.addInput(cameraInput)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoDataQueue)
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        // Connect video output with session
        session.addOutput(videoOutput)
        
        let videoConnection = videoOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
    }
    
    private func configurePreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
    }
    
    private func addButtonView() {
        buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.layer.cornerRadius = 30
        buttonView.layer.borderWidth = 4
        buttonView.layer.borderColor = UIColor.darkGray.cgColor
        buttonView.backgroundColor = .lightGray
        
        view.addSubview(buttonView)
        let margins = view.layoutMarginsGuide
        buttonView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: margins.bottomAnchor,constant: -10).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTap))
        buttonView.addGestureRecognizer(tap)
    }
    
    @objc func buttonTap() {
        
    }
}

extension FaceCheckViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
        
        do {
            try sequenceHandler.perform([detectFaceRequest],
                                        on: imageBuffer,
                                        orientation: .leftMirrored)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func detectedFace(request: VNRequest, error: Error?) {
        guard
            let results = request.results as? [VNFaceObservation],
            let result = results.first
            else {
                return
        }
        
        guard let landmarks = result.landmarks else { return }
        print(landmarks.outerLips?.normalizedPoints.count)
    }
}
