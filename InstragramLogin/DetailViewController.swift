//
//  DetailViewController.swift
//  InstragramLogin
//
//  Created by Administrator on 7/6/18.
//  Copyright © 2018 softprodigy. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    var piker = UIImagePickerController()
    
    @IBOutlet weak var username: UILabel!
    var data : ILListModel? = nil
    var fetchResults = [[String : String]]()
    var selectedIndex : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOutlet.dragInteractionEnabled = true
        collectionViewOutlet.dropDelegate = self as UICollectionViewDropDelegate
        collectionViewOutlet.dragDelegate = self
        collectionViewOutlet.reorderingCadence = .fast
        //activityIndicator.startAnimating(activityData)
        
        piker.delegate = self
        activityIndicator.stopAnimating()
        
        
        if let dictData = data?.data {
            
            for dict in dictData {
                if let url = dict.images?.thumbnail?.url {
                    fetchResults.append(["type":"insta","url":url])
                } else {
                    fetchResults.append(["type":"insta","url":""])
                }
                if let url = dict.user?.username {
                    username.text = url
                }
            }
        }
        debugPrint(fetchResults)
        
        if let savedItems : [[String : String]] = UserDefaults.standard.value(forKey: "galleryItems") as? [[String : String]]
            
        {
            print(savedItems)
            
            for index in 0...savedItems.count-1
            {
                let type = savedItems[index]["type"]!
                print(type)
                if type != "insta"
                {
                    fetchResults.insert(savedItems[index], at: index)
                }
            }
        }
        
        debugPrint(fetchResults)
    }
    
    @IBAction func AddImages(_ sender: Any) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        self.navigationController?.present(alert, animated: true, completion:nil)
        //  self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            piker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(piker, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    
    func openGallary()
    {
        piker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        piker.allowsEditing = true
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(piker, animated: true, completion: nil)
        }
    }
    var Timestamp: String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour)\(minutes)\(seconds)")
        return "\(year)\(month)\(day)\(hour)\(minutes)\(seconds)"
    }
    
    func saveImageDocumentDirectory(image : UIImage ,name : String ,index : String){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(Timestamp).jpg"
        print(fileName)
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = UIImageJPEGRepresentation(image, 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                fetchResults.insert(["type":"gallery","url":fileName,"imageIndex": index], at: 0)
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    func getImage(filename: String) -> UIImage? {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(filename).jpg")
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage.init(named: "ic_image")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.saveImageDocumentDirectory(image: image!, name: "test", index: "0")
        UserDefaults.standard.setValue(fetchResults, forKey: "galleryItems")
        print(fetchResults.count)
        collectionViewOutlet.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
}

//set images and number of cells in collectionView
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! photosCell
        
        var imageSource = String()
        imageSource = fetchResults[indexPath.row]["url"]!
        if verifyUrl(urlString: imageSource)
        {
            cell.instaImage.sd_setImage(with: URL(string: fetchResults[indexPath.row]["url"]!), completed: nil)
        }
        else
        {
            cell.instaImage.image = getImage(filename: imageSource)!
            
        }
        return cell
    }
    
}

//perform drag operation
extension DetailViewController: UICollectionViewDragDelegate {
    
    //Drag only 1 image at a time
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let imagesrc = fetchResults[indexPath.row]["url"]!
        var  image = UIImage()
        let type = fetchResults[indexPath.row]["type"]!
        
        selectedIndex = indexPath.row
        
        if type == "insta"
        {
            let fileUrl = URL(string: imagesrc)
            let catPictureData = NSData(contentsOf: fileUrl!) // nil
            image = UIImage(data: catPictureData! as Data)!
        }
        else
        {
            image = getImage(filename: imagesrc)!
        }
        
        let itemProvider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = imagesrc
        return [dragItem]
        
    }
    
    //reorder positions of images
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            
            collectionView.performBatchUpdates({
                
                let type = fetchResults[selectedIndex]["type"]!
                self.fetchResults.remove(at: sourceIndexPath.row)
                self.fetchResults.insert(["type":type,"url":item.dragItem.localObject as! String], at: dIndexPath.row)
                UserDefaults.standard.setValue(self.fetchResults, forKey: "galleryItems")
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
    }
    
    //set size of the preview
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    {
        let previewParameters = UIDragPreviewParameters()
        previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 5, y: 5, width: 70, height: 70))
        return previewParameters
    }
}

extension DetailViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        print(session.canLoadObjects(ofClass: UIImage.self))
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if session.localDragSession != nil
        {
            if collectionView.hasActiveDrag
            {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
        }
        else
        {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    //perform drop operation at destination
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
            
        else
        {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
            
        case .copy: break
            
        default:
            return
        }
    }
}
