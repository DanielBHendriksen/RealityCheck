//
//  ModelGeneratorService.swift
//  RealityCheck
//
//  Created by Daniel Hendriksen on 15/06/2025.
//

import Foundation

class ModelGeneratorService {
    static let shared = ModelGeneratorService() // Singleton

    private let baseURL = "https://192a-147-78-30-156.ngrok-free.app"

    func generateAndPreviewModel(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/generate_model") else {
            print("Invalid backend URL")
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonBody = ["product_name": "ball"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                completion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }

            print("Raw response:")
            print(String(data: data, encoding: .utf8) ?? "Unreadable response")

            do {
                let result = try JSONDecoder().decode(ModelResponse.self, from: data)
                print("Decoded model_url: \(result.model_url)")
                self.downloadUSDZ(from: "\(self.baseURL)\(result.model_url)", completion: completion)
            } catch {
                print("Failed to decode response: \(error)")
                completion(false)
            }
        }

        task.resume()
    }

    private func downloadUSDZ(from urlString: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid model URL")
            completion(false)
            return
        }

        let task = URLSession.shared.downloadTask(with: url) { location, response, error in
            if let error = error {
                print("Download error: \(error)")
                completion(false)
                return
            }

            guard let location = location else {
                print("Download location is nil")
                completion(false)
                return
            }

            let fileManager = FileManager.default
            let fileName = url.lastPathComponent
            let destinationURL = fileManager.temporaryDirectory.appendingPathComponent(fileName)

            do {
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }

                try fileManager.moveItem(at: location, to: destinationURL)
                print("Saved USDZ to: \(destinationURL)")

                DispatchQueue.main.async {
                    QuickLookLauncher.presentUSDZ(from: destinationURL)
                    completion(true)
                }
            } catch {
                print("File move error: \(error)")
                completion(false)
            }
        }

        task.resume()
    }
}
