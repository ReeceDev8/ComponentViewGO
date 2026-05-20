import SwiftUI
import CoreML
import Vision
import UIKit

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    @Published var predictionText: String = ""
    @Published var unsureButton: String? = nil

    private var model: VNCoreMLModel?

    init() {
        loadModel()
    }

    func loadModel() {
        if let modelURL = Bundle.main.url(forResource: "PCComponentRecognitionModel", withExtension: "mlmodelc") {
            print("Model found at: \(modelURL.path)")
            do {
                let coreMLModel = try MLModel(contentsOf: modelURL)
                model = try VNCoreMLModel(for: coreMLModel)
                print("Model loaded successfully.")
            } catch {
                print("Error loading model: \(error)")
            }
        } else {
            print("Model not found at path.")
        }
    }
    
    func predict(image: UIImage) {
        print("Predict function called")
        guard let model = model else {
            print("Model not loaded")
            return
        }

        let resizedImage = image.resize(image: image, targetSize: CGSize(width: 256, height: 256))
        print("Image resized to 256x256.")
        
        // Removed manual normalization step to prevent scaling pixels down twice

        // Passed resizedImage directly instead of normalizedImage to fix pixel values
        guard let buffer = image.imageToCVPixelBuffer(image: resizedImage) else {
            print("Failed to convert image to CVPixelBuffer.")
            return
        }

        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let error = error {
                print("Error during prediction: \(error)")
                return
            }

            print("Prediction request completed. Results: \(String(describing: request.results))")

            guard let results = request.results as? [VNCoreMLFeatureValueObservation], let result = results.first else {
                print("No results from prediction")
                DispatchQueue.main.async {
                    self.predictionText = "Unable to make prediction."
                }
                return
            }

            if let multiArray = result.featureValue.multiArrayValue {

                var bestResult: Double = -1.0
                var bestIndex: Int = -1

                for i in 0..<multiArray.count {
                    let value = multiArray[i].doubleValue

                    if value > bestResult {
                        bestResult = value
                        bestIndex = i
                    }
                }

                let predictionConfidence = (bestResult * 100).rounded(toPlaces: 1)
                let predictionLabel = self.getLabel(forIndex: bestIndex)

                DispatchQueue.main.async {
                    withAnimation(.default) {
                            self.predictionText = "Analyzing"
                        }
                    self.unsureButton = nil
                    var dotCount = 0
                    
                    let dotTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if dotCount < 3 {
                            dotCount += 1
                            self.predictionText = "Analyzing" + String(repeating: ".", count: dotCount)
                        } else {
                            timer.invalidate()
                            
                            DispatchQueue.main.async {
                                withAnimation(.default) {
                                    self.predictionText = predictionLabel
                                    
                                    if predictionConfidence < 30 {
                                        self.unsureButton = "exclamationmark.circle.fill"
                                    } else {
                                        self.unsureButton = nil
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                print("No multi-array found in results.")
            }
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Error performing prediction: \(error)")
            }
        }
    }

    func getLabel(forIndex index: Int) -> String {
        let classLabels = ["cables", "case", "cpu", "gpu", "hdd", "headset", "keyboard", "microphone", "monitor", "motherboard", "mouse", "ram", "speakers", "webcam"]
        return classLabels[index]
    }

    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    
}
