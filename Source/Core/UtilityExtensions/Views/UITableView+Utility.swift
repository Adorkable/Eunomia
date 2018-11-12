//
//  UITableView+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UITableView {
    public func heightForCell(_ reusableIdentifier : String, configure : (_ cell : UITableViewCell) -> Void) throws -> CGFloat {
        
        var result : CGFloat = 0
        
        if let cell = self.dequeueReusableCell(withIdentifier: reusableIdentifier)
        {
            cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
            
            configure(cell)
            
            cell.setNeedsLayout()
            cell.contentView.setNeedsLayout()
            cell.layoutIfNeeded()
            
            cell.contentViewContraint(.height).forEach({ (constraint) -> () in
                result = constraint.constant
            })
            
//            result = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height

        } else
        {
            throw NSError(description: "Unable to dequeue cell with reusable identifier \(reusableIdentifier)")
        }
        
        return result
        
    }
    
    public func refreshCellHeights() {
        self.beginUpdates()
        self.endUpdates()
    }
}

// MARK: - Static Table
extension UITableView {
    /// TODO: once linker bug is fixed switch these back to Structs
    open class StaticSection
    {
        open class StaticHeader
        {
            open var title : String?
            public init(title : String?) {
                self.title = title
            }
        }
        let header : StaticHeader?
        
        open class StaticRow
        {
            public let cellPrototypeIdentifier : String
            
            public init(cellPrototypeIdentifier : String) {
                self.cellPrototypeIdentifier = cellPrototypeIdentifier
            }
        }
        open var rows = [StaticRow]()
        
        open func row(_ rowIndex : Int) -> StaticRow? {
            
            guard rowIndex < self.rows.count else {
                return nil
            }
            
            return self.rows[rowIndex]
        }
        
        public init(header : StaticHeader?) {
            self.header = header
        }
    }
    
    public func staticSection(_ sections : [StaticSection], sectionIndex : Int) -> UITableView.StaticSection? {
        
        guard sectionIndex < sections.count else {
            return nil
        }
        
        return sections[sectionIndex]
    }
    
    public func staticNumberOfRowsInSection(_ sections : [StaticSection], sectionIndex : Int) -> Int {
        
        guard let section = self.staticSection(sections, sectionIndex: sectionIndex) else {
            return 0
        }

        return section.rows.count
    }
    
    public func staticTitleForHeaderInSection(_ sections : [StaticSection], sectionIndex : Int) -> String? {
        guard let section = self.staticSection(sections, sectionIndex: sectionIndex) else {
            return nil
        }
        
        guard let header = section.header else {
            return nil
        }
        
        return header.title
    }
    
    public func staticCellForRowAtIndexPath(_ sections : [StaticSection], indexPath : IndexPath, fallbackIdentifier : String) -> UITableViewCell {
        
        guard let section = self.staticSection(sections, sectionIndex: indexPath.section) else {
            return self.dequeueReusableCell(withIdentifier: fallbackIdentifier, for: indexPath)
        }

        guard let row = section.row(indexPath.row) else {
            return self.dequeueReusableCell(withIdentifier: fallbackIdentifier, for: indexPath)
        }
        
        return self.dequeueReusableCell(withIdentifier: row.cellPrototypeIdentifier, for: indexPath)
    }
}
#endif
