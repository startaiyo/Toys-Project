//
//  PatternMatchingView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/31.
//

import SwiftUI

let importedJson = [
    "name": "tarou",
    "age": 24,
    "hobby": "game"
] as [String: Any]

struct PatternMatchingView: View {
    let akashi = (long: 135, lat: 34)
    let greenwich = (long: 0, lat: 51)
    let equador = (long: -78, lat: 0)
    let seoul = (long: 127, lat: 37)

    @State var inArray: Bool = false
    // long, lat
    var body: some View {
        Text("isAkashi: \(isAkashi(coordinates: akashi))")
        Text("isAkashi: \(isAkashi(coordinates: greenwich))")
        Text("isUnderEquator: \(isUnderEquator(coordinates: equador))")
        Text("isUnderEquator: \(isUnderEquator(coordinates: akashi))")
        Text("distance to Japan \(distanceToJapan(coordinates: akashi))")
        Text("distance to Japan \(distanceToJapan(coordinates: greenwich))")
        Text("distance to Japan \(distanceToJapan(coordinates: seoul))")
        Text("distance to Japan \(distanceToJapan(coordinates: equador))")
        Text("place: \(locationDescription(coordinates: akashi))")
        Text("place: \(locationDescription(coordinates: greenwich))")
        Text("place: \(locationDescription(coordinates: seoul))")
        Text("place: \(locationDescription(coordinates: equador))")

        Text(extractAge(from: importedJson))

        Text(30...40 ~= 35 ? "yes": "no")
        Text(inArray ? "yes": "no")
            .onAppear {
                let citiesLongs = [akashi, greenwich, equador, seoul].map { $0.long }
                inArray = (citiesLongs ~= 135)
            }
    }
}

func extractAge(from json: [String: Any]) -> String {
    var ageData = ""
    for data in json.values {
        switch data {
            case let age as Int:
                ageData = "\(age)"
            default:
                break
        }
    }
    return ageData
}

func isAkashi(coordinates: (long: Int, lat: Int)) -> String {
    if case (135, 34) = coordinates {
        return "yes"
    }
    return "no"
}

func distanceToJapan(coordinates: (long: Int, lat: Int)) -> String {
    let closeLongRange = 125...145
    let closeLatRange = 30...40
    let sameHemisphereLongRange = 0...90
    let sameHemisphereLatRange = 0...180
    switch coordinates {
        case (135, 34):
            return "at Japan"
        case (closeLongRange, closeLatRange):
            return "close to Japan"
        case (sameHemisphereLongRange, sameHemisphereLatRange):
            return "the same side as Japan"
        default:
            return "very far from Japan"
    }
}

func isUnderEquator(coordinates: (long: Int, lat: Int)) -> String {
    if case (_, 0) = coordinates {
        return "yes"
    }
    return "no"
}

func locationDescription(coordinates: (long: Int, lat: Int)) -> String {
    switch coordinates {
        case _ where coordinates.lat > 0:
            return "northern hemisphere"
        case _ where coordinates.long > 0:
            return "Eurasia"
        default:
            return "Far from Japan, anyway"
    }
}

func ~=(pattern: [Int], value: Int) -> Bool {
    for p in pattern {
        if p == value {
            return true
        }
    }
    return false
}
