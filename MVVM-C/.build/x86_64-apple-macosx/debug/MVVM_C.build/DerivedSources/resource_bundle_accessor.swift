import class Foundation.Bundle

extension Foundation.Bundle {
    static var module: Bundle = {
        let mainPath = Bundle.main.bundlePath + "/" + "MVVM-C_MVVM-C.bundle"
        let buildPath = "/Users/valiantsin_vasiliavi/Desktop/MVVM-C-Hometask/MVVM-C/.build/x86_64-apple-macosx/debug/MVVM-C_MVVM-C.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle != nil ? preferredBundle : Bundle(path: buildPath) else {
            fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}