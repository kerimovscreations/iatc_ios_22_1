//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import UniformTypeIdentifiers

class ViewController: UIViewController {
    
    let bookContentBase64 = "JVBERi0xLjMNCiXi48/TDQoNCjEgMCBvYmoNCjw8DQovVHlwZSAvQ2F0YWxvZw0KL091dGxpbmVzIDIgMCBSDQovUGFnZXMgMyAwIFINCj4+DQplbmRvYmoNCg0KMiAwIG9iag0KPDwNCi9UeXBlIC9PdXRsaW5lcw0KL0NvdW50IDANCj4+DQplbmRvYmoNCg0KMyAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0NvdW50IDINCi9LaWRzIFsgNCAwIFIgNiAwIFIgXSANCj4+DQplbmRvYmoNCg0KNCAwIG9iag0KPDwNCi9UeXBlIC9QYWdlDQovUGFyZW50IDMgMCBSDQovUmVzb3VyY2VzIDw8DQovRm9udCA8PA0KL0YxIDkgMCBSIA0KPj4NCi9Qcm9jU2V0IDggMCBSDQo+Pg0KL01lZGlhQm94IFswIDAgNjEyLjAwMDAgNzkyLjAwMDBdDQovQ29udGVudHMgNSAwIFINCj4+DQplbmRvYmoNCg0KNSAwIG9iag0KPDwgL0xlbmd0aCAxMDc0ID4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTcuMzc1MCA3MjIuMjgwMCBUZA0KKCBBIFNpbXBsZSBQREYgRmlsZSApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIFRoaXMgaXMgYSBzbWFsbCBkZW1vbnN0cmF0aW9uIC5wZGYgZmlsZSAtICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjY0LjcwNDAgVGQNCigganVzdCBmb3IgdXNlIGluIHRoZSBWaXJ0dWFsIE1lY2hhbmljcyB0dXRvcmlhbHMuIE1vcmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NTIuNzUyMCBUZA0KKCB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDYyOC44NDgwIFRkDQooIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjE2Ljg5NjAgVGQNCiggdGV4dC4gQW5kIG1vcmUgdGV4dC4gQm9yaW5nLCB6enp6ei4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjA0Ljk0NDAgVGQNCiggbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDU5Mi45OTIwIFRkDQooIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNTY5LjA4ODAgVGQNCiggQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA1NTcuMTM2MCBUZA0KKCB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBFdmVuIG1vcmUuIENvbnRpbnVlZCBvbiBwYWdlIDIgLi4uKSBUag0KRVQNCmVuZHN0cmVhbQ0KZW5kb2JqDQoNCjYgMCBvYmoNCjw8DQovVHlwZSAvUGFnZQ0KL1BhcmVudCAzIDAgUg0KL1Jlc291cmNlcyA8PA0KL0ZvbnQgPDwNCi9GMSA5IDAgUiANCj4+DQovUHJvY1NldCA4IDAgUg0KPj4NCi9NZWRpYUJveCBbMCAwIDYxMi4wMDAwIDc5Mi4wMDAwXQ0KL0NvbnRlbnRzIDcgMCBSDQo+Pg0KZW5kb2JqDQoNCjcgMCBvYmoNCjw8IC9MZW5ndGggNjc2ID4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTcuMzc1MCA3MjIuMjgwMCBUZA0KKCBTaW1wbGUgUERGIEZpbGUgMiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIC4uLmNvbnRpbnVlZCBmcm9tIHBhZ2UgMS4gWWV0IG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NzYuNjU2MCBUZA0KKCBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY2NC43MDQwIFRkDQooIHRleHQuIE9oLCBob3cgYm9yaW5nIHR5cGluZyB0aGlzIHN0dWZmLiBCdXQgbm90IGFzIGJvcmluZyBhcyB3YXRjaGluZyApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY1Mi43NTIwIFRkDQooIHBhaW50IGRyeS4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NDAuODAwMCBUZA0KKCBCb3JpbmcuICBNb3JlLCBhIGxpdHRsZSBtb3JlIHRleHQuIFRoZSBlbmQsIGFuZCBqdXN0IGFzIHdlbGwuICkgVGoNCkVUDQplbmRzdHJlYW0NCmVuZG9iag0KDQo4IDAgb2JqDQpbL1BERiAvVGV4dF0NCmVuZG9iag0KDQo5IDAgb2JqDQo8PA0KL1R5cGUgL0ZvbnQNCi9TdWJ0eXBlIC9UeXBlMQ0KL05hbWUgL0YxDQovQmFzZUZvbnQgL0hlbHZldGljYQ0KL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcNCj4+DQplbmRvYmoNCg0KMTAgMCBvYmoNCjw8DQovQ3JlYXRvciAoUmF2ZSBcKGh0dHA6Ly93d3cubmV2cm9uYS5jb20vcmF2ZVwpKQ0KL1Byb2R1Y2VyIChOZXZyb25hIERlc2lnbnMpDQovQ3JlYXRpb25EYXRlIChEOjIwMDYwMzAxMDcyODI2KQ0KPj4NCmVuZG9iag0KDQp4cmVmDQowIDExDQowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDAwMTkgMDAwMDAgbg0KMDAwMDAwMDA5MyAwMDAwMCBuDQowMDAwMDAwMTQ3IDAwMDAwIG4NCjAwMDAwMDAyMjIgMDAwMDAgbg0KMDAwMDAwMDM5MCAwMDAwMCBuDQowMDAwMDAxNTIyIDAwMDAwIG4NCjAwMDAwMDE2OTAgMDAwMDAgbg0KMDAwMDAwMjQyMyAwMDAwMCBuDQowMDAwMDAyNDU2IDAwMDAwIG4NCjAwMDAwMDI1NzQgMDAwMDAgbg0KDQp0cmFpbGVyDQo8PA0KL1NpemUgMTENCi9Sb290IDEgMCBSDQovSW5mbyAxMCAwIFINCj4+DQoNCnN0YXJ0eHJlZg0KMjcxNA0KJSVFT0YNCg=="
    
