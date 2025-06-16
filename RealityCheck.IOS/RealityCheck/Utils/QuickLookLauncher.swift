//
//  QuickLookLauncher.swift
//  RealityCheck
//
//  Created by Daniel Hendriksen on 15/06/2025.
//

import Foundation
import SwiftUI
import QuickLook
import UIKit

struct QuickLookLauncher {
    private static var retainedPreviewItem: PreviewItem?

    static func presentUSDZ(from fileURL: URL) {
        let previewController = QLPreviewController()
        let item = PreviewItem(url: fileURL)
        retainedPreviewItem = item
        previewController.dataSource = item

        if let rootVC = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first?.rootViewController {
            rootVC.present(previewController, animated: true)
        }
    }

    private class PreviewItem: NSObject, QLPreviewControllerDataSource {
        let itemURL: URL

        init(url: URL) {
            self.itemURL = url
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return itemURL as QLPreviewItem
        }
    }
}
