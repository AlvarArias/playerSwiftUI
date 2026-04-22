//
//  newXMLSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI

struct ScheduleView: View {
    let parser: ScheduleParser

    private let dateTransformer = DateTransformer()

    var body: some View {
        ScrollView {
            if parser.isLoading {
                ProgressView()
                    .padding()
            } else if parser.episodes.isEmpty {
                Text("Ingen information tillgänglig")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<min(5, parser.episodes.count), id: \.self) { index in
                        let ep = parser.episodes[index]
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(ep.title).font(.body)
                                Spacer()
                                Text(dateTransformer.transformDate(theProgramDate: ep.startTimeUTC))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Text(ep.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        Divider()
                    }
                }
            }
        }
        .background(Color.newColorGreenLight)
    }
}