    let mangoContent = "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"
    
    // MARK: - UI Components
    
    private lazy var navigateBtn: UIButton = {
        let btn = UIButton()
        
        self.view.addSubview(btn)
        
        btn.setTitle("Navigate 2", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        
        btn.addTarget(self, action: #selector(onNavigate), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Variables
    
    private let vm = ViewModel()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "First"
        
        view.backgroundColor = .lightGray
        
        self.navigateBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
//        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
//        let segmentBarItem = UIBarButtonItem(title: "New group", style: .plain, target: self, action: nil)
//        self.navigationItem.rightBarButtonItem = segmentBarItem
//
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
//        let info = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
//        self.navigationItem.leftBarButtonItems = [add, info]
    }
    
    // MARK: - Navigation
    
    @objc private func onNavigate() {
//        let sVC = SecondViewController()
//
//        self.navigationController?.pushViewController(sVC, animated: true)
        
//        self.tabBarController?.selectedIndex = 1
        
        // pick file
        
//        let documentPicker: UIDocumentPickerViewController
//
//        if #available(iOS 14, *) {
//             // iOS 14 & later
//             let supportedTypes: [UTType] = [UTType.png]
//             documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
//         } else {
//             // iOS 13 or older code
//             let supportedTypes: [String] = [ "image/png" ]
//             documentPicker = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
//         }
//
//
//        documentPicker.delegate = self
//        documentPicker.allowsMultipleSelection = false
//        present(documentPicker, animated: true)
        
        // create
        
//        saveBook(name: "1247", bookContentBase64: bookContentBase64)
        
        // share
        
        guard let pdfData = Data(base64Encoded: mangoContent, options: .ignoreUnknownCharacters) else {
            print("Book load error")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func getFilePath() -> URL? {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryURl = documentDirectoryURL.appendingPathComponent("Books", isDirectory: true)
        
        if FileManager.default.fileExists(atPath: directoryURl.path) {
            return directoryURl
        } else {
            do {
                try FileManager.default.createDirectory(at: directoryURl, withIntermediateDirectories: true, attributes: nil)
                return directoryURl
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
    }

    fileprivate func saveBook(name: String, bookContentBase64: String) {
        
        guard let directoryURl = getFilePath() else {
            print("Book save error")
            return
        }
        
        let fileURL = directoryURl.appendingPathComponent("Book-\(name).pdf")
        
        guard let data = Data(base64Encoded: bookContentBase64, options: .ignoreUnknownCharacters) else {
            print("Book load error")
            return
        }
        
        do {
            try data.write(to: fileURL, options: .atomic)
            print("Invoice downloaded successfully")
            print(fileURL.absoluteString)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UIDocumentPickerDelegate {

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancelled")
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        dismiss(animated: true)

        guard url.startAccessingSecurityScopedResource() else {
            return
        }

        defer {
            url.stopAccessingSecurityScopedResource()
        }

        // Copy the file with FileManager
        
        
        do {
            let imageData = try Data(contentsOf: url)
        } catch {
            print("Unable to load data: \(error)")
        }
        
        print(url.absoluteString)
    }
}
