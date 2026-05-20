//
//  UIImage+Extension.swift
//  ComponentRecognitionTest.1
//
//  Created by Reece Clem on 3/20/25.
//

import UIKit
import CoreGraphics

extension UIImage {
    func normalized() -> UIImage {
        guard let cgImage = self.cgImage else {
            return self
        }

        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = 8
        let bytesPerRow = width * 4 // Assuming 4 bytes per pixel (RGBA)
        let totalBytes = height * bytesPerRow

        var pixelData = [UInt8](repeating: 0, count: totalBytes)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: &pixelData,
                                     width: width,
                                     height: height,
                                     bitsPerComponent: bitsPerComponent,
                                     bytesPerRow: bytesPerRow,
                                     space: colorSpace,
                                     bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) else {
            return self
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

        // Normalize pixel data in-place
        for i in 0..<totalBytes {
            pixelData[i] = UInt8(Float(pixelData[i]) / 255.0) // Scale to 0-1
        }

        // Create a new CGImage from the normalized pixel data
        let normalizedColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) // Create CGBitmapInfo
        guard let normalizedCGImage = CGImage(width: width,
                                               height: height,
                                               bitsPerComponent: bitsPerComponent,
                                               bitsPerPixel: 32,
                                               bytesPerRow: bytesPerRow,
                                               space: normalizedColorSpace,
                                               bitmapInfo: bitmapInfo, // Use the CGBitmapInfo struct
                                               provider: CGDataProvider(data: Data(pixelData) as CFData)!,
                                               decode: nil,
                                               shouldInterpolate: false,
                                               intent: .defaultIntent) else {
            return self
        }

        return UIImage(cgImage: normalizedCGImage)
    }

    // Function to resize image to the model's preferred dimensions
    func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Determine the scale factor that maintains aspect ratio
        let scaleFactor = min(widthRatio, heightRatio)

        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage!
    }

    // Function to convert UIImage to CVPixelBuffer
    func imageToCVPixelBuffer(image: UIImage) -> CVPixelBuffer? {
        let width = Int(image.size.width)
        let height = Int(image.size.height)

        let options: [CFString: Any] = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ]

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                            width,
                                            height,
                                            kCVPixelFormatType_32BGRA,
                                            options as CFDictionary,
                                            &pixelBuffer)

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            print("Failed to create pixel buffer.")
            return nil
        }

        // Lock the pixel buffer base address
        CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(buffer)

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: pixelData,
                                     width: width,
                                     height: height,
                                     bitsPerComponent: 8,
                                     bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                     space: rgbColorSpace,
                                     bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
            CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
            return nil
        }

        context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))

        return buffer
    }
}
