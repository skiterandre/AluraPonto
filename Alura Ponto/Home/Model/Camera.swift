//
//  Camera.swift
//  Alura Ponto
//
//  Created by Andre de Oliveira Couto on 09/03/22.
//

import Foundation
import UIKit

protocol CameraDelegate: AnyObject{
    func didSelectedPhoto(_ image: UIImage)
}

class Camera: NSObject{
    
    private var cameraDelegate: CameraDelegate?
    
    func abrirCamera(_ controller:UIViewController,_ imagePicker:UIImagePickerController,_ cameraDelegate:CameraDelegate){
        self.cameraDelegate = cameraDelegate
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = UIImagePickerController.isCameraDeviceAvailable(.front) ? .front : .rear
        
        controller.present(imagePicker, animated: true, completion: nil)
    }
}
extension Camera:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let foto = info[.editedImage] as? UIImage else { return }
        cameraDelegate?.didSelectedPhoto(foto)
        
    }
}
