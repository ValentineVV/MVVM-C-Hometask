import Danger 
 let danger = Danger()

// Loop through all new files, then
let swiftFilesWithCopyright = danger.git.createdFiles.filter {
  $0.fileType == .swift && danger.utils.readFile($0).contains("//  Created by")
}

if swiftFilesWithCopyright.count > 0 {
    let files = swiftFilesWithCopyright.joined(separator: ", ")
    warn("In Danger JS we don't include copyright headers, found them in: \(files)")
}

let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("These files have changed: \(editedFiles.joined(separator: ", "))")
