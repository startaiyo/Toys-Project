//
//  RootListView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import SwiftUI

struct RootListView: View {
    var body: some View {
        List {
            NavigationLink(destination: DiffableDataSourcePageViewControllerRepresentable()) {
                Text("DiffableDataSourcePageViewController")
            }
            NavigationLink(destination: DataSourcePageViewControllerRepresentable()) {
                Text("DataSourcePageViewController")
            }
        }
    }
}
