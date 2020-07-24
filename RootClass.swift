//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RootClass : Codable {

	let sources : [Source]?
	let status : String?


	enum CodingKeys: String, CodingKey {
		case sources = "sources"
		case status = "status"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sources = try values.decodeIfPresent([Source].self, forKey: .sources)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}


}