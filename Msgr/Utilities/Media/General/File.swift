//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

class File: NSObject {

    class func temp(id: String? = nil, ext: String) -> String {
		let name = id ?? UUID().uuidString
		let file = "\(name).\(ext)"
		return Dir.cache(file)
	}

	class func exist(_ path: String) -> Bool {
		return FileManager.default.fileExists(atPath: path)
	}

	class func remove(_ path: String) {
		try? FileManager.default.removeItem(at: URL(fileURLWithPath: path))
	}

	class func copy(from source: String, to dest: String, _ overwrite: Bool) {
		if overwrite { remove(dest) }
		if !exist(dest) {
			try? FileManager.default.copyItem(atPath: source, toPath: dest)
		}
	}
}

extension File {

	class func created(_ path: String) -> Date {
		let attributes = try! FileManager.default.attributesOfItem(atPath: path)
		return attributes[.creationDate] as! Date
	}

	class func modified(_ path: String) -> Date {
		let attributes = try! FileManager.default.attributesOfItem(atPath: path)
		return attributes[.modificationDate] as! Date
	}

	class func size(_ path: String) -> Int64 {
		let attributes = try! FileManager.default.attributesOfItem(atPath: path)
		return attributes[.size] as! Int64
	}

	class func diskFree() -> Int64 {
		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let attributes = try! FileManager.default.attributesOfFileSystem(forPath: path)
		return attributes[.systemFreeSize] as! Int64
	}
}
