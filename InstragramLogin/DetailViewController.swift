//
//  DetailViewController.swift
//  InstragramLogin
//
//  Created by Administrator on 7/6/18.
//  Copyright © 2018 softprodigy. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController{
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    @IBOutlet weak var username: UILabel!
    var data : ILListModel? = nil
    var fetchResults = [String]()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewOutlet.dragInteractionEnabled = true
        collectionViewOutlet.dropDelegate = self as! UICollectionViewDropDelegate
        collectionViewOutlet.dragDelegate = self
        collectionViewOutlet.reorderingCadence = .fast
        activityIndicator.startAnimating(activityData)

        
        if let dictData = data?.data {
            
            for dict in dictData {
                if let url = dict.images?.thumbnail?.url {
                    fetchResults.append(url)
                } else {
                    fetchResults.append("")
                }
                if let url = dict.user?.username {
                    username.text = url
                }

            }
            print(fetchResults)
        }
  
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
                    
                    self.fetchResults.remove(at: sourceIndexPath.row)
                    self.fetchResults.insert(item.dragItem.localObject as! String, at: dIndexPath.row)

                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [dIndexPath])
                })
                coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
            }
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
        
        activityIndicator.stopAnimating()
        
        cell.instaImage.sd_setImage(with: URL(string: fetchResults[indexPath.row]), completed: nil)

        return cell
        
        
        
    }
}

//perform drag operation
extension DetailViewController: UICollectionViewDragDelegate {
    
    //Drag only 1 image at a time
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = fetchResults[indexPath.row]
        
        print(item)
          var  image = UIImage()
        if let data = try? Data(contentsOf: URL(string: item)!)
        {
            image = UIImage(data: data)!
        }
        let itemProvider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    //Drag multiple images
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let item = fetchResults[indexPath.row]
        var  image = UIImage()
        if let data = try? Data(contentsOf: URL(string: item)!)
        {
            image = UIImage(data: data)!
        }
        let itemProvider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
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
    
    //performed before dragging the image
    //while dragging an image, CollectionView calls this method repeatedly to determine how you would handle the drop if it occurs at the specified location
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
            // Get last index path of table view.
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
            //self.copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            
        default:
            return
        }
    }
}
